task_5 <- function(dataset) {
  nz_number_of_reviews_ltm <- dataset |>
    # Keep only necessary columns
    select(id, name, neighbourhood_group, number_of_reviews_ltm)
  # Find the top 10 percent of last-twelve-months-reviews
  threshold <- quantile(nz_number_of_reviews_ltm$number_of_reviews_ltm, 0.90, na.rm = TRUE)
  nz_number_of_reviews_ltm_top_10pc <- nz_number_of_reviews_ltm |>
    filter(number_of_reviews_ltm >= threshold)
  
  # Assign the plot to a variable (p)
  p <- nz_number_of_reviews_ltm_top_10pc |>
    ggplot(aes(x = number_of_reviews_ltm)) +
    geom_histogram(binwidth = 5, fill = "steelblue", color = "white") +   # set bar attributes
    coord_cartesian(xlim = c(NA, 150)) +                                  # Display only under 150 reviews
    labs(                                                                 # Set title and axis labels
      title = "Number of reviews (top 10% for all of New Zealand)",
      x = "Number of reviews in the last 12 months",
      y = "Number of listings"
    )
  
  # Save the plot to a file
  ggsave(
    filename = "Plots/Task 5a - Highest number of reviews.png",           # Set plot attributes
    plot = p, 
    width = 12, 
    height = 6, 
    dpi = 300
  )
  
  # Find how many top 10 percent reviews are in Christchurch
    chch_in_top_10 <- nz_number_of_reviews_ltm_top_10pc |>
    # Filter by "Christchurch City" and count the number of rows (one row = one listing)
    filter(neighbourhood_group == "Christchurch City") |>
    nrow()
  
  # Count top-10% listings by neighbourhood_group, highlighting Christchurch City
  neighbourhood_counts <- nz_number_of_reviews_ltm_top_10pc |>
    count(neighbourhood_group) |>                                       # count the number in each area
    mutate(is_chch = neighbourhood_group == "Christchurch City")        # identify those in Christchurch
  
  p2 <- neighbourhood_counts |>
    ggplot(aes(x = reorder(neighbourhood_group, -n), y = n, fill = is_chch)) +
    geom_col() +
    scale_fill_manual(values = c("TRUE" = "steelblue", "FALSE" = "grey70"), guide = "none") +   # colour chch red, others grey
    labs(
      # Use the 'top 10 in Christchurch' value in the title
      title = paste0("Top 10% listings by area (Christchurch highlighted)\n", chch_in_top_10, " are in Christchurch"),
      x = "Area",
      y = "Number of listings"
    ) +
    theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 6))   # set label attributes (small, angled)
  
  # Save the plot to Plots folder
  ggsave(
    filename = "Plots/Task 5b - Top 10 percent by neighbourhood.png",
    plot = p2,                                                            # set plot attributes
    width = 8, 
    height = 6, 
    dpi = 300
  )
}

# Uncomment these to test run from this window instead of main.R
# nz_Oct25_to_Jun26 <- read_csv("Data/nz_Oct25_to_Jun26.csv") 
# task_5(nz_Oct25_to_Jun26)