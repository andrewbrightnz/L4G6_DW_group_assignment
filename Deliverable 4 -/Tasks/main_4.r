# This file runs all of the Deliverable 4 task files in order

library(tidyverse)

# Load the data from the internet and save to bond_data
bond_data <- read_csv("https://www.tenancy.govt.nz/assets/Uploads/Tenancy/Rental-bond-data/Detailed-Quarterly-Tenancy-Q1-2020-Q3-2026.csv?m=5766222a0dc2d94c11545872be77333e32f7c999")

# Save the data to a csv file in the Data folder
write_csv(bond_data, "Deliverable 4 -/Data/bond_data.csv")

# Load each task's function
source("Deliverable 4 -/Tasks/Task_4A.r")
source("Deliverable 4 -/Tasks/Task_4B.r")
source("Deliverable 4 -/Tasks/Task_4C.r")

# Run the tasks in order
airbnb_chch_Oct25_to_Jun26_cleaned <- task_4A()
bond_data_Oct25_to_Jun26 <- task_4B()
bond_data_Oct25_to_Jun26_cleaned <- task_4C()
