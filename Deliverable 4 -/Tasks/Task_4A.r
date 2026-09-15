# Ruby: Clean the Christchurch dataset

# Open airbnb_chch_Oct25_to_Jun26.csv

# Return or save to disk: airbnb_chch_Oct25_to_Jun26_cleaned
library(tidyverse)

task_4A <- function() {
  airbnb_chch_Oct25_Jun26 <- read_csv("Deliverable 4 -/Data/airbnb_chch_Oct25_to_Jun26.csv")

  # selecting the rows we want to keep
  airbnb_chch_Oct25_Jun26 <- airbnb_chch_Oct25_Jun26 |>
    select(id, name, host_id, neighbourhood, latitude, longitude, room_type, price, MonthYear)

  # number of rows = 28795
  message("Task 4A: ", nrow(airbnb_chch_Oct25_Jun26), " rows after selecting columns.")

  # sum of how many missing values are in each column (all 0 except price = 10667)
  message("Task 4A: missing values per column:")
  print(colSums(is.na(airbnb_chch_Oct25_Jun26)))

  #removing rows where each column is identical
  airbnb_chch_Oct25_Jun26 <- airbnb_chch_Oct25_Jun26 |>
    distinct()

  #check how many exactly duplicated rows there are now = 0
  message("Task 4A: ", sum(duplicated(airbnb_chch_Oct25_Jun26)), " exact duplicate rows remain.")

  # number of rows = 28795
  message("Task 4A: ", nrow(airbnb_chch_Oct25_Jun26), " rows after removing duplicates.")

  # sum of duplicated ids = 24678
  message("Task 4A: ", sum(duplicated(airbnb_chch_Oct25_Jun26$id)), " duplicated ids.")

  # sum of number of rows in price column with NA = 10667
  message("Task 4A: ", sum(is.na(airbnb_chch_Oct25_Jun26$price)), " rows with missing price.")

  #removing NA price rows
  airbnb_chch_Oct25_Jun26 <- airbnb_chch_Oct25_Jun26 |>
    filter(!is.na(price))

  # number of rows with NA now = 0
  message("Task 4A: ", sum(is.na(airbnb_chch_Oct25_Jun26$price)), " rows with missing price remain.")

  # updated number of rows = 18128
  message("Task 4A: ", nrow(airbnb_chch_Oct25_Jun26), " rows after removing missing price.")

  write_csv(airbnb_chch_Oct25_Jun26, "Deliverable 4 -/Data/airbnb_chch_Oct25_to_Jun26_cleaned.csv")

  return(airbnb_chch_Oct25_Jun26)
}

# Run from the repository root:
# source("Deliverable 4 -/Tasks/Task_4A.r")
# airbnb_chch_Oct25_to_Jun26_cleaned <- task_4A()
