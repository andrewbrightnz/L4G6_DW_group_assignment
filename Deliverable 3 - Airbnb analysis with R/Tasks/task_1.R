## Ingest monthly Inside Airbnb datasets, filter for Christchurch, and combine

library(readr)
library(dplyr)
library(purrr)

# Visible Pipeline Parameters
target_neighbourhood <- "Christchurch City"
output_chch_path <- "out/data/chch_Oct25_to_Aug26.csv"
output_nz_path   <- "out/data/nz_Oct25_to_Aug26.csv"

scrape_metadata <- tibble::tribble(
  ~month_year,   ~scrape_date,  ~url,
  "Oct 2025",   "2025-10-05",  "https://data.insideairbnb.com/new-zealand/2025-10-05/visualisations/listings.csv",
  "Nov 2025",   "2025-11-07",  "https://data.insideairbnb.com/new-zealand/2025-11-07/visualisations/listings.csv",
  "Dec 2025",   "2025-12-11",  "https://data.insideairbnb.com/new-zealand/2025-12-11/visualisations/listings.csv",
  "Jan 2026",   "2026-01-16",  "https://data.insideairbnb.com/new-zealand/2026-01-16/visualisations/listings.csv",
  "Feb 2026",   "2026-02-13",  "https://data.insideairbnb.com/new-zealand/2026-02-13/visualisations/listings.csv",
  "March 2026", "2026-03-17",  "https://data.insideairbnb.com/new-zealand/2026-03-17/visualisations/listings.csv",
  "April 2026", "2026-04-16",  "https://data.insideairbnb.com/new-zealand/2026-04-16/visualisations/listings.csv",
  "May 2026",   "2026-05-23",  "https://data.insideairbnb.com/new-zealand/2026-05-23/visualisations/listings.csv",
  "June 2026",  "2026-06-19",  "https://data.insideairbnb.com/new-zealand/2026-06-19/visualisations/listings.csv",
  "July 2026",  "2026-07-12",  "https://data.insideairbnb.com/new-zealand/2026-07-12/visualisations/listings.csv",
  "August 2026", "2026-08-13", "https://data.insideairbnb.com/new-zealand/2026-08-13/visualisations/listings.csv"
)

fetch_and_tag <- function(url, month_year, scrape_date) {
  # Cache each snapshot so subsequent runs only download new months.
  dir.create("out/raw", recursive = TRUE, showWarnings = FALSE)
  cache_path <- file.path("out/raw", paste0("listings_", scrape_date, ".csv"))
  if (!file.exists(cache_path)) {
    message("Downloading ", month_year)
    temporary_path <- tempfile(tmpdir = "out/raw", fileext = ".csv")
    on.exit(unlink(temporary_path), add = TRUE)
    download.file(url, temporary_path, mode = "wb", quiet = TRUE)
    stopifnot("Could not save downloaded snapshot" = file.rename(temporary_path, cache_path))
  }
  read_csv(cache_path, show_col_types = FALSE,
           col_types = cols(license = col_character())) |>
    mutate(
      MonthYear = month_year,
      DataDate = as.Date(scrape_date)
    )
}

ingest_datasets <- function() {
  dir.create("out/data", recursive = TRUE, showWarnings = FALSE)
  
  # Functional mapping replacing repetitive read statements
  nz_combined <- pmap_dfr(scrape_metadata, function(month_year, scrape_date, url) {
    fetch_and_tag(url, month_year, scrape_date)
  })
  
  # Defensive assertion
  stopifnot("Raw ingestion returned 0 rows" = nrow(nz_combined) > 0)
  
  chch_combined <- nz_combined |>
    filter(neighbourhood_group == target_neighbourhood) |>
    mutate(MonthYear = factor(MonthYear, levels = scrape_metadata$month_year))
  
  stopifnot("Christchurch filter produced an empty dataset" = nrow(chch_combined) > 0)

  write_csv(nz_combined, output_nz_path)
  write_csv(chch_combined, output_chch_path)
  
  invisible(chch_combined)
}
