# Plot the distribution of price as a histogram for all New Zealand
# and Christchurch City. Both distributions are shown in the same plot.

task_3 <- function(dataset, nz_dataset) {
  # Compare both areas for the latest supplied snapshot.
  latest_date <- max(as.Date(nz_dataset$DataDate), na.rm = TRUE)
  latest_month <- as.character(nz_dataset$MonthYear[match(latest_date, as.Date(nz_dataset$DataDate))])

  nz_listings <- nz_dataset |>
    filter(as.Date(DataDate) == latest_date) |>
    mutate(
      price = parse_number(as.character(price)),
      area = "New Zealand"
    ) |>
    filter(
      !is.na(price),
      price > 0
    )

  chch_listings <- dataset |>
    filter(
      as.Date(DataDate) == latest_date
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
      subtitle = paste("New Zealand compared with Christchurch City,", latest_month),
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
  
  # Plot is saved to plots; no need to print it
  # print(p)

  # Plots folder is already created  
  # dir.create(
  #   "Plots",
  #   showWarnings = FALSE
  # )
  
  ggsave(
    filename = "Plots/Task 3 - Distribution of price.png",
    plot = p,
    width = 8,
    height = 6,
    dpi = 300,
    bg = "white"
  )
  
  invisible(p)
}

# Uncomment the line below to run this file from this window instead of from main.R
# task_3(chch_june)