# Ruby: Join both datasets (see project board for details)

task_5B <- function() {
  # Open airbnb_chch_Oct25_to_Jun26_cleaned_with_location_id.csv
  # Open rental_chch_Oct25_to_Jun26_cleaned_with_location_id.csv

  # Join

  # Save joined table as airbnb_and_rental_data_Oct25_to_Jun26_cleaned_with_location_id
  write_csv(airbnb_and_rental_data_Oct25_to_Jun26_cleaned_with_location_id, "Deliverable 5 - Join datasets and store in SQLite database/Data/airbnb_and_rental_data_Oct25_to_Jun26_cleaned_with_location_id")
  return(airbnb_and_rental_data_Oct25_to_Jun26_cleaned_with_location_id)
}