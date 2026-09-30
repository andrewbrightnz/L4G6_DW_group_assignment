# Remove rows containing -99 from the Airbnb and rental datasets.

# Return or save to disk: airbnb_chch_Oct25_to_Jun26_cleaned and bond_data_Oct25_to_Jun26_cleaned
library(tidyverse)

# Create a function that drops any row where at least one column holds a -99 value.
# Checked as text so it catches -99 stored as either a number or a character code (e.g. Location Id).
drop_neg99_rows <- function(df, dataset_name) {
  rows_before <- nrow(df)
  # Check as text to catch both numeric and character -99 values.
  df <- df |> filter(!if_any(everything(), ~ as.character(.x) %in% "-99"))
  message("Task 5AA: ", dataset_name, " - ", rows_before, " rows before; ", nrow(df),
          " rows after; ", rows_before - nrow(df), " rows removed.")
  message()

  df
}

# Create a function to run the whole process
task_5AA <- function() {
    message("Task 5AA: Drop any rows with values of -99 from airbnb and rental datasets")
    message()

    # Open the cleaned airbnb and bond datasets from deliverable 4
    airbnb_chch_Oct25_Jun26_drop_neg99s <- read_csv(
    "Deliverable 4 - Clean bond data/Data/airbnb_chch_Oct25_to_Jun26_cleaned.csv",
    show_col_types = FALSE
    )
    bond_data_Oct25_Jun26_drop_neg99s <- read_csv(
    "Deliverable 4 - Clean bond data/Data/bond_data_Oct25_to_Jun26_cleaned.csv",
    show_col_types = FALSE
    )

    # Run the drop_neg99_rows function on each dataset
    airbnb_chch_Oct25_to_Jun26_cleaned <- drop_neg99_rows(airbnb_chch_Oct25_Jun26_drop_neg99s, "airbnb")
    rental_chch_Oct25_to_Jun26_cleaned <- drop_neg99_rows(bond_data_Oct25_Jun26_drop_neg99s, "bond data")

    # Save cleaned datasets to deliverable 5 folder
    write_csv(airbnb_chch_Oct25_to_Jun26_cleaned, "Deliverable 5 - Join datasets and store in SQLite database/Data/airbnb_chch_Oct25_to_Jun26_cleaned.csv")
    write_csv(rental_chch_Oct25_to_Jun26_cleaned, "Deliverable 5 - Join datasets and store in SQLite database/Data/rental_chch_Oct25_to_Jun26_cleaned.csv")
    message("Task 5AA: cleaned airbnb and rental data; csv files saved to disk")

    # Return the datasets for use by another task or function
    return(list(
    airbnb_chch_Oct25_to_Jun26_cleaned = airbnb_chch_Oct25_to_Jun26_cleaned,
    bond_data_Oct25_to_Jun26_cleaned = rental_chch_Oct25_to_Jun26_cleaned
    ))
    }

# Run task_5AA() explicitly; sourcing this file only defines functions.
