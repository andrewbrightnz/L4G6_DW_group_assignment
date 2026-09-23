# This file runs all of the Deliverable 5 task files in order

# Install packages only if not already installed - add any to the list if you need them
required_packages <- c("RSQLite", "DBI", "here", "httr2", "readr")
for (pkg in required_packages) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    install.packages(pkg)
  }
}


# Load packages
library(RSQLite)
library(DBI)

# Load each task's function from the Task_5.. files
source("Deliverable 5 - Join datasets and store in SQLite database/Tasks/task_5AA.r")
source("Deliverable 5 - Join datasets and store in SQLite database/Tasks/task_5A.r")
source("Deliverable 5 - Join datasets and store in SQLite database/Tasks/task_5B.r")
source("Deliverable 5 - Join datasets and store in SQLite database/Tasks/task_5C.r")
source("Deliverable 5 - Join datasets and store in SQLite database/Tasks/task_5D.r")
source("Deliverable 5 - Join datasets and store in SQLite database/Tasks/task_5E.r")
source("Deliverable 5 - Join datasets and store in SQLite database/Tasks/task_5F.r")

# Run the tasks in order
cat(rep("\n", 20), sep = "")                     # 20 empty lines to clear the terminal

message(strrep("-", 100))
message("Task 5AA: Remove rows with values of -99")
message(strrep("-", 100))
message()
cleaned_datasets <- task_5AA()
airbnb_chch_Oct25_to_Jun26_cleaned <- cleaned_datasets$airbnb_chch_Oct25_to_Jun26_cleaned
bond_data_Oct25_to_Jun26_cleaned   <- cleaned_datasets$bond_data_Oct25_to_Jun26_cleaned
message()

message(strrep("-", 100))
message("Task 5A: Insert Location Id/SA2 codes for airbnb dataset from Koordinates API")
message(strrep("-", 100))
message()
airbnb_chch_Oct25_to_Jun26_cleaned_with_location_id <- task_5A()
message()

message(strrep("-", 100))
message("Task 5B: Join airbnb and rental datasets")
message(strrep("-", 100))
message()
airbnb_and_rental_data_Oct25_to_Jun26_cleaned_with_location_id <- task_5B()
message()

message(strrep("-", 100))
message("Task 5C: Find median AirBnB price in Christchurch Central")
message(strrep("-", 100))
message()
task_5C()
message()

message(strrep("-", 100))
message("Task 5D: Find largest gap between short and long term rental prices")
message(strrep("-", 100))
message()
task_5D()
message()

message(strrep("-", 100))
message("Task 5E: Compare how many AirBnBs and rental properties are in each location")
message(strrep("-", 100))
message()
task_5E()
message()

message(strrep("-", 100))
message("Task 5F: Join the airbnb and rental datasets in SQlite database")
message(strrep("-", 100))
message()
dataset_name <- task_5F()

