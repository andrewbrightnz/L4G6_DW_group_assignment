# Plot the distribution of price as a histogram for all New Zealand
# and Christchurch City. Both distributions are shown in the same plot.

library(tidyverse)

# Read the complete New Zealand listings dataset
june2026_data <- read_csv(
  "https://data.insideairbnb.com/new-zealand/2026-06-19/visualisations/listings.csv"
)

task_3 <- function(nz_data) {
  
  # Clean the price column and remove invalid prices
  nz_listings <- nz_data |>
    mutate(
      price = parse_number(as.character(price))
    ) |>
    filter(
      !is.na(price),
      price > 0
    ) |>
    mutate(
      area = "New Zealand"
    )
  
  chch_listings <- nz_listings |>
    filter(
      neighbourhood_group == "Christchurch City"
    ) |>
    mutate(
      area = "Christchurch City"
    )
  
  plot_data <- bind_rows(
    nz_listings |>
      select(price, area),
    chch_listings |>
      select(price, area)
  )
  
  x_max <- quantile(
    nz_listings$price,
    0.99,
    na.rm = TRUE
  )
  
  bin_width <- x_max / 40
  
  price_plot <- ggplot(
    plot_data,
    aes(
      x = price,
      y = after_stat(density),
      fill = area,
      colour = area
    )
  ) +
    geom_histogram(
      position = "identity",
      binwidth = bin_width,
      boundary = 0,
      alpha = 0.4
    ) +
    coord_cartesian(
      xlim = c(0, x_max)
    ) +
    scale_fill_manual(
      values = c(
        "New Zealand" = "#4C78A8",
        "Christchurch City" = "#F28E2B"
      )
    ) +
    scale_colour_manual(
      values = c(
        "New Zealand" = "#2F5D8A",
        "Christchurch City" = "#A85600"
      )
    ) +
    labs(
      title = "Distribution of Airbnb Listing Prices",
      subtitle = "New Zealand compared with Christchurch City",
      x = "Price per night (NZD)",
      y = "Density",
      fill = NULL,
      colour = NULL
    ) +
    theme_minimal() +
    theme(
      legend.position = "top",
      panel.grid.minor = element_blank()
    )
  
  return(price_plot)
}

task_3(june2026_data)