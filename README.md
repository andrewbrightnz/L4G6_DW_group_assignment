# L4G6 Data Wrangling Group Assignment

## Project Introduction

This repository contains the work completed by Group L4G6 for the DATA201/422 group assignment. The project focuses on collaborative data wrangling, reproducible analysis, workflow modularity, and version control using Python, GitHub, and KNIME Analytics Platform.

## Notes for each deliverable
Deliverable 2:
We created a KNIME workflow to explore and analyse Airbnb listings across New Zealand. The workflow includes data selection and cleaning, date conversion, filtering, aggregation, and visualisation.

Deliverable 3:
We repeated the deliverable 2 workflow in R

Deliverable 4: 
We cleaned the air_bnb and bond_data tables ready to compare and analyse them in Deliverable 5.

The brief didnn't tell us how we would process the datasets in deliverable 5, so we made decisions on which fields to keep/discard based on common sense. We knew that if our decisions here turned out to be unsuitable, we could come back and edit the deliverable 4 code to suit deliverable 5 better.

air_bnb_chch_Oct25_to_jun_26_cleaned.csv
Keep these fields:
- id
- name
- host_id
- neighbourhood
- latitude
- longitude
- room_type
- price
- MonthYear

Remove these rows:
- duplicate rows
- location_id missing or NA


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

Bond_data.csv
Keep these fields:
- Timeframe
- Location id
- Dwelling type
- Median Rent	
- Geometric Mean Rent	
- Upper Quartile Rent	
- Lower Quartile Rent

Remove these rows:
- Location_id is missing or NA
## Datasets
For deliverable 2 we used the dataset [New Zealand listings.csv – 19 June 2026](https://data.insideairbnb.com/new-zealand/2026-06-19/visualisations/listings.csv)

Inside Airbnb describes `listings.csv` as summary information and metrics for listings that are suitable for visualisation.
This data is provided under an unknown/unspecified license, and we credit: [insideairbnb.com](insideairbnb.com)


For deliverable 5, we used the dataset [Detailed quarterly report, 2020-2026](https://www.tenancy.govt.nz/assets/Uploads/Tenancy/Rental-bond-data/Detailed-Quarterly-Tenancy-Q1-2020-Q3-2026.csv?m=5766222a0dc2d94c11545872be77333e32f7c999)

tenancy.govt.nz describes the dataset as "information about the activity level in the housing rental market since January 1993."
This data is provided under a Creative Commons license, and we credit: [The Ministry of Business, Innovation and Employment](https://www.mbie.govt.nz/)


## Dataset Columns

listings.csv
| Column | Meaning |
|---|---|
| `id` | Airbnb's unique identifier for the listing. |
| `name` | Name or title of the listing. |
| `host_id` | Airbnb's unique identifier for the host or user. A host may have multiple listings. |
| `host_name` | Display name of the host. |
| `neighbourhood_group` | Broader geographic area containing the listing, based on public geographic data. |
| `neighbourhood` | More specific neighbourhood, suburb, or local area associated with the listing. |
| `latitude` | Approximate latitude of the listing using the World Geodetic System (WGS84). |
| `longitude` | Approximate longitude of the listing using the World Geodetic System (WGS84). |
| `room_type` | Type of accommodation offered, such as an entire home or apartment, private room, shared room, or hotel room. |
| `price` | Daily listing price in local currency. |
| `minimum_nights` | Minimum number of nights required for a booking. Calendar rules may differ. |
| `number_of_reviews` | Total number of reviews received by the listing. |
| `last_review` | Date of the most recent review. |
| `reviews_per_month` | Average number of reviews received per month over the lifetime of the listing. |
| `calculated_host_listings_count` | Number of listings associated with the host in the current scrape and geographic area. |
| `availability_365` | Number of days the listing is shown as available during the next 365 days. A listing may be unavailable because it is booked or blocked by the host. |
| `number_of_reviews_ltm` | Number of reviews received during the last twelve months. |
| `license` | Licence, permit, or registration number where available. |

Further details are available in the [Inside Airbnb Data Dictionary](https://docs.google.com/spreadsheets/d/1iWCNJcSutYqpULSQHlNyGInUvHg2BoUGoNRIGa6Szc4/edit?usp=sharing).


## KNIME Workflow
The KNIME workflow is stored as:
```text
listings_assignment_clean.knwf
```

The workflow performs the following tasks:

1. Reads `listings.csv` from the provided URL (this means each user doesn't need to adjust the filepath when they use the shared file).
2. Examines the dataset using a Statistics View.
3. Selects the columns required for the analysis.
4. Handles invalid text values and converts `last_review` to a Date value.
5. Calculates the number of days between the dataset date, 19 June 2026, and each listing's most recent review.
6. Plots the distribution of days since the last review.
7. Plots the price distribution for all New Zealand listings.
8. Filters listings to Christchurch City and plots its price distribution.
9. Selects the top 10% of listings based on `number_of_reviews`.
10. Counts how many of the top-reviewed listings are located in Christchurch City.


## Python Environment

The shared virtual environment is called:

```text
l4g6_env
```

Set up the environment using the dependencies listed in `requirements.txt`.

## AI Use Acknowledgement

### Andrew
R revision
- Used Claude to put together a collection of Jupyter notebooks covering material in the R documentation to make revision of these methods easier.

Deliverable 1 (Setup project structure and GitHub):
- Used ChatGPT to help set up the Python virtual environment and `.gitignore` file.

Deliverable 2 (AirBnb data analysis):
- Used Claude for advice on which node to chose for a specific outcome and how to modify some plots (variable order etc)

Deliverable 3 (reproduce KNIME workflow and plots using R)
- Used Claude for general repo housekeeping advice (how to load and run task files from main, how to save datasets and plots)
- Used Claude to tidy Task_4
- Used too much Claude to create task_5 due to time constraints, but I've commented most lines to show understanding

Deliverable 4 (clean bond data)
- Used Claude to refactor task_4A/B/C so that the code in each task file becomes a function. Then, get main_4.r to call all of the task files in order, like we did in deliverable 3 so the user only has to run the main file.
- Used Claude to generate code that drops/keeps columns and assigns a data type 

### Jinhang

- Used OpenAI Codex to help understand the task requirements, provide guidance on using KNIME, and assist with formatting the README. The workflow and analysis were completed by Jinhang with support from other team members.


### Ruby

Deliverable 3 
- Used Claude to show me how to concatenate each months dataset together

