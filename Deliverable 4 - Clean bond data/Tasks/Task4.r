# Kavya: Use the website to read up on the dataset and understand what all the columns mean
## Dataset Columns and meaning for RENTAL BOND DATA SET 
This project uses the Detailed Quarterly Tenancy rental bond
dataset published by Tenancy Services, part of the New Zealand
Ministry of Business, Innovation and Employment (MBIE).

The dataset covers rental bond statistics from Q1 2020 to Q3 2026.

Official source:
https://www.tenancy.govt.nz/about-tenancy-services/data-and-statistics/rental-bond-data/

The CSV contains 226,080 records and 12 columns.

| Column | Meaning |
|---|---|
| `TimeFrame` | The quarter or reporting period to which the rental bond statistics relate. The values are represented as dates, such as 2020-01-01 and 2026-04-01. |
| `Location Id` | A numerical identifier representing a geographical area. The identifier is used to associate rental bond statistics with a particular location. A value of -99 may represent an aggregate or unspecified geographical area. |
| `Dwelling Type` | The type of rental dwelling. Examples include House, Flat, Apartment, Room, Boarding House, and ALL. |
| `Number Of Beds` | The number of bedrooms in the rental dwelling. Values include 0, 1, 2, 3, 4, 5, 5+, 6, 9, and ALL. ALL represents an aggregation across bedroom categories. |
| `Total Bonds` | The total number of rental bonds recorded for the relevant time period, location, dwelling type, and bedroom category. |
| `Active Bonds` | The number of rental bonds that were active during the relevant reporting period. |
| `Closed Bonds` | The number of rental bonds recorded as closed during the relevant reporting period. |
| `Median Rent` | The median weekly rent for the relevant group of rental properties. Half of the reported rental values are below the median and half are above it. |
| `Geometric Mean Rent` | The geometric mean of weekly rents for the relevant group of rental properties. This provides an average that reduces the influence of very high rental values compared with an arithmetic mean. |
| `Upper Quartile Rent` | The 75th percentile of weekly rents. Approximately 75% of the reported rental values are at or below this value. |
| `Lower Quartile Rent` | The 25th percentile of weekly rents. Approximately 25% of the reported rental values are at or below this value. |
| `Log Std Dev Weekly Rent` | The standard deviation of the natural logarithm of weekly rents. It measures the dispersion of rental prices on a logarithmic scale. |

### Dataset Limitations

The dataset describes rental bond records held by Tenancy Services.
It may not represent every rental property in New Zealand.
Aggregate categories and missing values should be considered during
analysis. Geographical identifiers should be interpreted using the
official Tenancy Services documentation.
