# Produce summary statistics for every column and save the results as a CSV.

task_2 <- function(chch_Oct25_to_Aug26) {
  summary_data <- chch_Oct25_to_Aug26
  
  character_columns <- sapply(summary_data, is.character)
  
  summary_data[character_columns] <- lapply(
    summary_data[character_columns],
    as.factor
  )

  summary_results <- lapply(
    summary_data,
    summary
  )

  summary_table <- data.frame(
    column = names(summary_data),
    
    summary = sapply(
      summary_results,
      function(x) paste(
        names(x),
        x,
        sep = ": ",
        collapse = " | "
      )
    ),
    
    standard_deviation = sapply(
      summary_data,
      function(x) {
        if (is.numeric(x)) {
          sd(x, na.rm = TRUE)
        } else {
          NA
        }
      }
    ),
    
    missing_count = sapply(
      summary_data,
      function(x) sum(is.na(x))
    ),
    
    row.names = NULL
  )
  dir.create(
    "Data",
    showWarnings = FALSE
  )
  
  write.csv(
    summary_table,
    "Data/chch_Oct25_to_Aug26_summary_stats.csv",
    row.names = FALSE,
    na = ""
  )
  
  print(summary_table)
  
  invisible(summary_table)
}
