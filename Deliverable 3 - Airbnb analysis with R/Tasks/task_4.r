# Calculate how long ago the last review was in days (difference between scrape/publish date and last review date). 
# Plot the distribution of this new feature.


task_4 <- function(chch_june) {
  chch_june <- chch_june |>
    mutate(
      last_review = as.Date(last_review),
      DataDate = case_when( 
        as.character(MonthYear) == "Oct 2025" ~ as.Date("2025-10-05"),
        as.character(MonthYear) == "Nov 2025" ~ as.Date("2025-11-07"), 
        as.character(MonthYear) == "Dec 2025" ~ as.Date("2025-12-11"), 
        as.character(MonthYear) == "Jan 2026" ~ as.Date("2026-01-16"), 
        as.character(MonthYear) == "Feb 2026" ~ as.Date("2026-02-13"), 
        as.character(MonthYear) == "March 2026" ~ as.Date("2026-03-17"),
        as.character(MonthYear) == "April 2026" ~ as.Date("2026-04-16"),
        as.character(MonthYear) == "May 2026" ~ as.Date("2026-05-23"),
        as.character(MonthYear) == "June 2026" ~ as.Date("2026-06-19")
      ),
      DaysSinceLastReview = as.numeric(DataDate - last_review)
    )

  # 1. Assign the plot to a variable (p)
  p <- chch_june |>
    filter(!is.na(DaysSinceLastReview)) |>
    ggplot(aes(x = DaysSinceLastReview)) +
    geom_histogram(binwidth = 30, fill = "steelblue", color = "white") + 
    coord_cartesian(xlim = c(0, 1000)) +
    labs(
      title = "Distribution of Days Since Last Review",
      x = "Days since last review",
      y = "Count of listings"
      )

  #chch_all |>
  #filter(!is.na(DaysSinceLastReview)) |>
  #ggplot(aes(x = DaysSinceLastReview)) +
  #geom_histogram(binwidth = 30, fill = "steelblue", color = "white") +
  #labs(
  #title = "Distribution of Days Since Last Review",
  #x = "Days since last review",
  #y = "Count of listings"
  #)
  
  # Save the plot to a file
  ggsave(
    filename = "Plots/Task 4 - Days_since_last_review.png", 
    plot = p, 
    width = 8, 
    height = 6, 
    dpi = 300
  )
  # Plot saves to Plots folder; no need to print it
  # print(p)
  
}


# Sanity check assertion in pipeline
sanity_check_task_4 <- function(df) {
  # Check 1: No negative elapsed days
  stopifnot("Negative days detected in review interval" = all(df$DaysSinceLastReview >= 0, na.rm = TRUE))

  # Check 2: Spot-check boundary row via tail
  sample_row <- tail(df[!is.na(df$DaysSinceLastReview), c("DataDate", "last_review", "DaysSinceLastReview")], 1)
  expected_diff <- as.numeric(sample_row$DataDate - sample_row$last_review)
  stopifnot("Calculated days does not match calendar difference" = sample_row$DaysSinceLastReview == expected_diff)
}