# Kavya: Find median Airbnb price in Christchurch central (see project board for details)

task_5C <- function() {
    # Open the joined airbnb and rental data
    # Find median etc
    # print result?
}
# 1. Median Airbnb price in Christchurch Central (326600)
library(tidyverse)

# 1. Use the loaded airbnb dataset
df_raw <- airbnb

# 2. Clean price column & standardize Location Id
df_clean <- df_raw %>%
  mutate(
    price_clean = parse_number(as.character(price)),
    location_id = as.character(`Location Id`)
  )

# 3. Filter for Christchurch Central (SA2 code: 326600)
chch_central <- df_clean %>%
  filter(location_id == "326600")

# 4. Deduplicate Airbnb listings by unique ID
chch_central_unique <- chch_central %>%
  distinct(id, .keep_all = TRUE)

# 5. Calculate summary statistics
median_price <- median(chch_central_unique$price_clean, na.rm = TRUE)
mean_price   <- mean(chch_central_unique$price_clean, na.rm = TRUE)
listing_cnt  <- sum(!is.na(chch_central_unique$price_clean))

# 6. Print the result
cat("\n======================================================\n")
cat("PART 1 RESULTS: Christchurch Central (Location ID 326600)\n")
cat("======================================================\n")
cat(sprintf("Total unique listings:       %d\n", listing_cnt))
cat(sprintf("Median AirBnB Nightly Price: $%.2f NZD\n", median_price))
cat(sprintf("Mean AirBnB Nightly Price:   $%.2f NZD\n", mean_price))
cat("======================================================\n")