# Calculate how long ago the last review was in days (difference between scrape/publish date and last review date). 
# Plot the distribution of this new feature.

task_4 <- function(chch_all) {
  # Code block (body of the function) 
}
library(tidyverse)

june2026_data <- read_csv("https://data.insideairbnb.com/new-zealand/2026-06-19/visualisations/listings.csv")

chch_june <- june2026_data |>
  filter(neighbourhood_group == "Christchurch City") |>
  mutate(MonthYear = "June 2026")

May2026_data <- read_csv("https://data.insideairbnb.com/new-zealand/2026-05-23/visualisations/listings.csv")

chch_may <- May2026_data |>
  filter(neighbourhood_group == "Christchurch City")|>
  mutate(MonthYear = "May 2026")

April2026_data <- read_csv("https://data.insideairbnb.com/new-zealand/2026-04-16/visualisations/listings.csv")

chch_april <- April2026_data |>
  filter(neighbourhood_group == "Christchurch City") |>
  mutate(MonthYear = "April 2026")

March2026_data <- read_csv("https://data.insideairbnb.com/new-zealand/2026-03-17/visualisations/listings.csv")

chch_march <- March2026_data |>
  filter(neighbourhood_group == "Christchurch City") |>
  mutate(MonthYear = "March 2026")


Feb2026_data <- read_csv("https://data.insideairbnb.com/new-zealand/2026-02-13/visualisations/listings.csv")

chch_feb <- Feb2026_data |>
  filter(neighbourhood_group == "Christchurch City")|>
  mutate(MonthYear = "Feb 2026")

Jan2026_data <- read_csv("https://data.insideairbnb.com/new-zealand/2026-01-16/visualisations/listings.csv")

chch_jan <- Jan2026_data |>
  filter(neighbourhood_group == "Christchurch City") |>
  mutate(MonthYear = "Jan 2026")


Dec2025_data <- read_csv("https://data.insideairbnb.com/new-zealand/2025-12-11/visualisations/listings.csv")

chch_dec <- Dec2025_data |>
  filter(neighbourhood_group == "Christchurch City") |>
  mutate(MonthYear = "Dec 2025")

Nov2025_data <- read_csv("https://data.insideairbnb.com/new-zealand/2025-11-07/visualisations/listings.csv")

chch_nov <- Nov2025_data |>
  filter(neighbourhood_group == "Christchurch City") |>
  mutate(MonthYear = "Nov 2025")

Oct2025_data <- read_csv("https://data.insideairbnb.com/new-zealand/2025-10-05/visualisations/listings.csv")

chch_oct <- Oct2025_data |>
  filter(neighbourhood_group == "Christchurch City") |>
  mutate(MonthYear = "Oct 2025")

chch_all <- bind_rows(
  chch_oct, chch_nov, chch_dec,
  chch_jan, chch_feb, chch_march,
  chch_april, chch_may, chch_june
)

chch_all <- chch_all |>
  mutate(MonthYear = factor(MonthYear, levels = c(
    "Oct 2025", "Nov 2025", "Dec 2025",
    "Jan 2026", "Feb 2026", "March 2026",
    "April 2026", "May 2026", "June 2026"
  )))
chch_all <- chch_all |>
  mutate(
    last_review = as.Date(last_review),
  )
chch_all <- chch_all |> 
  mutate( 
    DataDate = case_when( 
      MonthYear == "Oct 2025" ~ as.Date("2025-10-05"),
      MonthYear == "Nov 2025" ~ as.Date("2025-11-07"), 
      MonthYear == "Dec 2025" ~ as.Date("2025-12-11"), 
      MonthYear == "Jan 2026" ~ as.Date("2026-01-16"), 
      MonthYear == "Feb 2026" ~ as.Date("2026-02-13"), 
      MonthYear == "March 2026" ~ as.Date("2026-03-17"),
      MonthYear == "April 2026" ~ as.Date("2026-04-16"),
      MonthYear == "May 2026" ~ as.Date("2026-05-23"),
      MonthYear == "June 2026" ~ as.Date("2026-06-19")
    ),
    DaysSinceLastReview = as.numeric(DataDate - last_review)
  )

chch_all |>
filter(!is.na(DaysSinceLastReview)) |>
  ggplot(aes(x = DaysSinceLastReview)) +
  geom_histogram(binwidth = 300, fill = "steelblue", color = "white") + 
  coord_cartesian(xlim =c(0,2500)) +
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
