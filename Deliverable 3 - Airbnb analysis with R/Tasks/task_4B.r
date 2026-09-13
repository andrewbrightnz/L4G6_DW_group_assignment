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
