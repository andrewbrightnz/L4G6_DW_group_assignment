# Andrew: Clean the bond dataset

# Open: bond_data_Oct25_to_Jun26

# Return or save to disk: bond_data_chch_Oct25_to_Jun26_cleaned

library(tidyverse)

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