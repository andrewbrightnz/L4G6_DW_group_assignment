# From the repository root:
# Rscript "Deliverable 3 - Airbnb analysis with R/main.r"

# Resolve paths relative to this script when invoked from the command line.
script_argument <- grep("^--file=", commandArgs(trailingOnly = FALSE), value = TRUE)
if (length(script_argument) > 0) {
  script_path <- sub("^--file=", "", script_argument[[1]])
  script_path <- gsub("~+~", " ", script_path, fixed = TRUE)
  setwd(dirname(normalizePath(script_path, mustWork = TRUE)))
}

library(readr)
library(dplyr)
library(ggplot2)

source("Tasks/task_1.R")
source("Tasks/task_2.r")
source("Tasks/task_3.r")
source("Tasks/task_4.r")
source("Tasks/task_5.r")

process_data <- function() {
  # Rebuild combined data from the monthly cache, including newly added months.
  ingest_datasets()
  chch_data <- read_csv(output_chch_path, show_col_types = FALSE)
  nz_data <- read_csv(output_nz_path, show_col_types = FALSE)
  dir.create("Plots", recursive = TRUE, showWarnings = FALSE)

  task_2(chch_data)
  task_3(chch_data, nz_data)
  task_4(chch_data)
  task_5(nz_data)
}

process_data()
