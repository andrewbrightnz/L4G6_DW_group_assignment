# Kavya: Find area with largest variance in rental prices (see project board for details)

task_5D <- function() {
    # Open the joined airbnb and rental data
    # Find largest variance etc
    # print result?
}
# Task 5D: Finding the Largest Gap Between Short- & Long-Term Rental Prices

library(tidyverse)

# ------------------------------------------------------------------------------
# 1. Clean and standardize the AirBnB data
# ------------------------------------------------------------------------------
# Kavya: Find median Airbnb price in Christchurch central (see project board for details)

airbnb_clean <- airbnb %>%
  mutate(
    airbnb_id         = as.character(id),
    location_id       = as.character(`Location Id`),
    airbnb_nightly    = parse_number(as.character(price)),
    time_key          = as.character(TimeFrame)
  ) %>%
  filter(!is.na(airbnb_nightly), !is.na(location_id), !is.na(time_key))

# ------------------------------------------------------------------------------
# 2. Clean and standardize the Rental Bond data
# ------------------------------------------------------------------------------
rental <- read_csv("Deliverable 5 - Join datasets and store in SQLite database/Data/rental_chch_Oct25_to_Jun26_cleaned.csv")
rental_clean <- rental %>%
  mutate(
    location_id       = as.character(`Location Id`),
    long_term_weekly  = parse_number(as.character(`Median Rent`)),
    long_term_nightly = long_term_weekly / 7,  # Convert weekly bond rent to nightly equivalent
    time_key          = as.character(TimeFrame)
  ) %>%
  filter(!is.na(long_term_nightly), !is.na(location_id), !is.na(time_key))

# ------------------------------------------------------------------------------
# 3. Join the datasets on Location and TimeFrame
# ------------------------------------------------------------------------------

joined_data <- inner_join(
  airbnb_clean,
  rental_clean,
  by = c("location_id", "time_key"),
  relationship = "many-to-many"
) %>%
  mutate(
    price_gap_per_night = airbnb_nightly - long_term_nightly
  )

# ------------------------------------------------------------------------------
# 4. Filter for sample reliability & rank areas by median gap
# ------------------------------------------------------------------------------
min_listings <- 10

area_summary <- joined_data %>%
  group_by(location_id) %>%
  summarise(
    listing_count = n(),
    median_gap    = median(price_gap_per_night, na.rm = TRUE),
    mean_gap      = mean(price_gap_per_night, na.rm = TRUE),
    min_gap       = min(price_gap_per_night, na.rm = TRUE),
    max_gap       = max(price_gap_per_night, na.rm = TRUE),
    .groups       = "drop"
  ) %>%
  filter(listing_count >= min_listings) %>%
  arrange(desc(median_gap))

# Print results to Console
cat("\n========================================================================\n")
cat("TOP 10 LOCATIONS WITH THE CRAZIEST (LARGEST) PRICE GAP (Short - Long/7)\n")
cat("========================================================================\n")
print(head(area_summary, 10))

# ------------------------------------------------------------------------------
# 5. Plot the distribution of price gaps per location ID
# ------------------------------------------------------------------------------
top_10_locations <- head(area_summary$location_id, 10)

plot_data <- joined_data %>%
  filter(location_id %in% top_10_locations) %>%
  mutate(location_id = factor(location_id, levels = top_10_locations))

p <- ggplot(plot_data, aes(x = location_id, y = price_gap_per_night, fill = location_id)) +
  geom_boxplot(outlier.shape = NA, alpha = 0.75, show.legend = FALSE) +
  geom_hline(yintercept = 0, linetype = "dashed", color = "red", linewidth = 0.8) +
  coord_cartesian(ylim = c(
    quantile(plot_data$price_gap_per_night, 0.05, na.rm = TRUE),
    quantile(plot_data$price_gap_per_night, 0.95, na.rm = TRUE)
  )) +
  theme_minimal(base_size = 12) +
  labs(
    title = "Distribution of Short- vs Long-Term Nightly Rental Gap",
    subtitle = "Top 10 Christchurch Locations by Median Gap (Short-Term - Long-Term/7)",
    x = "Location ID (Stats NZ SA2)",
    y = "Price Difference per Night ($NZD)"
  ) +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    plot.title = element_text(face = "bold")
  )

print(p)