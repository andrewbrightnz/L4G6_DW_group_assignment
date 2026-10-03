library(readr)
library(dplyr)
library(lubridate)
library(DBI)
library(RSQLite)

airbnb <- read_csv("data/intermediate/chch_airbnb_with_sa2.csv", 
                   col_types = cols(`Location Id` = col_character(), .default = col_guess()))
bonds <- read_csv("data/intermediate/rental_bonds_cleaned.csv", 
                  col_types = cols(`Location Id` = col_character(), .default = col_guess()))

airbnb <- airbnb |>
  mutate(
    month = my(as.character(MonthYear), locale = "C"),
    TimeFrame = floor_date(month, "quarter")
  )

bond_filtered <- bonds |>
  filter(`Dwelling Type` == "ALL", `Number Of Beds` == "ALL")

stopifnot("Duplicate keys in bond data" = !anyDuplicated(bond_filtered[c("Location Id", "TimeFrame")]))

# Perform many-to-one left join
joined <- left_join(airbnb, bond_filtered, by = c("Location Id", "TimeFrame"), relationship = "many-to-one")
stopifnot("Row count changed in join" = nrow(joined) == nrow(airbnb))

dir.create("data/processed", recursive = TRUE, showWarnings = FALSE)
write_csv(joined, "data/processed/airbnb_and_bonds_joined.csv")

# Store in SQLite database
dir.create("output/database", recursive = TRUE, showWarnings = FALSE)
db_path <- "output/database/rental_comparison.db"
if (file.exists(db_path)) unlink(db_path)

con <- dbConnect(SQLite(), db_path)
dbWriteTable(con, "airbnb", airbnb)
dbWriteTable(con, "bonds", bond_filtered)
dbWriteTable(con, "airbnb_and_bonds", joined)
dbDisconnect(con)

message("Step 05 finished: Joined data written to CSV and SQLite database.")
