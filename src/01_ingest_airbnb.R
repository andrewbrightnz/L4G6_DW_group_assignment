library(yaml)
library(readr)
library(dplyr)
library(purrr)

cfg <- yaml::read_yaml("config.yaml")
dir.create("data/raw", recursive = TRUE, showWarnings = FALSE)
dir.create("data/intermediate", recursive = TRUE, showWarnings = FALSE)

fetch_and_tag <- function(url, month_year, scrape_date) {
  fname <- file.path("data/raw", paste0("listings_", gsub(" ", "_", month_year), ".csv"))
  if (!file.exists(fname)) {
    message("Downloading: ", month_year)
    download.file(url, fname, mode = "wb", quiet = TRUE)
  }
  read_csv(fname, show_col_types = FALSE) |>
    mutate(
      MonthYear = month_year,
      DataDate = as.Date(scrape_date)
    )
}

snapshots <- bind_rows(lapply(cfg$airbnb$snapshots, as.data.frame))
nz_combined <- pmap_dfr(snapshots, function(month_year, scrape_date, url) {
  fetch_and_tag(url, month_year, scrape_date)
})

# Defensive check: ensure data downloaded
stopifnot("Airbnb ingestion returned 0 rows" = nrow(nz_combined) > 0)

chch_combined <- nz_combined |>
  filter(neighbourhood_group == cfg$airbnb$target_neighbourhood) |>
  mutate(MonthYear = factor(MonthYear, levels = snapshots$month_year))

# Defensive check: Christchurch filter
stopifnot("Filtered Christchurch dataset is empty" = nrow(chch_combined) > 0)

write_csv(chch_combined, "data/intermediate/chch_airbnb_stacked.csv")
message("Step 01 finished: ", nrow(chch_combined), " Christchurch rows across ", nrow(snapshots), " months.")
