task_5E <- function(output_dir = NULL) {
  library(dplyr)
  library(readr)
  library(tidyr)
  library(ggplot2)
  library(lubridate)

  d5 <- "Deliverable 5 - Join datasets and store in SQLite database"
  if (!dir.exists(d5)) {
    d5 <- "Deliverable 5 - Join datasets and store in  SQLite database"
  }
  if (is.null(output_dir)) output_dir <- file.path(d5, "Output", "task_5E")

  airbnb <- read_csv(
    file.path(d5, "Data", "airbnb_chch_Oct25_to_Jun26_cleaned_with_location_id.csv"),
    col_types = cols(.default = col_character()), na = c("", "NA", "NULL")
  )
  rental <- read_csv(
    "Deliverable 4 - Clean bond data/Data/bond_data_Oct25_to_Jun26.csv",
    col_types = cols(.default = col_character()), na = c("", "NA", "NULL")
  )
  areas <- read_csv(
    file.path(d5, "Miscellaneous", "SA2_2025_codes_and_names.csv"),
    col_types = cols(.default = col_character())
  ) |>
    transmute(location_id = SA22025_V1, area_name = SA22025__1)

  periods <- as.Date(c("2025-10-01", "2026-01-01", "2026-04-01"))
  airbnb <- airbnb |>
    transmute(id, location_id = `Location Id`, month = my(MonthYear, locale = "C"),
              quarter = floor_date(month, "quarter"))
  stopifnot(!anyNA(airbnb))
  airbnb <- filter(airbnb, quarter %in% periods)
  stopifnot(n_distinct(airbnb$month) == 9)
  mapping_check <- airbnb |> distinct(id, month, location_id) |> count(id, month)
  stopifnot(all(mapping_check$n == 1))

  airbnb_counts <- airbnb |>
    group_by(location_id, quarter) |>
    summarise(airbnb_listings = n_distinct(id), .groups = "drop")

  rental_counts <- rental |>
    filter(`Dwelling Type` == "ALL", `Number Of Beds` == "ALL",
           !is.na(`Location Id`), `Location Id` != "-99") |>
    transmute(location_id = `Location Id`, quarter = as.Date(TimeFrame),
              active_bonds = parse_double(`Active Bonds`), bond_record = TRUE) |>
    filter(quarter %in% periods) |>
    distinct()
  stopifnot(!anyDuplicated(rental_counts[c("location_id", "quarter")]),
            !anyDuplicated(areas$location_id))

  comparison <- expand_grid(location_id = sort(unique(airbnb$location_id)), quarter = periods) |>
    left_join(airbnb_counts, by = c("location_id", "quarter")) |>
    mutate(airbnb_listings = replace_na(airbnb_listings, 0L)) |>
    left_join(rental_counts, by = c("location_id", "quarter")) |>
    left_join(areas, by = "location_id") |>
    mutate(area_name = coalesce(area_name, location_id),
           bond_status = case_when(
             is.na(bond_record) ~ "No aggregate bond record",
             is.na(active_bonds) ~ "Count missing or suppressed",
             TRUE ~ "Available")) |>
    select(location_id, area_name, quarter, airbnb_listings, active_bonds, bond_status) |>
    arrange(quarter, location_id)

  unmatched <- filter(comparison, is.na(active_bonds))
  summary <- comparison |>
    group_by(quarter) |>
    summarise(areas_in_scope = n(),
              areas_with_bond_count = sum(!is.na(active_bonds)),
              areas_without_bond_count = sum(is.na(active_bonds)),
              airbnb_area_listing_count = sum(airbnb_listings),
              airbnb_area_listing_count_without_bonds = sum(airbnb_listings[is.na(active_bonds)]),
              .groups = "drop")

  top_areas <- comparison |>
    filter(quarter == max(periods), !is.na(active_bonds)) |>
    arrange(desc(airbnb_listings), location_id) |>
    slice_head(n = 20) |>
    mutate(area_label = paste0(area_name, " (", location_id, ")"))
  plot_data <- top_areas |>
    select(area_label, airbnb_listings, active_bonds) |>
    pivot_longer(c(airbnb_listings, active_bonds), names_to = "type", values_to = "count")
  plot_data$area_label <- factor(plot_data$area_label, levels = rev(top_areas$area_label))

  plot <- ggplot(plot_data, aes(area_label, count, fill = type)) +
    geom_col(position = "dodge") +
    coord_flip() +
    scale_fill_manual(values = c(active_bonds = "#D18A28", airbnb_listings = "#3366A3"),
                      labels = c(active_bonds = "Reported active rental bonds",
                                 airbnb_listings = "Airbnb listings observed in quarter")) +
    labs(title = "Airbnb listings and active rental bonds by area",
         subtitle = "April-June 2026: top 20 matched areas by Airbnb listing count",
         x = NULL, y = "Count", fill = NULL,
         caption = "Active bonds are a rental-property proxy. Missing bond counts are not zero.\nFull CSV covers areas in the Airbnb sample. SA2 boundaries and time definitions still need checking.") +
    theme_minimal() +
    theme(legend.position = "top", plot.caption = element_text(hjust = 0))

  dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)
  write_csv(comparison, file.path(output_dir, "property_counts_by_area_quarter.csv"))
  write_csv(unmatched, file.path(output_dir, "areas_missing_bond_counts.csv"))
  write_csv(summary, file.path(output_dir, "coverage_by_quarter.csv"))
  ggsave(file.path(output_dir, "property_counts_by_area_quarter.png"), plot,
         width = 13, height = 9, dpi = 150, bg = "white")

  print(summary)
  message(nrow(unmatched), " area-quarter comparisons have no bond count; these remain NA.")
  return(list(comparison = comparison, plot = plot, summary = summary, unmatched = unmatched))
}
