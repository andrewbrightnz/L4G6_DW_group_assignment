# Ruby: Join both datasets (see project board for details)

#task_5B <- function() {
  # Open airbnb_chch_Oct25_to_Jun26_cleaned_with_location_id.csv
  # Open rental_chch_Oct25_to_Jun26_cleaned_with_location_id.csv
  
  library(tidyverse)
  library(lubridate)

  # 1. Load datasets
  airbnb <- read_csv("Deliverable 5 - Join datasets and store in SQLite database/Data/airbnb_chch_Oct25_to_Jun26_cleaned_with_location_id.csv")
  rental <- read_csv("Deliverable 5 - Join datasets and store in SQLite database/Data/rental_data_Oct25_to_Jun26_cleaned_with_location_id.csv")
  
  # 2. Airbnb: turn "Oct 2025" / "March 2026" into a date, then into its quarter start
  airbnb <- airbnb |>
    mutate(
      month     = as.Date(paste("1", MonthYear), format = "%d %B %Y"),
      TimeFrame = floor_date(month, "quarter")
    )
  
  # 3. Filter to ALL for both dwelling type and 
  

#}
##result <- task_5B()

  # Join

  # Save joined table as airbnb_and_rental_data_Oct25_to_Jun26_cleaned_with_location_id
#  write_csv(airbnb_and_rental_data_Oct25_to_Jun26_cleaned_with_location_id, "Deliverable 5 - Join datasets and store in SQLite database/Data/airbnb_and_rental_data_Oct25_to_Jun26_cleaned_with_location_id")
#  return(airbnb_and_rental_data_Oct25_to_Jun26_cleaned_with_location_id)
  
  
  
  
