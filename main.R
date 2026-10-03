# main.R
# DATA201/422 - Deliverable 7 Pipeline Orchestrator

message("=== Starting Automated Data Pipeline ===")

source("src/01_ingest_airbnb.R")
source("src/02_clean_airbnb.R")
source("src/03_ingest_clean_bond.R")
source("src/04_lookup_sa2.R")
source("src/05_join_and_sqlite.R")
source("src/06_generate_analysis_plots.R")

message("=== Automated Pipeline Completed Successfully! ===")
