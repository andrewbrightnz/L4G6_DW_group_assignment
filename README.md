# L4G6 Data Wrangling Group Assignment

## Project Introduction

This repository contains the work completed by Group L4G6 for the DATA201/422 group assignment. The project focuses on collaborative data wrangling, reproducible analysis, workflow modularity, and version control using Python, GitHub, and KNIME Analytics Platform.

For Deliverable 2, we created a KNIME workflow to explore and analyse Airbnb listings across New Zealand. The workflow includes data selection and cleaning, date conversion, filtering, aggregation, and visualisation.

## Dataset

The dataset used is `listings.csv` for New Zealand, dated **19 June 2026**, from [Inside Airbnb – Get the Data](https://insideairbnb.com/get-the-data/).

Direct dataset link:

[New Zealand listings.csv – 19 June 2026](https://data.insideairbnb.com/new-zealand/2026-06-19/visualisations/listings.csv)

Inside Airbnb describes `listings.csv` as summary information and metrics for listings that are suitable for visualisation. The dataset is not stored in this repository because of its size. Each team member must download it and store it locally.

## Dataset Columns

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

1. Reads the locally stored `listings.csv`.
2. Examines the dataset using a Statistics View.
3. Selects the columns required for the analysis.
4. Handles invalid text values and converts `last_review` to a Date value.
5. Calculates the number of days between the dataset date, 19 June 2026, and each listing's most recent review.
6. Plots the distribution of days since the last review.
7. Plots the price distribution for all New Zealand listings.
8. Filters listings to Christchurch City and plots its price distribution.
9. Selects the top 10% of listings based on `number_of_reviews`.
10. Counts how many of the top-reviewed listings are located in Christchurch City.

## Main Results

- Listing prices in both New Zealand and Christchurch City are strongly right-skewed. Most listings are concentrated in the lower price range, while a small number have much higher prices.
- The distribution of days since the last review is also right-skewed.
- The dataset contains 50,932 listings. Therefore, the strict top 10% was defined as the first 5,094 listings after sorting `number_of_reviews` in descending order.
- Under this strict top-10% method, **342 listings are located in Christchurch City**.
- The boundary value is 185 reviews. If every listing tied at this boundary is included, the selection contains 5,130 listings, including 343 in Christchurch City. The workflow uses the strict 5,094-row interpretation.

## Running the KNIME Workflow

1. Download the New Zealand `listings.csv` file using the link above.
2. Store the file locally and do not add it to GitHub.
3. Import `listings_assignment_clean.knwf` into KNIME Analytics Platform.
4. Open the CSV Reader node and update its source path to the local location of `listings.csv`.
5. Execute the complete workflow.

## Python Environment

The shared virtual environment is called:

```text
l4g6_env
```

Set up the environment using the dependencies listed in `requirements.txt`.

## AI Use Acknowledgement

### Andrew

- Used AI assistance to help set up the Python virtual environment and `.gitignore` file.

### Jinhang

- Used OpenAI Codex to help understand the task requirements, provide guidance on using KNIME, and assist with formatting the README. The workflow and analysis were completed by Jinhang with support from other team members.