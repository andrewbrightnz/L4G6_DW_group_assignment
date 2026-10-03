# L4G6 Data Wrangling Group Assignment

## Project Introduction

This repository contains the work completed by Group L4G6 for the DATA201/422 group assignment. The project focuses on collaborative data wrangling, reproducible analysis, workflow modularity, and version control using Python, GitHub, and KNIME Analytics Platform.

# Notes for each deliverable
## Deliverable 2:
We created a KNIME workflow to explore and analyse Airbnb listings across New Zealand. The workflow includes data selection and cleaning, date conversion, filtering, aggregation, and visualisation.

## Deliverable 3:
We recreated the deliverable 2 workflow in R
Added the July 2026 and August 2026 `listings.csv` datasets to Task 1 and updated the analyses and plots.

## Deliverable 4: 
We cleaned the air_bnb and bond_data tables ready to compare and analyse them in Deliverable 5.

The brief didn't tell us how we would process the datasets in deliverable 5, so we made decisions on which fields to keep/discard based on common sense. We knew that if our decisions here turned out to be unsuitable, we could come back and edit the deliverable 4 code to suit deliverable 5 better.

```air_bnb_chch_Oct25_to_jun_26_cleaned.csv```
Keep these fields:
- ```id```
- ```name```
- ```host_id```
- ```neighbourhood```
- ```latitude```
- ```longitude```
- ```room_type```
- ```price```
- ```MonthYear```

Remove these rows:
- ```host name```
- ```neighbourhood group```
- ```minimum nights```
- ```number of reviews```
- ```last review```
- ```reviews per month```
- ```calculated_host_listings_count```
- ```availability_365```
- ```number_of_reviews_ltm```
- ```license```
- ```duplicate rows```
- ```ocation_id``` missing or ```NA```

We removed anything to do with reviews because it doesn't seem relevant for the next deliverable with bond dataset. Removed licence as 
most/all the values were NA, it also didn't seem too relevant with the bond dataset. 
  

Only column with missing values was price. We found that 10667 prices were missing. Looking at how many prices were missing per month
Dec 2025, Jan 2026 and Feb 2026 had a significant amount more missing prices than the other months. Roughly 3000 missing prices vs 100-200 missing prices. This indicates that price is not missing at random for the months Dec 2025, Jan 2026 and Feb 2026 so we filled in the prices with the other months price for that same airbnb by matching the ID. We did this across all months. After filling it in the missing prices was significantly lower with Dec 2025, Jan 2026 and Feb 2026's missing prices ranging from 100-350. 

Another decision that was made was about outliers. This dataset had significantly large outliers with 4 different houses being $43654 per night in Nov 2025 and then the same 4 houses being $43188 in Oct 2025. These houses all had the same host id and so we concluded that this was an error and not a true value, therefore the price is changed to NA and so will be removed later. 

Another outlier was a single airbnb with a cost of $22971 per night in May 2026. Looking further, this airbnb appears in the dataset multiple other times for much cheaper (around $173 - $491). So this was changed to its previous months (April 2026) price of $491. 

The highest price left in the dataset is $6277 per night. Although, this is still very high, we decided to leave it in as it is plausible and we found no indication that it is an error. 

Without price, we assumed the row would not be much help for this dataset so we removed all rows with missing prices. This was 505 rows. This is much better than if 10667 rows removed (if we didn't fill in some of the prices). At the beginning, we started with 28795 rows and after cleaning we have 28290 rows. 

We also checked that all prices were valid (not 0 or negative values, checked for consistency of neighbourhood and room type where we found no issues. We also checked the latitude and longitude to make sure all rows were within the correct bounds. Banks Peninsula was outside the initial bounds but this is legitimate and not an error. 

## Deliverable 6
Made a output folder so that both the input data and output data aren't sitting in the same folder. Before we had a data and a tasks folder, now we have Data, Tasks and Output. 

Define parameters so there aren't random numbers floating around. Instead they are defined at the top of the file and then used later in the file. 

Added and deleted code where it made sense. Keeping code accurate. Not putting numbers in the code which would be wrong if a different file is uploaded. 

## Dataset Columns and meaning for ```RENTAL BOND DATA SET```
This project uses the Detailed Quarterly Tenancy rental bond dataset published by Tenancy Services, part of the New Zealand Ministry of Business, Innovation and Employment (MBIE).

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

```Bond_data.csv```
Keep these fields:
- ```Timeframe```
- ```Location id```
- ```Dwelling type```
- ```Median Rent```
- ```Geometric Mean Rent```	
- ```Upper Quartile Rent```
- ```Lower Quartile Rent```

Remove these rows:
- ```Location_id``` is ```missing``` or ```NA```

## Datasets
For **deliverable 2** we used the dataset [New Zealand listings.csv – 19 June 2026](https://data.insideairbnb.com/new-zealand/2026-06-19/visualisations/listings.csv)

Inside Airbnb describes `listings.csv` as summary information and metrics for listings that are suitable for visualisation.
This data is provided under an unknown/unspecified license, and we credit: [insideairbnb.com](insideairbnb.com)


For **deliverable 5**, we used the dataset [Detailed quarterly report, 2020-2026](https://www.tenancy.govt.nz/assets/Uploads/Tenancy/Rental-bond-data/Detailed-Quarterly-Tenancy-Q1-2020-Q3-2026.csv?m=5766222a0dc2d94c11545872be77333e32f7c999)

tenancy.govt.nz describes the dataset as "information about the activity level in the housing rental market since January 1993."
This data is provided under a Creative Commons license, and we credit: [The Ministry of Business, Innovation and Employment](https://www.mbie.govt.nz/)

We also used the [Statistical Area 2 2025](https://koordinates.com/from/datafinder.stats.govt.nz/layer/120978-statistical-area-2-2025/) from Koordinates.com

We can get information from this dataset through an API call.
EXAMPLE: 
```
https://koordinates.com/services/query/v1/raster.json?key=KEY&layer=8678&x=175.60821450000003&y=-40.3523065
```

We made an API call to get the LocationId/SA2 code associated with the latitude-longitude combination for each row:
``` 
    api_key  <- Sys.getenv("KOORDINATES_API_KEY")
    layer_id <- "120978"
```

Then:
```    
    resp <- request("https://koordinates.com/services/query/v1/vector.json") |>
    req_url_query(
        key   = api_key,
        layer = layer_id,
        x     = df$longitude[i],   # x = longitude
        y     = df$latitude[i]     # y = latitude
    ) |>
```

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


Set up the environment using the dependencies listed in `requirements.txt`.



# AI Use Acknowledgement

## Andrew

### R revision
- Used Claude to put together a collection of Jupyter notebooks covering material in the R documentation to make revision of these methods easier.

### Deliverable 1 (Setup project structure and GitHub):
- Used ChatGPT to help set up the Python virtual environment and `.gitignore` file.

### Deliverable 2 (AirBnb data analysis using KNIME):
- Used Claude for advice on which node to chose for a specific outcome and how to modify some plots (variable order etc)

### Deliverable 3 (reproduce KNIME workflow and plots using R)
- Used Claude for general repo housekeeping advice (how to load and run task files from main, how to save datasets and plots)
- Used Claude to tidy Task_4
- Used too much Claude to create task_5 due to time constraints, but I've commented most lines to show understanding

### Deliverable 4 (clean bond data)
- Used Claude to refactor task_4A/B/C so that the code in each task file becomes a function. Then, get main_4.r to call all of the task files in order, like we did in deliverable 3 so the user only has to run the main file.
- Used Claude to generate code that drops/keeps columns and assigns a data type 

### Deliverable 5: (Insert Location Id/SA2 codes into airbnb dataset)
- Used Claude to create the API call, run in batches of 5, only on rows where the Location Id is missing. Save file after each batch in case of crash part way through the 2.5 hour run.
- Minor help from Claude to trigger task_5A from main.r
- Minor help from Claude tidying up the files

### Deliverable 6: (Apply best coding practices)
As specifically instructed in the brief, I used ```Claude Opus 5.5``` to'construct a 'design principles' document for [y]our pipeline, describing:
1) the inputs to the pipeline
2) the outputs from the pipeline
3) the main steps in the pipeline
4) an overall coding or software strategies adopted in the project.

## Jinhang

### Deliverable 2 (AirBnb data analysis using KNIME):
- Used OpenAI Codex to help understand the task requirements, provide guidance on using KNIME, and assist with formatting the README. The workflow and analysis were completed by Jinhang with support from other team members.


## Ruby

### Deliverable 3 (reproduce KNIME workflow and plots using R)
- Used Claude to show me how to concatenate each months dataset together

###kavya
changes made in deliverable 3 code as we have given the code for each month different, i have merged and gave it in a single code chunk
For sanity check i have made changes to task 4


## Deliverable 7: Pipeline Automation & Ingestion of July–August 2026 Data

In Deliverable 7, we converted the multi-step wrangling process into an end-to-end automated data pipeline that runs via a single command. We also integrated the latest Inside Airbnb snapshots for **July 2026** and **August 2026** to update our earlier analyses and rental comparisons.

### 1. Key Additions & Architectural Changes
- **Configuration Management (`config.yaml`)**:
  - Centralised all project parameters, directory paths, geographical boundary thresholds, and data snapshot URLs (spanning October 2025 through August 2026) in one configuration file, following lecture best practices.
- **Root Orchestration (`main.R` & `Makefile`)**:
  - Implemented a root orchestrator (`main.R`) that sequentially triggers modular processing scripts in `src/` using `source()`.
  - Added a `Makefile` to enable single-command reproduction (`make all` or `Rscript main.R`).
- **Resilient API Caching (`src/04_lookup_sa2.R`)**:
  - To prevent redundant and rate-limited API calls across tens of thousands of listings, the pipeline caches unique coordinate pairs and seeds from previous Deliverable 5 lookups.
  - Adding July and August 2026 data required querying the Koordinates vector query API for only **151 newly observed coordinate pairs**, dramatically reducing runtime and protecting API quotas.
- **Fail-Fast Checks & Defensive Programming**:
  - Replaced ad-hoc manual checks with assertions (`stopifnot`) that validate schema integrity, coordinate boundaries, date parsing, and table join row counts.
  - Handled missing and imputed values with appropriate warning logs.
- **Automated Storage & Exports**:
  - Cleaned data and joins are automatically written to SQLite (`output/database/rental_comparison.db`) and exported as flat CSV files (`data/processed/`).

### 2. Pipeline Execution Steps (`src/`)
1. `src/01_ingest_airbnb.R`: Ingests and tags all 11 monthly Inside Airbnb snapshots for New Zealand and filters for Christchurch City (35,796 total rows).
2. `src/02_clean_airbnb.R`: Validates coordinates within Greater Christchurch bounds, handles price outliers (> $7,000 NZD), performs bidirectional imputation for missing listing prices, and drops unresolvable records (35,192 records retained).
3. `src/03_ingest_clean_bond.R`: Automatically downloads MBIE quarterly bond data, filters for target reporting periods, and removes unallocated areas (`-99`).
4. `src/04_lookup_sa2.R`: Matches Airbnb coordinates to Stats NZ SA2 2025 boundaries (`layer 120978`) using the cached Koordinates API workflow.
5. `src/05_join_and_sqlite.R`: Aligns monthly Airbnb observations to quarterly bond reporting periods, performs a verified many-to-one left join on `Location Id` and `TimeFrame`, and persists tables to an SQLite database.
6. `src/06_generate_analysis_plots.R`: Calculates updated metrics and regenerates the nightly price gap visualization.

### 3. Updated Findings (October 2025 – August 2026)
- **Christchurch Central (SA2 326600)**: Updated median Airbnb nightly price across unique listings is **$254.00 NZD**.
- **Updated Analysis Output**: Visual comparisons between short-term Airbnb prices and long-term rental rates are saved to `output/figures/updated_median_price_gap.png`.

### 4. How to Reproduce
From the project root directory, run:
```bash
# Set your Koordinates API key (PowerShell)
$env:KOORDINATES_API_KEY="your_api_key_here"

# Execute the complete automated pipeline
make all
# Alternatively:
Rscript main.R

