# Produce suitable summary statistics for all columns (categories + counts or
# min + max + mean + std) and the number of missing values per column.
# Store the summary of the concatenated dataset in a new file.

task_2 <- function(chch_Oct25_to_Jun26) {

  summarise_column <- function(column_name) {
    values <- chch_Oct25_to_Jun26[[column_name]]
    missing <- sum(is.na(values))
    data_type <- class(values)[1]

    if (is.numeric(values) || inherits(values, "Date")) {
      valid_values <- values[!is.na(values)]
      numeric_column <- is.numeric(values)

      return(tibble(
        column = column_name,
        data_type = data_type,
        category = NA_character_,
        category_count = NA_integer_,
        minimum = if (length(valid_values) > 0) {
          as.character(min(valid_values))
        } else {
          NA_character_
        },
        maximum = if (length(valid_values) > 0) {
          as.character(max(valid_values))
        } else {
          NA_character_
        },
        mean = if (numeric_column && length(valid_values) > 0) {
          mean(valid_values)
        } else {
          NA_real_
        },
        standard_deviation = if (numeric_column && length(valid_values) > 1) {
          sd(valid_values)
        } else {
          NA_real_
        },
        missing_count = missing
      ))
    }

    category_summary <- tibble(category = as.character(values)) |>
      filter(!is.na(category)) |>
      count(category, name = "category_count", sort = TRUE)

    # Keep one row when a column, such as license, is completely missing.
    if (nrow(category_summary) == 0) {
      category_summary <- tibble(
        category = NA_character_,
        category_count = 0L
      )
    }

    category_summary |>
      mutate(
        column = column_name,
        data_type = data_type,
        minimum = NA_character_,
        maximum = NA_character_,
        mean = NA_real_,
        standard_deviation = NA_real_,
        missing_count = missing,
        .before = 1
      )
  }

  summary_stats <- map_dfr(
    names(chch_Oct25_to_Jun26),
    summarise_column
  )

  dir.create("Data", showWarnings = FALSE)

  write_csv(
    summary_stats,
    "Data/chch_Oct25_to_Jun26_summary_stats.csv",
    na = ""
  )

  invisible(summary_stats)
}
