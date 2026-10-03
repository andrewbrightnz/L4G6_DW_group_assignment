library(yaml)
library(readr)
library(dplyr)
library(httr2)

cfg <- yaml::read_yaml("config.yaml")
airbnb <- read_csv("data/intermediate/chch_airbnb_cleaned.csv", show_col_types = FALSE)
cache_file <- "data/intermediate/sa2_cache.csv"

# Pre-populate cache from Deliverable 5 so we don't re-query historical coordinates
if (!file.exists(cache_file)) {
  old_d5 <- "Deliverable 5 - Join datasets and store in SQLite database/Data/airbnb_chch_Oct25_to_Jun26_cleaned_with_location_id.csv"
  if (file.exists(old_d5)) {
    seed <- read_csv(old_d5, col_types = cols(`Location Id` = col_character(), .default = col_guess()), show_col_types = FALSE) |>
      distinct(latitude, longitude, `Location Id`) |>
      filter(!is.na(`Location Id`))
    write_csv(seed, cache_file)
    message("Initialized SA2 cache using Deliverable 5 data.")
  }
}

if (file.exists(cache_file)) {
  cache <- read_csv(cache_file, col_types = cols(`Location Id` = col_character(), .default = col_double()), show_col_types = FALSE)
} else {
  cache <- tibble(latitude = numeric(), longitude = numeric(), `Location Id` = character())
}

# Identify coordinates that have never been looked up before
unique_coords <- airbnb |>
  distinct(latitude, longitude) |>
  left_join(cache, by = c("latitude", "longitude"))

missing_coords <- unique_coords |> filter(is.na(`Location Id`))

if (nrow(missing_coords) > 0) {
  api_key <- Sys.getenv("KOORDINATES_API_KEY")
  if (!nzchar(api_key)) {
    stop("KOORDINATES_API_KEY environment variable is not set.")
  }
  
  message("Querying Koordinates API for ", nrow(missing_coords), " new coordinate pairs...")
  new_lookups <- list()
  for (i in seq_len(nrow(missing_coords))) {
    lon <- missing_coords$longitude[i]
    lat <- missing_coords$latitude[i]
    
    req <- request(cfg$koordinates$base_url) |>
      req_url_query(key = api_key, layer = cfg$koordinates$layer_id, x = lon, y = lat)
    
    res <- tryCatch(req_perform(req), error = function(e) NULL)
    loc_id <- NA_character_
    
    if (!is.null(res)) {
      body <- resp_body_json(res)
      features <- body$vectorQuery$layers[[cfg$koordinates$layer_id]]$features
      if (length(features) > 0) {
        loc_id <- as.character(features[[1]]$properties$SA22025_V1_00)
      }
    }
    new_lookups[[i]] <- tibble(latitude = lat, longitude = lon, `Location Id` = loc_id)
    
    if (i %% 20 == 0 || i == nrow(missing_coords)) {
      message("Queried ", i, "/", nrow(missing_coords))
      Sys.sleep(0.3)
    }
  }
  
  updated_cache <- bind_rows(cache, bind_rows(new_lookups)) |> distinct(latitude, longitude, .keep_all = TRUE)
  write_csv(updated_cache, cache_file)
  cache <- updated_cache
}

# Attach Location Id
airbnb_tagged <- airbnb |>
  left_join(cache, by = c("latitude", "longitude"))

stopifnot("Unmapped SA2 coordinates detected" = sum(is.na(airbnb_tagged$`Location Id`)) == 0)

write_csv(airbnb_tagged, "data/intermediate/chch_airbnb_with_sa2.csv")
message("Step 04 finished: Tagged listings = ", nrow(airbnb_tagged))
