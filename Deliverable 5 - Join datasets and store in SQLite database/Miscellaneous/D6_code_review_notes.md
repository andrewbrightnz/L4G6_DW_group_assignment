# Deliverable 6: D5 code review notes

AI used: OpenAI Codex helped review and edit the R code. We checked the changes by running the pipeline and inspecting its outputs.

## What changed and why

- The main script now checks for missing packages and gives a clear error instead of installing software during a run. It calls each task once and no longer loads the empty Task 5F file.
- Task 5AA no longer runs just because its file is sourced. This avoids accidentally overwriting cleaned CSV files. It also checks for `-99` in one pass instead of two.
- Task 5A checks that a saved SA2 result still matches the cleaned Airbnb input before reusing it. It asks for the Koordinates API key only when rows still need codes. This helps prevent a stale join and avoids unnecessary API calls.
- Task 5B stops if dates or SA2 codes are missing, if the rental table has duplicate area-quarter rows, or if the join changes the Airbnb row count. These are simple checks for likely data mistakes.
- Task 5C now hides the long CSV column message and stops clearly when Christchurch Central has no listings.
- Task 5D keeps the median-gap calculation and minimum of 10 listings, but uses a simple top-10 bar chart instead of a boxplot. Task 5E shows 10 areas instead of 20 so its chart is easier to read.

## Example sanity check for the tutor

After Task 5B, compare the number of Airbnb rows before and after the left join. A left join should retain every Airbnb row. On the current data, both counts are **28,290**. The code stops if they differ. We also checked that **21,566** joined rows have a median rent value; missing rent values remain missing rather than being treated as zero.

## Run and limits

From the project root, run `Rscript "Deliverable 5 - Join datasets and store in SQLite database/Tasks/main_5.r"`. The current saved SA2 file has codes for all 28,290 Airbnb rows, so this run does not call the API. Task 5F is empty; the current main script does not create a new SQLite database. That remains a separate pipeline gap if the team still intends to store the joined data there.
