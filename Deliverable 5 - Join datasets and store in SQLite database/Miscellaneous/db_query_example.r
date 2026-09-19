# main.R

# Install packages only if not already installed - add more to this list if you need them
required_packages <- c("RSQLite", "DBI", "here")
for (pkg in required_packages) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    install.packages(pkg)
  }
}

# Load packages
library(RSQLite)
library(DBI)
library(here)

# Cponnect to the test_rentals database
conn <- dbConnect(RSQLite::SQLite(), here("Deliverable 5 - Join datasets and store in  SQLite database", "Data", "test_rentals.db"))

# Select all of the fields from the table airbnb_data
df <- dbGetQuery(conn, "SELECT * FROM airbnb_data LIMIT 10;")

# Print the selected fields and their rows
print(df)

# Close connection to the database
dbDisconnect(conn)