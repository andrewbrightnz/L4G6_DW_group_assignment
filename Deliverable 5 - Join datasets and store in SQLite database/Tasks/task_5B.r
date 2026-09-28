# Ruby: Join both datasets (see project board for details)

task_5B <- function() {
  library(tidyverse)
  library(lubridate)

  # 1. Load datasets
  airbnb <- read_csv("Deliverable 5 - Join datasets and store in SQLite database/Data/airbnb_chch_Oct25_to_Jun26_cleaned_with_location_id.csv", show_col_types = FALSE)
  rental <- read_csv("Deliverable 5 - Join datasets and store in SQLite database/Data/rental_chch_Oct25_to_Jun26_cleaned.csv", show_col_types = FALSE)
  
  # 2. Airbnb: turn "Oct 2025" / "March 2026" into a date, then into its quarter start
  airbnb <- airbnb |>
    mutate(
      month     = my(MonthYear, locale = "C"),
      TimeFrame = floor_date(month, "quarter")
    )
  if (anyNA(airbnb$month) || anyNA(airbnb$`Location Id`)) {
    stop("Airbnb rows have a missing month or Location Id; check Task 5A output.")
  }
  
  # 3. Filter to ALL for both dwelling type and number of beds to ALL
  rental <- rental |>
    filter(`Dwelling Type` == "ALL", `Number Of Beds` == "ALL")
  
  if (anyDuplicated(rental[c("Location Id", "TimeFrame")])) {
    stop("Rental data contains more than one ALL/ALL row for an area and quarter.")
  }
  message("Rental rows after ALL/ALL filter: ", nrow(rental))
  
  # 4. Join: keep every Airbnb row and add the rental columns where there's a match
  airbnb_and_rental_data_Oct25_to_Jun26_cleaned_with_location_id <- left_join(
    airbnb, rental,
    by = c("Location Id", "TimeFrame"),
    relationship = "many-to-one"
  )
  
  # 5. checks
  if (nrow(airbnb_and_rental_data_Oct25_to_Jun26_cleaned_with_location_id) != nrow(airbnb)) {
    stop("The join changed the number of Airbnb rows.")
  }
  message("Joined rows: ", nrow(airbnb_and_rental_data_Oct25_to_Jun26_cleaned_with_location_id))
  message("Rows with median rent: ", sum(!is.na(airbnb_and_rental_data_Oct25_to_Jun26_cleaned_with_location_id$`Median Rent`)))
  
  # 6. Save the joined table.

  write_csv(airbnb_and_rental_data_Oct25_to_Jun26_cleaned_with_location_id, 
            "Deliverable 5 - Join datasets and store in SQLite database/Data/airbnb_and_rental_data_Oct25_to_Jun26_cleaned_with_location_id.csv")
  return(airbnb_and_rental_data_Oct25_to_Jun26_cleaned_with_location_id)

}

# Uncomment to test from this file, and comment out again before it goes to main
# result <- task_5B()
  
  
  
