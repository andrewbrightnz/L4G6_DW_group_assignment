# Task 5D: Compare Airbnb nightly prices with median weekly rent / 7.
# The same Airbnb listing can appear in several months, as in the original analysis.
task_5D <- function() {
  library(dplyr)
  library(ggplot2)
  library(readr)

  data_path <- "Deliverable 5 - Join datasets and store in SQLite database/Data/airbnb_and_rental_data_Oct25_to_Jun26_cleaned_with_location_id.csv"
  output_dir <- "Deliverable 5 - Join datasets and store in SQLite database/Output/task_5D"
  min_listings <- 10

  joined_data <- read_csv(data_path, show_col_types = FALSE) |>
    filter(!is.na(`Median Rent`), !is.na(price)) |>
    mutate(price_gap_per_night = price - `Median Rent` / 7)

  area_summary <- joined_data |>
    group_by(`Location Id`) |>
    summarise(
      listing_count = n_distinct(id),
      median_gap = median(price_gap_per_night),
      .groups = "drop"
    ) |>
    filter(listing_count >= min_listings) |>
    arrange(desc(median_gap))

  if (nrow(area_summary) == 0) stop("No areas have enough listings for Task 5D.")
  top_10 <- head(area_summary, 10)
  print(top_10)

  plot <- ggplot(top_10, aes(x = reorder(as.character(`Location Id`), median_gap),
                             y = median_gap)) +
    geom_col(fill = "#3366A3") +
    coord_flip() +
    labs(title = "Largest Airbnb–rental nightly price gaps",
         subtitle = "Top 10 areas with at least 10 Airbnb listings",
         x = "SA2 location code", y = "Median nightly gap (NZD)") +
    theme_minimal()

  dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)
  ggsave(file.path(output_dir, "median_price_gap_top_10.png"), plot,
         width = 9, height = 6, dpi = 150, bg = "white")
  invisible(top_10)
}
