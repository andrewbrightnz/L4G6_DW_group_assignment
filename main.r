# This file runs all of the different task files in order

# Install and load all the packages we use
install.packages("tidyverse")
library("tidyverse")

# Load tasks from Tasks folder
source("Tasks/task_1.R")
source("Tasks/task_2.R")
source("Tasks/task_3.R")
source("Tasks/task_4.R")
source("Tasks/task_5.R")

# Run tasks in order
# Comment out task_1() if chch_all_listings.csv already exists
task_1()                    # Download data and filter on Christchurch, 
                            # add month and year cols, 
                            # save to chch_all_listings.csv so it doesn't need to be downloaded each time to program runs

# Load the saved data to a variable for other tasks to use
chch_Oct25_to_Jun26 <- read_csv("Data/chch_Oct25_to_Jun26.csv")   

task_2(chch_Oct25_to_Jun26)   # Produce summary stats
task_3(chch_Oct25_to_Jun26)   # Plot distribution of prices for NZ
task_4(chch_Oct25_to_Jun26)   # Plot days since last review
task_5(chch_Oct25_to_Jun26)   # Plot highest number of reviews from top 10%