library(yaml)
library(readr)
library(dplyr)
library(tidyr)

cfg <- yaml::read_yaml("config.yaml")
df <- read_csv("data/intermediate/chch_airbnb_stacked.csv", show_col_types = FALSE)

cleaned <- df |>
  select(id, name, host_id, neighbourhood, latitude, longitude, room_type, price, MonthYear, DataDate) |>
  distinct() |>
  mutate(price = parse_number(as.character(price)))

# Fail-fast spatial boundary check: drop invalid coordinates and warn
in_bounds <- cleaned$latitude >= cfg$airbnb$lat_range[[1]] &
             cleaned$latitude <= cfg$airbnb$lat_range[[2]] &
             cleaned$longitude >= cfg$airbnb$lon_range[[1]] &
             cleaned$longitude <= cfg$airbnb$lon_range[[2]]

out_of_bounds_count <- sum(!in_bounds)
if (out_of_bounds_count > 0) {
  warning("Excluding ", out_of_bounds_count, " listings outside Christchurch geographic bounds.")
  cleaned <- cleaned[in_bounds, ]
}

# Treat outlier prices (> $7000) or non-positive values as missing
cleaned <- cleaned |>
  mutate(price = if_else(price > cfg$airbnb$price_max_plausible | price <= 0, NA_real_, price)) |>
  arrange(id, MonthYear) |>
  group_by(id) |>
  fill(price, .direction = "downup") |>
  ungroup()

na_prices <- sum(is.na(cleaned$price))
if (na_prices > 0) {
  warning("Price imputation complete: ", na_prices, " rows still lack price and will be dropped.")
  cleaned <- cleaned |> filter(!is.na(price))
}

write_csv(cleaned, "data/intermediate/chch_airbnb_cleaned.csv")
message("Step 02 finished: Cleaned Airbnb records = ", nrow(cleaned))
