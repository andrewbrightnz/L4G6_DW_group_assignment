# Andrew: Clean the bond dataset

# Open: bond_data_Oct25_to_Jun26

# Return or save to disk: bond_data_chch_Oct25_to_Jun26_cleaned

library(tidyverse)

task_4C <- function() {
  # Read the bond data that Task_4B filtered and saved to disk
  bond_data_Oct25_to_Jun26 <- read_csv(
    "Deliverable 4 -/Data/bond_data_Oct25_to_Jun26.csv",
    # Force these ID/category columns to stay as text instead of being guessed
    col_types = cols(
      TimeFrame = col_character(),
      `Location Id` = col_character(),
      `Dwelling Type` = col_character(),
      `Number Of Beds` = col_character(),
      .default = col_double()
    ),
    # write_csv() wrote missing values as "NA"; source data also used "NULL"
    na = c("", "NA", "NULL"),
    show_col_types = FALSE
  )

  # This file not finished yet....
  # Using Ruby's code to drop columns from bond_data_Oct25_to_Jun26

    # selecting the rows we want to keep
  airbnb_chch_Oct25_Jun26 <- airbnb_chch_Oct25_Jun26 |>
    select(id, name, host_id, neighbourhood, latitude, longitude, room_type, price, MonthYear)

  # number of rows = 28795
  message("Task 4A: ", nrow(airbnb_chch_Oct25_Jun26), " rows after selecting columns.")



  bond_data_Oct25_to_Jun26_cleaned <- bond_data_Oct25_to_Jun26

  # Save cleaned table to local Data folder
  write_csv(bond_data_Oct25_to_Jun26_cleaned, "Deliverable 4 -/Data/bond_data_Oct25_to_Jun26_cleaned.csv")

  return(bond_data_Oct25_to_Jun26_cleaned)
}
