#' Export Fuzzy Delphi Results to CSV Files
#'
#' Exports all components of a Fuzzy Delphi analysis to separate CSV files.
#'
#' @param results A fuzzy_delphi object (output from fuzzy_delphi function).
#' @param output_dir Directory path where CSV files will be saved (default = current directory).
#' @param prefix Prefix for output file names (default = "fuzzy_delphi").
#' @return Invisible NULL. Files are written to the specified directory.
#' @export
#' @examples
#' \dontrun{
#' expert_data <- data.frame(
#'   Item1 = c(5, 4, 5, 5, 4),
#'   Item2 = c(4, 5, 4, 5, 5)
#' )
#' results <- fuzzy_delphi(expert_data)
#' export_results(results, output_dir = "output", prefix = "my_analysis")
#' }
export_results <- function(results, output_dir = ".", prefix = "fuzzy_delphi") {
  # Check if results is a fuzzy_delphi object
  if (!inherits(results, "fuzzy_delphi")) {
    stop("Input must be a fuzzy_delphi object")
  }

  # Create output directory if it doesn't exist
  if (!dir.exists(output_dir)) {
    dir.create(output_dir, recursive = TRUE)
  }

  # Export fuzzy scale values
  fuzzy_scale_file <- file.path(output_dir, paste0(prefix, "_fuzzy_scale.csv"))
  write.csv(results$fuzzy_scale, fuzzy_scale_file, row.names = TRUE)

  # Export item-level summary
  item_summary <- data.frame(
    Item = names(results$item_d_values),
    d_value = as.numeric(results$item_d_values),
    Consensus_pct = as.numeric(results$consensus_percentage),
    Defuzzification = as.numeric(results$defuzzification),
    Rank = as.numeric(results$ranking)
  )
  item_summary_file <- file.path(output_dir, paste0(prefix, "_item_summary.csv"))
  write.csv(item_summary, item_summary_file, row.names = FALSE)

  # Export overall results
  overall_results <- data.frame(
    Metric = c("Overall d-construct", "Overall consensus percentage"),
    Value = c(results$overall_d_construct, results$overall_consensus)
  )
  overall_file <- file.path(output_dir, paste0(prefix, "_overall_results.csv"))
  write.csv(overall_results, overall_file, row.names = FALSE)

  # Export defuzzification values
  defuzz_file <- file.path(output_dir, paste0(prefix, "_defuzzification.csv"))
  write.csv(results$defuzzification, defuzz_file, row.names = FALSE)

  # Export rankings
  ranking_file <- file.path(output_dir, paste0(prefix, "_rankings.csv"))
  write.csv(results$ranking, ranking_file, row.names = FALSE)

  cat("Results exported successfully to:", output_dir, "\n")
  cat("Files created:\n")
  cat("  -", basename(fuzzy_scale_file), "\n")
  cat("  -", basename(item_summary_file), "\n")
  cat("  -", basename(overall_file), "\n")
  cat("  -", basename(defuzz_file), "\n")
  cat("  -", basename(ranking_file), "\n")

  invisible(NULL)
}


#' Generate Fuzzy Delphi Report Summary
#'
#' Generates a formatted text summary report of Fuzzy Delphi analysis results.
#'
#' @param results A fuzzy_delphi object (output from fuzzy_delphi function).
#' @param output_file Optional file path to save the report. If NULL, prints to console.
#' @return Invisible NULL. Report is printed to console or saved to file.
#' @export
#' @examples
#' expert_data <- data.frame(
#'   Item1 = c(5, 4, 5, 5, 4),
#'   Item2 = c(4, 5, 4, 5, 5)
#' )
#' results <- fuzzy_delphi(expert_data)
#' generate_report(results)
generate_report <- function(results, output_file = NULL) {
  # Check if results is a fuzzy_delphi object
  if (!inherits(results, "fuzzy_delphi")) {
    stop("Input must be a fuzzy_delphi object")
  }

  # Prepare report content
  report_lines <- c()
  report_lines <- c(report_lines, "=" , rep("=", 60))
  report_lines <- c(report_lines, "FUZZY DELPHI METHOD - ANALYSIS REPORT")
  report_lines <- c(report_lines, rep("=", 60))
  report_lines <- c(report_lines, "")

  report_lines <- c(report_lines, "OVERALL RESULTS")
  report_lines <- c(report_lines, rep("-", 60))
  report_lines <- c(report_lines, paste("Overall d-construct value:", results$overall_d_construct))
  report_lines <- c(report_lines, paste("Overall consensus percentage:", results$overall_consensus, "%"))
  report_lines <- c(report_lines, "")

  # Interpretation
  if (results$overall_d_construct <= 0.2 && results$overall_consensus >= 75) {
    interpretation <- "EXCELLENT consensus achieved (d <= 0.2, consensus >= 75%)"
  } else if (results$overall_d_construct <= 0.2) {
    interpretation <- "GOOD d-construct value, but consensus percentage could be improved"
  } else if (results$overall_consensus >= 75) {
    interpretation <- "GOOD consensus percentage, but d-construct value needs improvement"
  } else {
    interpretation <- "Further rounds may be needed to achieve consensus"
  }
  report_lines <- c(report_lines, paste("Interpretation:", interpretation))
  report_lines <- c(report_lines, "")

  report_lines <- c(report_lines, "ITEM-LEVEL ANALYSIS")
  report_lines <- c(report_lines, rep("-", 60))

  # Item summary table
  item_summary <- data.frame(
    Item = names(results$item_d_values),
    d_value = sprintf("%.2f", as.numeric(results$item_d_values)),
    Consensus = sprintf("%.2f%%", as.numeric(results$consensus_percentage)),
    Defuzz = sprintf("%.4f", as.numeric(results$defuzzification)),
    Rank = as.numeric(results$ranking)
  )

  # Convert to text table
  report_lines <- c(report_lines, "")
  for (i in 1:nrow(item_summary)) {
    line <- sprintf("%-15s | d=%-6s | Consensus=%-7s | Defuzz=%-7s | Rank=%d",
                    item_summary$Item[i],
                    item_summary$d_value[i],
                    item_summary$Consensus[i],
                    item_summary$Defuzz[i],
                    item_summary$Rank[i])
    report_lines <- c(report_lines, line)
  }

  report_lines <- c(report_lines, "")
  report_lines <- c(report_lines, rep("=", 60))
  report_lines <- c(report_lines, "")

  # Output report
  if (is.null(output_file)) {
    # Print to console
    cat(paste(report_lines, collapse = "\n"))
    cat("\n")
  } else {
    # Write to file
    writeLines(report_lines, output_file)
    cat("Report saved to:", output_file, "\n")
  }

  invisible(NULL)
}
