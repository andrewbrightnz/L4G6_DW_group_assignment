# Andrew: Store the data in an SQLite database and join the datasets inside it
# Same join as Task 5B: each Airbnb row gets the ALL/ALL rental row for its area and quarter.

task_5F <- function() {
# load libraries
  library(DBI)
  library(RSQLite)
  library(readr)
  library(lubridate)

# Set paths for inputs and outputs
  data_dir <- "Deliverable 5 - Join datasets and store in SQLite database/Data"
  output_dir <- "Deliverable 5 - Join datasets and store in SQLite database/Output/task_5F"
  airbnb_path <- file.path(data_dir, "airbnb_chch_Oct25_to_Jun26_cleaned_with_location_id.csv")
  rental_path <- file.path(data_dir, "rental_data_Oct25_to_Jun26_cleaned_with_location_id.csv")
  db_path <- file.path(output_dir, "airbnb_and_rental_data_Oct25_to_Jun26_cleaned_with_location_id.db")

  # 1. Load the CSVs
  airbnb <- read_csv(airbnb_path, col_types = cols(`Location Id` = col_character()))
  rental <- read_csv(rental_path, col_types = cols(`Location Id` = col_character(),
                                                   TimeFrame = col_character()))

  # 2. Give each Airbnb row its quarter, e.g. "Nov 2025" -> "2025-10-01", to match rental TimeFrame
  airbnb$TimeFrame <- as.character(floor_date(my(airbnb$MonthYear, locale = "C"), "quarter"))

  # 3. Write both datasets to a new database
  dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)
  unlink(db_path)
  conn <- dbConnect(SQLite(), db_path)
  on.exit(dbDisconnect(conn))
  dbWriteTable(conn, "airbnb", airbnb)
  dbWriteTable(conn, "rental", rental)

  # 4. Join inside the database: keep every Airbnb row, add the ALL/ALL rental figures
  dbExecute(conn, "
    CREATE TABLE airbnb_and_rental_data AS
    SELECT airbnb.*,
           rental.`Total Bonds`, rental.`Median Rent`, rental.`Geometric Mean Rent`,
           rental.`Upper Quartile Rent`, rental.`Lower Quartile Rent`
    FROM airbnb
    LEFT JOIN rental
      ON  airbnb.`Location Id` = rental.`Location Id`
      AND airbnb.TimeFrame     = rental.TimeFrame
      AND rental.`Dwelling Type`  = 'ALL'
      AND rental.`Number Of Beds` = 'ALL'")

  # 5. Check the join didn't add or lose rows
  joined_rows <- dbGetQuery(conn, "SELECT COUNT(*) AS n FROM airbnb_and_rental_data")$n
  if (joined_rows != nrow(airbnb)) stop("The join changed the number of Airbnb rows.")
  message("Joined rows: ", joined_rows, "; database saved to: ", db_path)
}

# Uncomment to test from this file, and comment out again before it goes to main
# result <- task_5F()
