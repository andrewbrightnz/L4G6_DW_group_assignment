library(tidyverse)

data <- read_csv("https://data.insideairbnb.com/new-zealand/2026-06-19/visualisations/listings.csv")

chch <- data |>
  filter(neighbourhood_group == "Christchurch City")