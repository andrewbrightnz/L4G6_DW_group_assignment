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

