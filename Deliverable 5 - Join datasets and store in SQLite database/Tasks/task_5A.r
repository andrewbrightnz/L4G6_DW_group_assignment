# Task 5A: Add SA2 location codes to the cleaned Airbnb data.
# Completed API results are saved so a long run can be resumed.
task_5A <- function() {
  library(httr2)
  library(readr)

  # Config
  input_path <- "Deliverable 5 - Join datasets and store in SQLite database/Data/airbnb_chch_Oct25_to_Jun26_cleaned.csv"
  output_path <- "Deliverable 5 - Join datasets and store in SQLite database/Data/airbnb_chch_Oct25_to_Jun26_cleaned_with_location_id.csv"
  layer_id <- "120978"
  batch_size <- 5

  input <- read_csv(input_path, show_col_types = FALSE)
  if (file.exists(output_path)) {
    df <- read_csv(output_path, show_col_types = FALSE)
    same_input <- nrow(df) == nrow(input) &&
      all(vapply(names(input), function(column) {
        identical(as.character(df[[column]]), as.character(input[[column]]))
      }, logical(1)))
    if (!same_input) {
      stop("Saved SA2 results do not match the cleaned Airbnb input. Check the files before rerunning Task 5A.")
    }
  } else {
    df <- input
    df$`Location Id` <- NA_character_
  }

  # Find the first unprocessed row
  rows_to_query <- which(is.na(df$`Location Id`))
  message(length(rows_to_query), " of ", nrow(df), " rows need an SA2 code.")
  if (length(rows_to_query) == 0) return(df)

  # Check the API key has been set
  api_key <- Sys.getenv("KOORDINATES_API_KEY")
  if (!nzchar(api_key)) stop("Set KOORDINATES_API_KEY before querying missing SA2 codes.")

  # Loop to run batches
  for (batch_start in seq(1, length(rows_to_query), by = batch_size)) {
    batch_end <- min(batch_start + batch_size - 1, length(rows_to_query))
    batch_rows <- rows_to_query[batch_start:batch_end]
  
    # Process each batch
    for (i in batch_rows) {
      response <- request("https://koordinates.com/services/query/v1/vector.json") |>
        req_url_query(key = api_key, layer = layer_id,
                      x = df$longitude[i], y = df$latitude[i]) |>
        req_perform()
      features <- resp_body_json(response)$vectorQuery$layers[[layer_id]]$features
      if (length(features) > 0) {
        df$`Location Id`[i] <- features[[1]]$properties$SA22025_V1_00
      }
    }

    # Save each batch
    write_csv(df, output_path)
    message("Task 5A: saved batch ", batch_start, "-", batch_end,
            " of ", length(rows_to_query))
    Sys.sleep(1)
  }

  message("Task 5A: ", sum(is.na(df$`Location Id`)), " rows still have no Location Id.")
  df
}
