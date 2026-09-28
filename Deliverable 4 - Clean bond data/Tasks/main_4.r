# This file runs all of the Deliverable 4 task files in order

library(tidyverse)

download.file("https://www.tenancy.govt.nz/assets/Uploads/Tenancy/Rental-bond-data/Detailed-Quarterly-Tenancy-Q1-2020-Q3-2026.csv?m=5766222a0dc2d94c11545872be77333e32f7c999", "Deliverable 4 - Clean bond data/Data/bond_data.csv", mode = "wb")

# Load each task's function
source("Deliverable 4 - Clean bond data/Tasks/Task_4A.r")
source("Deliverable 4 - Clean bond data/Tasks/Task_4B.r")
source("Deliverable 4 - Clean bond data/Tasks/Task_4C.r")

# Run the tasks in order
cat(rep("\n", 20), sep = "")                     # 20 empty lines for clarity
message(strrep("-", 100))
message("Task 4A")
airbnb_chch_Oct25_to_Jun26_cleaned <- task_4A()
message()
message(strrep("-", 100))
message("Task 4B")
bond_data_Oct25_to_Jun26 <- task_4B()
message()
message(strrep("-", 100))
message("Task 4C")
bond_data_Oct25_to_Jun26_cleaned <- task_4C()
