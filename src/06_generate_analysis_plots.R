library(readr)
library(dplyr)
library(ggplot2)

df <- read_csv("data/processed/airbnb_and_bonds_joined.csv", show_col_types = FALSE)
dir.create("output/figures", recursive = TRUE, showWarnings = FALSE)

# 1. Christchurch Central (SA2 326600) summary
central <- df |> filter(`Location Id` == "326600") |> distinct(id, .keep_all = TRUE)
med_p <- median(central$price, na.rm = TRUE)
cat("\n======================================================\n")
cat("Updated Christchurch Central (326600) Median Nightly Price: $", round(med_p, 2), " NZD\n")
cat("======================================================\n")

# 2. Nightly price gap plot
gap_df <- df |>
  filter(!is.na(`Median Rent`), !is.na(price)) |>
  mutate(gap = price - (`Median Rent` / 7)) |>
  group_by(`Location Id`) |>
  summarise(listings = n_distinct(id), median_gap = median(gap), .groups = "drop") |>
  filter(listings >= 10) |>
  arrange(desc(median_gap)) |>
  slice_head(n = 10)

p1 <- ggplot(gap_df, aes(x = reorder(as.character(`Location Id`), median_gap), y = median_gap)) +
  geom_col(fill = "#3366A3") +
  coord_flip() +
  labs(
    title = "Largest Nightly Price Gap (Airbnb vs Long-term Rent)",
    subtitle = "Updated through August 2026 (Top 10 SA2 areas, >=10 listings)",
    x = "SA2 Area Code",
    y = "Median Gap ($ NZD)"
  ) +
  theme_minimal()

ggsave("output/figures/updated_median_price_gap.png", p1, width = 8, height = 5, dpi = 200, bg = "white")
message("Step 06 finished: Updated plots saved to output/figures/.")
