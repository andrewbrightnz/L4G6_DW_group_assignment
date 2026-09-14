library(tidyverse)

# Load the data from the internet and save to bond_data
bond_data <- read_csv("https://www.tenancy.govt.nz/assets/Uploads/Tenancy/Rental-bond-data/Detailed-Quarterly-Tenancy-Q1-2020-Q3-2026.csv?m=5766222a0dc2d94c11545872be77333e32f7c999")

# Save the data to a csv file in the Data folder
write_csv(bond_data, "Deliverable 4 -/Data/bond_data.csv")
