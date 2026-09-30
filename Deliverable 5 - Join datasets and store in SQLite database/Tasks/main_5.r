# Run from the project root:
# source("Deliverable 5 - Join datasets and store in SQLite database/Tasks/main_5.r")
# Install missing packages before running this script.
required_packages <- c("DBI", "ggplot2", "httr2", "lubridate", "readr", "RSQLite", "tidyverse")
missing_packages <- required_packages[!vapply(required_packages, requireNamespace, logical(1), quietly = TRUE)]
if (length(missing_packages) > 0) {
  stop("Install these R packages first: ", paste(missing_packages, collapse = ", "))
}

task_dir <- "Deliverable 5 - Join datasets and store in SQLite database/Tasks"
for (task_file in c("task_5AA.r", "task_5A.r", "task_5B.r",
                    "task_5C.r", "task_5D.r", "task_5E.r", "task_5F.r")) {
  source(file.path(task_dir, task_file))
}

message("Task 5AA: Remove rows containing -99")
invisible(task_5AA())
message("Task 5A: Add SA2 location codes to Airbnb listings")
invisible(task_5A())
message("Task 5B: Join Airbnb and rental data")
invisible(task_5B())
message("Task 5C: Median Airbnb price in Christchurch Central")
task_5C()
message("Task 5D: Largest short-term versus long-term rental price gap")
task_5D()
message("Task 5E: Compare Airbnb listings and rental bonds by area")
invisible(task_5E())
message("Task 5F: Store and join the datasets in an SQLite database")
invisible(task_5F())
