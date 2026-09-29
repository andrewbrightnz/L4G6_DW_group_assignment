# Ruby: Clean the Christchurch dataset

# Open airbnb_chch_Oct25_to_Jun26.csv

# Return or save to disk: airbnb_chch_Oct25_to_Jun26_cleaned
library(tidyverse)

task_4A <- function() {

input_data <- "Deliverable 4 - Clean bond data/Data/airbnb_chch_Oct25_to_Jun26.csv"
output_data <- "Deliverable 4 - Clean bond data/Output/airbnb_chch_Oct25_to_Jun26_cleaned.csv"

price_max_plausible <- 7000   # prices above this are treated as errors
price_inspect       <- 2000   # prices above this are printed for inspection
lat_min  <- -44; lat_max  <- -43 # value for plausible locations
longitude_min <- 172; longitude_max <- 173 # value for plausible locations

# read csv
airbnb_chch_Oct25_Jun26 <- read_csv(input_data)

  # selecting the columns we want to keep
  airbnb_chch_Oct25_Jun26 <- airbnb_chch_Oct25_Jun26 |>
    select(id, name, host_id, neighbourhood, latitude, longitude, room_type, price, MonthYear)
  
  # number of rows
  message("Task 4A: ", nrow(airbnb_chch_Oct25_Jun26), " rows after selecting columns.")
  
  # sum of how many missing values are in each column 
  message("Task 4A: missing values per column:")
  print(colSums(is.na(airbnb_chch_Oct25_Jun26)))
  
  message("Task 4A: missing price by MonthYear (before fill):")
  print(
  # sum of missing price value per month
  airbnb_chch_Oct25_Jun26 |>
    group_by(MonthYear) |>
    summarise(n_missing = sum(is.na(price)))
  )
  
  # ordering months in time order not alphabetical
  month_levels <- c("Oct 2025", "Nov 2025", "Dec 2025", "Jan 2026",
                    "Feb 2026", "March 2026", "April 2026", "May 2026", "June 2026")
  
  # filling in missing prices from previous months that have the same ID (same listing) 
  airbnb_chch_Oct25_Jun26 <- airbnb_chch_Oct25_Jun26 |>
    mutate(MonthYear = factor(MonthYear, levels = month_levels, ordered = TRUE)) |>
    arrange(id, MonthYear) |>
    group_by(id) |>
    fill(price, .direction = "down") |>
    ungroup()
  
  message("Task 4A: missing price by MonthYear (after fill):")
  print(
  # checking how many are missing per month now
  airbnb_chch_Oct25_Jun26 |>
    group_by(MonthYear) |>
    summarise(n_missing = sum(is.na(price)), .groups = "drop")
  )
  
  # making sure there are no rows where id and month are both the same
  message("Task 4A: rows with duplicated id + MonthYear (should be none):")
  print(
  airbnb_chch_Oct25_Jun26 |>
    count(id, MonthYear) |>
    filter(n > 1)
  )
  
  # Check for invalid prices (0 or negative)
  message("Task 4A: number of invalid prices (0 or negative):", sum(airbnb_chch_Oct25_Jun26$price <= 0, na.rm = TRUE))

  # Check room_type categories are consistent
  message("Task 4A: room_type categories:")
  print(unique(airbnb_chch_Oct25_Jun26$room_type))

  # Check neighbourhood categories are consistent
  message("Task 4A: neighbourhoood categories:")
  print(unique(airbnb_chch_Oct25_Jun26$neighbourhood))
  
  #removing rows where each column is identical
  airbnb_chch_Oct25_Jun26 <- airbnb_chch_Oct25_Jun26 |>
    distinct()
  
  #check how many exactly duplicated rows there are now 
  message("Task 4A: ", sum(duplicated(airbnb_chch_Oct25_Jun26)), " exact duplicate rows remain.")
  
  # check to make sure the longitude and latitudes variables are reasonable
  message("Task 4A: rows outside expected lat/long range, by neighbourhood:")
  print(
  airbnb_chch_Oct25_Jun26 |>
    filter(latitude > lat_max | latitude < lat_min | longitude < longitude_min | longitude > longitude_max) |>
    count(neighbourhood)
  )
  
  
  # check the different prices
  message("Task 4A: price summary before outlier fix:")
  print(summary(airbnb_chch_Oct25_Jun26$price))

  # check the price outliers in the data
  message("Task 4A: looking at the outliers")
  print(
    airbnb_chch_Oct25_Jun26 |>
      filter(price > price_inspect) |>
      arrange(desc(price)) |>
      select(id, name, price, host_id, MonthYear),
    n = Inf
  )
  
  
  # Flag clearly wrong prices as missing
  airbnb_chch_Oct25_Jun26 <- airbnb_chch_Oct25_Jun26 |>
    mutate(price = if_else(price > price_max_plausible, NA_real_, price))
  

  # Fill from nearby months (either direction) within the same listing
  airbnb_chch_Oct25_Jun26 <- airbnb_chch_Oct25_Jun26 |>
    arrange(id, MonthYear) |>
    group_by(id) |>
    fill(price, .direction = "downup") |>
    ungroup()
  
  # Check the result
  message("Task 4A: price summary after outlier fix:")
  print(summary(airbnb_chch_Oct25_Jun26$price))
  
  # sum of duplicated ids 
  message("Task 4A: ", sum(duplicated(airbnb_chch_Oct25_Jun26$id)), " duplicated ids.")

  # sum of number of rows in price column with NA
  message("Task 4A: ", sum(is.na(airbnb_chch_Oct25_Jun26$price)), " rows with missing price.")
  
  #removing rows where price is NA
  airbnb_chch_Oct25_Jun26 <- airbnb_chch_Oct25_Jun26 |>
    filter(!is.na(price))

  # number of rows with NA now 
  message("Task 4A: ", sum(is.na(airbnb_chch_Oct25_Jun26$price)), " rows with missing price remain.")

  # updated number of rows
  message("Task 4A: ", nrow(airbnb_chch_Oct25_Jun26), " rows after removing missing price.")
  
  # check to see if outliers have been removed
  message("Task 4A: outliers after cleaning:")
  print(
    airbnb_chch_Oct25_Jun26 |>
      filter(price > price_inspect) |>
      arrange(desc(price)) |>
      select(id, name, price, host_id, MonthYear),
    n = Inf
  )

 write_csv(airbnb_chch_Oct25_Jun26, output_data)

  return(airbnb_chch_Oct25_Jun26)
}

# Run from the repository root:
# source("Deliverable 4 - Clean bond data/Tasks/Task_4A.r")
# airbnb_chch_Oct25_to_Jun26_cleaned <- task_4A()

# task_4A()
