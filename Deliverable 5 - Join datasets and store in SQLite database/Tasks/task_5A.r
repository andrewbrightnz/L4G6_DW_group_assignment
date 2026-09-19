# Andrew: Use Koordinates API to create a .csv of codes and SA2 names

# api_requests_v5.R
# For each row in the Airbnb CSV, query the Koordinates vector layer at its
# lat/lon and add the SA2 code as a new column.
#
# Set your API key first:
#   Sys.setenv(KOORDINATES_API_KEY = "your_key_here")
# Check the APIKey value:features
#   Sys.getenv("KOORDINATES_API_KEY")

task_5A <- function() {
# Install packages only if not already installed
required_packages <- c("httr2", "readr")
for (pkg in required_packages) {
if (!requireNamespace(pkg, quietly = TRUE)) {
    install.packages(pkg)
}
}

library(httr2)
library(readr)

api_key  <- Sys.getenv("KOORDINATES_API_KEY")
layer_id <- "120978"

output_path <- "Deliverable 5 - Join datasets and store in SQLite database/Data/airbnb_chch_Oct25_to_Jun26_cleaned_with_location_id.csv"
batch_size  <- 5

# Resume from a previous partial run if one was already saved, so completed
# rows aren't queried again; otherwise start fresh from the cleaned dataset.
if (file.exists(output_path)) {
df <- read_csv(output_path, show_col_types = FALSE)
} else {
df <- read_csv("Deliverable 5 - Join datasets and store in SQLite database/Data/airbnb_chch_Oct25_to_Jun26_cleaned.csv", show_col_types = FALSE)
message("Task 5A: Final checks after before Location Id")
# sum of how many missing values are in each column
print(colSums(is.na(df)))

df$`Location Id` <- NA_character_
}

rows_to_query <- which(is.na(df$`Location Id`))
message(sprintf("%d of %d rows already have a Location Id; querying the remaining %d.",
                nrow(df) - length(rows_to_query), nrow(df), length(rows_to_query)))

# Query the API in small batches, saving progress after each one and pausing
# briefly in between so the requests aren't sent in one uninterrupted burst
# (which is what makes Koordinates' servers treat it like a DDOS attack).
if (length(rows_to_query) > 0) {
for (batch_start in seq(1, length(rows_to_query), by = batch_size)) {
batch_end  <- min(batch_start + batch_size - 1, length(rows_to_query))
batch_rows <- rows_to_query[batch_start:batch_end]

for (i in batch_rows) {
    message(sprintf("Running row %d of %d", i, nrow(df)))
    resp <- request("https://koordinates.com/services/query/v1/vector.json") |>
    req_url_query(
        key   = api_key,
        layer = layer_id,
        x     = df$longitude[i],   # x = longitude
        y     = df$latitude[i]     # y = latitude
    ) |>
    req_perform()

    body  <- resp_body_json(resp)
    feats <- body$vectorQuery$layers[[layer_id]]$features

    if (length(feats) > 0) {
    df$`Location Id`[i] <- feats[[1]]$properties$SA22025_V1_00
    }
}

message(sprintf("Batch %d-%d of %d done, saving progress...", batch_start, batch_end, length(rows_to_query)))
write_csv(df, output_path)

Sys.sleep(1)  # brief pause between batches
}
message("New csv written")
}

# Read the rental data that Task_5A filtered and saved to disk
airbnb_chch_Oct25_to_Jun26_cleaned_with_location_id <- read_csv(
    "Deliverable 5 - Join datasets and store in SQLite database/Data/airbnb_chch_Oct25_to_Jun26_cleaned_with_location_id.csv",
    show_col_types = FALSE)

message()
message("Task 5A: Number of missing values after adding Location Id")
# sum of how many missing values are in each column
print(colSums(is.na(airbnb_chch_Oct25_to_Jun26_cleaned_with_location_id)))
message()

return(airbnb_chch_Oct25_to_Jun26_cleaned_with_location_id)
}