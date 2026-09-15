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

  message("Task 4C: ", nrow(bond_data_Oct25_to_Jun26), " rows after selecting columns.")

  # sum of how many missing values are in each column
  message("Task 4C: missing values per column:")
  print(colSums(is.na(bond_data_Oct25_to_Jun26)))

  #check how many exactly duplicated rows exist before removing them
  message("Task 4C: ", sum(duplicated(bond_data_Oct25_to_Jun26)), " exact duplicate rows found.")

  #removing rows where each column is identical
  bond_data_Oct25_to_Jun26 <- bond_data_Oct25_to_Jun26 |>
    distinct()

  #check how many exactly duplicated rows there are now = 0
  message("Task 4C: ", sum(duplicated(bond_data_Oct25_to_Jun26)), " exact duplicate rows remain.")

  message("Task 4C: ", nrow(bond_data_Oct25_to_Jun26), " rows after removing duplicates.")

  # Location Id repeats across TimeFrame/Dwelling Type snapshots by design, so this is informational only
  message("Task 4C: ", sum(duplicated(bond_data_Oct25_to_Jun26$`Location Id`)), " duplicated location ids.")

  message("Task 4C: ", sum(is.na(bond_data_Oct25_to_Jun26$`Median Rent`)), " rows with missing median rent.")

  #removing NA median rent rows
  bond_data_Oct25_to_Jun26 <- bond_data_Oct25_to_Jun26 |>
    filter(!is.na(`Median Rent`))

  # number of rows with NA now = 0
  message("Task 4C: ", sum(is.na(bond_data_Oct25_to_Jun26$`Median Rent`)), " rows with missing median rent remain.")

  message("Task 4C: ", nrow(bond_data_Oct25_to_Jun26), " rows after removing missing median rent.")




  bond_data_Oct25_to_Jun26_cleaned <- bond_data_Oct25_to_Jun26

  # Save cleaned table to local Data folder
  write_csv(bond_data_Oct25_to_Jun26_cleaned, "Deliverable 4 -/Data/bond_data_Oct25_to_Jun26_cleaned.csv")

  return(bond_data_Oct25_to_Jun26_cleaned)
}

# Use this line to test run the function
task_4C()