library(tidyverse)

june2026_data <- read_csv("https://data.insideairbnb.com/new-zealand/2026-06-19/visualisations/listings.csv")

chch_june <- june2026_data |>
  filter(neighbourhood_group == "Christchurch City")

May2026_data <- read_csv("https://data.insideairbnb.com/new-zealand/2026-05-23/visualisations/listings.csv")

chch_may <- May2026_data |>
  filter(neighbourhood_group == "Christchurch City")

April2026_data <- read_csv("https://data.insideairbnb.com/new-zealand/2026-04-16/visualisations/listings.csv")

chch_april <- April2026_data |>
  filter(neighbourhood_group == "Christchurch City")

March2026_data <- read_csv("https://data.insideairbnb.com/new-zealand/2026-03-17/visualisations/listings.csv")

chch_march <- March2026_data |>
  filter(neighbourhood_group == "Christchurch City")

Feb2026_data <- read_csv("https://data.insideairbnb.com/new-zealand/2026-02-13/visualisations/listings.csv")

chch_feb <- Feb2026_data |>
  filter(neighbourhood_group == "Christchurch City")

Jan2026_data <- read_csv("https://data.insideairbnb.com/new-zealand/2026-01-16/visualisations/listings.csv")

chch_jan <- Jan2026_data |>
  filter(neighbourhood_group == "Christchurch City")


Dec2025_data <- read_csv("https://data.insideairbnb.com/new-zealand/2025-12-11/visualisations/listings.csv")

chch_dec <- Dec2025_data |>
  filter(neighbourhood_group == "Christchurch City")

Nov2025_data <- read_csv("https://data.insideairbnb.com/new-zealand/2025-11-07/visualisations/listings.csv")

chch_nov <- Nov2025_data |>
  filter(neighbourhood_group == "Christchurch City")

Oct2025_data <- read_csv("https://data.insideairbnb.com/new-zealand/2025-10-05/visualisations/listings.csv")

chch_oct <- Oct2025_data |>
  filter(neighbourhood_group == "Christchurch City")

