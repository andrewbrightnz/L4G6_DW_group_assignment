# This file runs all of the Deliverable 5 task files in order

# Install packages only if not already installed - add any to the list if you need them
required_packages <- c("RSQLite", "DBI", "here")
for (pkg in required_packages) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    install.packages(pkg)
  }
}


# Load packages
library(RSQLite)
library(DBI)
# Load the data from the database file

# Load each task's function
source("Deliverable 5 - Join datasets and store in  SQLite database/Tasks/Task_5A.r")
source("Deliverable 5 - Join datasets and store in  SQLite database/Tasks/Task_5B.r")
source("Deliverable 5 - Join datasets and store in  SQLite database/Tasks/Task_5C.r")
source("Deliverable 5 - Join datasets and store in  SQLite database/Tasks/Task_5D.r")
source("Deliverable 5 - Join datasets and store in  SQLite database/Tasks/Task_5E.r")
source("Deliverable 5 - Join datasets and store in  SQLite database/Tasks/Task_5F.r")



# Run the tasks in order
cat(rep("\n", 20), sep = "")                     # 20 empty lines for clarity
message(strrep("-", 100))
message("Task 5A")
dataset_name <- task_5A()
message()
message(strrep("-", 100))
message("Task 5B")
dataset_name <- task_5B()
message()
message(strrep("-", 100))
message("Task 5C")
dataset_name <- task_5C()
message()
message(strrep("-", 100))
message("Task 5D")
dataset_name <- task_5D()
message()
message(strrep("-", 100))
message("Task 5E")
dataset_name <- task_5E()
message()
message(strrep("-", 100))
message("Task 5F")
dataset_name <- task_5F()

