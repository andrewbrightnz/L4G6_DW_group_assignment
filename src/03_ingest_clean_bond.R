library(yaml)
library(readr)
library(dplyr)

cfg <- yaml::read_yaml("config.yaml")
raw_bond_path <- "data/raw/bond_data.csv"

if (!file.exists(raw_bond_path)) {
  message("Downloading MBIE rental bond data...")
  download.file(cfg$bond$url, raw_bond_path, mode = "wb", quiet = TRUE)
}

bonds <- read_csv(
  raw_bond_path,
  col_types = cols(
    TimeFrame = col_character(),
    `Location Id` = col_character(),
    `Dwelling Type` = col_character(),
    `Number Of Beds` = col_character(),
    `Total Bonds` = col_double(),
    `Active Bonds` = col_double(),
    `Median Rent` = col_double(),
    `Geometric Mean Rent` = col_double(),
    `Upper Quartile Rent` = col_double(),
    `Lower Quartile Rent` = col_double(),
    .default = col_skip()
  ),
  na = c("", "NULL", "NA"),
  show_col_types = FALSE
)

# Fail-fast assertion
stopifnot("Required bond columns missing" = all(c("TimeFrame", "Location Id") %in% names(bonds)))

start_dt <- as.Date(cfg$bond$start_date)
end_dt <- as.Date(cfg$bond$end_date_exclusive)

cleaned_bonds <- bonds |>
  mutate(TimeFrame = as.Date(TimeFrame)) |>
  filter(
    TimeFrame >= start_dt,
    TimeFrame < end_dt,
    !is.na(`Location Id`),
    `Location Id` != "-99"
  ) |>
  distinct()

write_csv(cleaned_bonds, "data/intermediate/rental_bonds_cleaned.csv")
message("Step 03 finished: Filtered bond rows = ", nrow(cleaned_bonds))
