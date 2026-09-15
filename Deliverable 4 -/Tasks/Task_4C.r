# Andrew: Clean the bond dataset

# Open: bond_data_Oct25_to_Jun26

# load tidyverse to process tables
library(tidyverse)

task_4C <- function() {
  # Read the bond data that Task_4B filtered and saved to disk
  bond_data_Oct25_to_Jun26 <- read_csv(
    "Deliverable 4 -/Data/bond_data_Oct25_to_Jun26.csv",
    # Select only the columns we want to keep, and set their types
    col_types = cols_only(
      TimeFrame = col_date(format = "%Y-%m-%d"),
      `Location Id` = col_character(),
      `Dwelling Type` = col_character(),
      `Median Rent` = col_double(),
      `Geometric Mean Rent` = col_double(),
      `Upper Quartile Rent` = col_double(),
      `Lower Quartile Rent` = col_double()
    ),
    # write_csv() wrote missing values as "NA"; source data also used "NULL"
    na = c("", "NA", "NULL"),
    show_col_types = FALSE
  )
  message("Task 4C: bond_data_Oct25_to_Jun26.csv loaded")
  message("Task 4C: Missing or NULL values converted to 'na'")
  message()

  message(strrep("-", 40))                     # a line of 40 dashes
  message(nrow(bond_data_Oct25_to_Jun26), " rows in this dataset before cleaning")
  message(strrep("-", 40))                     # a line of 40 dashes
  message()

  # sum of how many missing values are in each column
  message("Task 4C: Missing values per column before cleaning:")
  print(colSums(is.na(bond_data_Oct25_to_Jun26)))
  message()


  message("Task 4C: Duplicate rows---------------")
  #check how many exactly duplicated rows exist before removing them
  message(sum(duplicated(bond_data_Oct25_to_Jun26)), " exact duplicate rows found.")
  message("Task 4C: Removing duplicate rows")
  #removing rows where each column is identical
  bond_data_Oct25_to_Jun26 <- bond_data_Oct25_to_Jun26 |>
    distinct()
  #check how many exactly duplicated rows there are now
  message(sum(duplicated(bond_data_Oct25_to_Jun26)), " exact duplicate rows remain after cleaning.")
  message()

  message("Task 4C: Location id------------------")
  # Location Id repeats across TimeFrame/Dwelling Type snapshots by design, so this is informational only
  message(sum(is.na(bond_data_Oct25_to_Jun26$`Location Id`)), " rows with missing location id.")

  #removing NA location id rows
  message("Task 4C: Removing rows with missing location id")
  bond_data_Oct25_to_Jun26 <- bond_data_Oct25_to_Jun26 |>
    filter(!is.na(`Location Id`))

  # number of rows with NA now = 0
  message(sum(is.na(bond_data_Oct25_to_Jun26$`Location Id`)), " rows with missing location id remain after cleaning.")
  message()
  
  message(strrep("-", 40))                     # a line of 40 dashes
  message(nrow(bond_data_Oct25_to_Jun26), " rows in this dataset after cleaning")
  message(strrep("-", 40))                     # a line of 40 dashes
  message("Task 4C: Missing values per column after cleaning:")
  print(colSums(is.na(bond_data_Oct25_to_Jun26)))
  message()
  

  bond_data_Oct25_to_Jun26_cleaned <- bond_data_Oct25_to_Jun26

  # Save cleaned table to local Data folder
  write_csv(bond_data_Oct25_to_Jun26_cleaned, "Deliverable 4 -/Data/bond_data_Oct25_to_Jun26_cleaned.csv")
  message("Task 4C: bond_data_Oct25_to_Jun26_cleaned.csv saved to disk")
  return(bond_data_Oct25_to_Jun26_cleaned)
}

# Uncomment the line below to test run the function from this file
# task_4C()