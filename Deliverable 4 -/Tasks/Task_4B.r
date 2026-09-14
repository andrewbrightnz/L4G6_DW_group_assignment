# Deliverable 4, Jin: keep bond records within the Airbnb observation period.
# Airbnb snapshots cover October 2025 through June 2026 (inclusive).
# This filters the existing quarterly labels; it does not create monthly data.

task_4B <- function(bond_data) {
  required_columns <- c("TimeFrame", "Location Id")
  if (!all(required_columns %in% names(bond_data))) {
    stop("Bond data must contain TimeFrame and Location Id.")
  }

  # Check dates before filtering so missing or malformed dates are not lost silently.
  date_text <- as.character(bond_data$TimeFrame)
  timeframe <- as.Date(date_text, format = "%Y-%m-%d")
  if (anyNA(timeframe) || any(format(timeframe, "%Y-%m-%d") != date_text)) {
    stop("TimeFrame contains missing or invalid dates; expected YYYY-MM-DD.")
  }

  start_date <- as.Date("2025-10-01")
  end_date_exclusive <- as.Date("2026-07-01")
  rows_before <- nrow(bond_data)

  # Keep every column, including Location Id, for the next team member's task.
  filtered_bonds <- bond_data |>
    dplyr::mutate(TimeFrame = timeframe) |>
    dplyr::filter(
      TimeFrame >= start_date,
      TimeFrame < end_date_exclusive
    )

  message("Task 4B: ", rows_before, " rows before; ", nrow(filtered_bonds),
          " rows after; ", rows_before - nrow(filtered_bonds), " rows excluded.")
  message("Retained TimeFrame values: ",
          paste(sort(unique(filtered_bonds$TimeFrame)), collapse = ", "))

  return(filtered_bonds)
}

# Run from the repository root:
# source("Deliverable 4 -/Tasks/Task_4B.r")
# If bond_data is already loaded, use it. Otherwise read the local download.
# Required packages: readr and dplyr; install them once if needed.
if (!exists("bond_data", inherits = FALSE)) {
  bond_file <- "Deliverable 4 -/Data/Detailed-Quarterly-Tenancy-Q1-2020-Q3-2026.csv"
  if (!file.exists(bond_file)) {
    stop("Place the downloaded bond CSV in Deliverable 4 -/Data/ or load bond_data first.")
  }

  # Keep location IDs and bedroom categories (including literal NA) as text.
  bond_data <- readr::read_csv(
    bond_file,
    col_types = readr::cols(
      TimeFrame = readr::col_character(),
      `Location Id` = readr::col_character(),
      `Dwelling Type` = readr::col_character(),
      `Number Of Beds` = readr::col_character(),
      .default = readr::col_double()
    ),
    na = c("", "NULL"),
    show_col_types = FALSE
  )
  if (nrow(readr::problems(bond_data)) > 0) {
    stop("The bond CSV has parsing problems; inspect readr::problems(bond_data).")
  }
}

# Andrew's Task_4C.r expects this object as its input.
bond_data_Oct25_to_Jun26 <- task_4B(bond_data)
# Expected raw-file result: 226080 -> 27212 rows; 198868 excluded.
# Retained quarterly labels: 2025-10-01, 2026-01-01, 2026-04-01.
# Confirm the reporting interval of these labels before later comparisons.
