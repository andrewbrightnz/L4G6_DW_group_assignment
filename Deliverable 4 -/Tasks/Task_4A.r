# Ruby: Clean the Christchurch dataset

# Open airbnb_chch_Oct25_to_Jun26.csv

# Return or save to disk: airbnb_chch_Oct25_to_Jun26_cleaned
library(tidyverse)

airbnb_chch_Oct25_Jun26 <- read_csv("Deliverable 4 -/Data/airbnb_chch_Oct25_to_Jun26.csv")

# selecting the rows we want to keep
airbnb_chch_Oct25_Jun26 <- airbnb_chch_Oct25_Jun26 |>
  select(id, name, host_id, neighbourhood, latitude, longitude, room_type, price, MonthYear)

# number of rows = 28795
nrow(airbnb_chch_Oct25_Jun26)

# sum of how many missing values are in each column (all 0 except price = 10667)
colSums(is.na(airbnb_chch_Oct25_Jun26))

#removing rows where each column is identical
airbnb_chch_Oct25_Jun26 <- airbnb_chch_Oct25_Jun26 |>
  distinct()

#check how many exactly duplicated rows there are now = 0 
sum(duplicated(airbnb_chch_Oct25_Jun26))

# number of rows = 28795
nrow(airbnb_chch_Oct25_Jun26)

# sum of duplicated ids = 24678
sum(duplicated(airbnb_chch_Oct25_Jun26$id))

# sum of number of rows in price column with NA = 10667
sum(is.na(airbnb_chch_Oct25_Jun26$price))

#removing NA price rows
airbnb_chch_Oct25_Jun26 <- airbnb_chch_Oct25_Jun26 |>
  filter(!is.na(price))

# number of rows with NA now = 0
sum(is.na(airbnb_chch_Oct25_Jun26$price))

# updated number of rows = 18128
nrow(airbnb_chch_Oct25_Jun26)

