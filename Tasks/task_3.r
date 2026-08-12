# Plot the distribution of price as a histogram for all New Zealand
# and Christchurch City. Both distributions are shown in the same plot.

task_3 <- function(chch_Oct25_to_Jun26) {

  nz_listings <- read_csv(
    "https://data.insideairbnb.com/new-zealand/2026-06-19/visualisations/listings.csv",
    show_col_types = FALSE
  ) |>
    mutate(
      price = parse_number(as.character(price)),
      area = "New Zealand"
    ) |>
    filter(
      !is.na(price),
      price > 0
    )

  chch_listings <- chch_Oct25_to_Jun26 |>
    filter(
      as.character(MonthYear) == "June 2026"
    ) |>
    mutate(
      price = parse_number(as.character(price)),
      area = "Christchurch City"
    ) |>
    filter(
      !is.na(price),
      price > 0
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

  p <- ggplot(
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
      subtitle = "New Zealand compared with Christchurch City, June 2026",
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
  
  print(p)
  
  invisible(p)
}