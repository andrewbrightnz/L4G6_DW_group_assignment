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

process_data <- function() {
  # Load the saved data to a variable for other tasks to use
  chch_Oct25_to_Jun26 <- read_csv("Data/chch_Oct25_to_Jun26.csv")   
  nz_Oct25_to_Jun26 <- read_csv("Data/nz_Oct25_to_Jun26.csv")   

  task_2(chch_Oct25_to_Jun26) # Produce summary stats
  task_3(chch_Oct25_to_Jun26) # Plot distribution of prices for NZ
  task_4(chch_Oct25_to_Jun26) # Plot days since last review
  task_5(nz_Oct25_to_Jun26)   # Plot highest number of reviews from top 10%
}

# Run tasks in order
# Check if the data files exists before downloading data from the insideairbnb.com and processing it
if (file.exists("Data/chch_june.csv")) {
  print("chch_june.csv exists")
  if (file.exists("Data/chch_Oct25_to_Jun26.csv")) {
    print("chch_Oct25_to_Jun26.csv exists")
    if (file.exists("Data/nz_Oct25_to_Jun26.csv")) {
      print("nz_Oct25_to_Jun26.csv exists")
      print("All required data files have been created and don't need to be downloaded\nBeginning processing and plotting tasks....")
    } else {
      task_1()   # Downloads the monthly data from insideairbnb.com and saves it to csv files in the Data folder
    }
  } else {
    task_1()
  }
} else {
  task_1()
}

# Now that the files are guaranteed to exist (freshly downloaded or pre-existing), load and process them
process_data()
