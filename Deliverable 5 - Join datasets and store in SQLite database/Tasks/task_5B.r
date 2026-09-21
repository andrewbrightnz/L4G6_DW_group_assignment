# Ruby: Join both datasets (see project board for details)

task_5B <- function() {
  # Open airbnb_chch_Oct25_to_Jun26_cleaned_with_location_id.csv
  # Open rental_chch_Oct25_to_Jun26_cleaned_with_location_id.csv
  
  library(tidyverse)
  library(lubridate)

  # 1. Load datasets
  airbnb <- read_csv("Deliverable 5 - Join datasets and store in SQLite database/Data/airbnb_chch_Oct25_to_Jun26_cleaned_with_location_id.csv")
  rental <- read_csv("Deliverable 5 - Join datasets and store in SQLite database/Data/rental_chch_Oct25_to_Jun26_cleaned.csv")
  
  # 2. Airbnb: turn "Oct 2025" / "March 2026" into a date, then into its quarter start
  airbnb <- airbnb |>
    mutate(
      month     = as.Date(paste("1", MonthYear), format = "%d %B %Y"),
      TimeFrame = floor_date(month, "quarter")
    )
  
  # 3. Filter to ALL for both dwelling type and number of beds to ALL
  rental <- rental |>
    filter(`Dwelling Type` == "ALL", `Number Of Beds` == "ALL")
  
  message("Rental rows after filter (expect 4865): ", nrow(rental))
  message("Repeated area/quarters (expect 0): ", rental |> count(`Location Id`, TimeFrame) |> filter(n > 1) |> nrow())
  
  # 4. Join: keep every Airbnb row and add the rental columns where there's a match
  airbnb_and_rental_data_Oct25_to_Jun26_cleaned_with_location_id <- left_join(
    airbnb, rental,
    by = c("Location Id", "TimeFrame"),
    relationship = "many-to-one"
  )
  
  # 5. checks
  message("Joined rows (expect 28290): ", nrow(airbnb_and_rental_data_Oct25_to_Jun26_cleaned_with_location_id))                         # 28290
  message("Rows with a rent (expect 21566): ", sum(!is.na(airbnb_and_rental_data_Oct25_to_Jun26_cleaned_with_location_id$`Median Rent`)))     # 21566
  message("Number of columns (expect 19): ", ncol(airbnb_and_rental_data_Oct25_to_Jun26_cleaned_with_location_id))                      # 19
  
  # 6.Save joined table as airbnb_and_rental_data_Oct25_to_Jun26_cleaned_with_location_id

  write_csv(airbnb_and_rental_data_Oct25_to_Jun26_cleaned_with_location_id, 
            "Deliverable 5 - Join datasets and store in SQLite database/Data/airbnb_and_rental_data_Oct25_to_Jun26_cleaned_with_location_id.csv")
  return(airbnb_and_rental_data_Oct25_to_Jun26_cleaned_with_location_id)

}

# Uncomment to test from this file, and comment out again before it goes to main
result <- task_5B()
  
  
  
  
