#' Fuzzy Delphi Method - Complete Analysis
#'
#' Performs a complete Fuzzy Delphi Method analysis including conversion to fuzzy
#' numbers, fuzzy scale calculation, consensus analysis, defuzzification, and ranking.
#'
#' @param data A data frame containing expert responses with Likert scale values.
#'   Rows represent experts, columns represent items.
#' @param likert_scale The type of Likert scale used: either 5 or 7 (default = 5).
#' @param consensus_threshold Threshold for consensus determination (default = 0.2).
#' @return A list containing:
#'   \itemize{
#'     \item \code{fuzzy_data}: Converted fuzzy triangular numbers
#'     \item \code{fuzzy_scale}: Fuzzy distance values for each expert and item
#'     \item \code{item_d_values}: Average d-value for each item
#'     \item \code{consensus_percentage}: Consensus percentage for each item
#'     \item \code{defuzzification}: Defuzzified values for each item
#'     \item \code{ranking}: Item rankings based on defuzzified values
#'     \item \code{overall_d_construct}: Overall construct d-value
#'     \item \code{overall_consensus}: Overall consensus percentage
#'   }
#' @export
#' @examples
#' # Example with Likert-5 data
#' expert_data <- data.frame(
#'   Item1 = c(5, 4, 5, 5, 4),
#'   Item2 = c(4, 5, 4, 5, 5),
#'   Item3 = c(3, 4, 3, 4, 3)
#' )
#' results <- fuzzy_delphi(expert_data, likert_scale = 5)
#' print(results$ranking)
fuzzy_delphi <- function(data, likert_scale = 5, consensus_threshold = 0.2) {
  # Input validation
  if (!is.data.frame(data) && !is.matrix(data)) {
    stop("Data must be a data frame or matrix")
  }

  if (!likert_scale %in% c(5, 7)) {
    stop("Likert scale must be either 5 or 7")
  }

  # Convert to fuzzy triangular numbers
  if (likert_scale == 5) {
    fuzzy_data <- likert5_to_fuzzy(data)
  } else {
    fuzzy_data <- likert7_to_fuzzy(data)
  }

  # Calculate fuzzy scale (d-values)
  fuzzy_scale <- calculate_fuzzy_scale(fuzzy_data)

  # Calculate average d-value for each item
  item_d_values <- colMeans(fuzzy_scale, na.rm = TRUE)
  item_d_values <- round(item_d_values, 2)

  # Calculate consensus percentage
  consensus_pct <- calculate_consensus(fuzzy_scale, threshold = consensus_threshold)

  # Calculate overall d-construct
  overall_d_construct <- mean(item_d_values, na.rm = TRUE)
  overall_d_construct <- round(overall_d_construct, 2)

  # Calculate overall consensus percentage
  overall_consensus <- mean(as.numeric(consensus_pct), na.rm = TRUE)
  overall_consensus <- round(overall_consensus, 2)

  # Defuzzification
  defuzz_values <- defuzzify(fuzzy_data)

  # Ranking
  rankings <- rank_items(defuzz_values)

  # Prepare results
  results <- list(
    fuzzy_data = fuzzy_data,
    fuzzy_scale = round(fuzzy_scale, 2),
    item_d_values = item_d_values,
    consensus_percentage = consensus_pct,
    defuzzification = defuzz_values,
    ranking = rankings,
    overall_d_construct = overall_d_construct,
    overall_consensus = overall_consensus
  )

  class(results) <- "fuzzy_delphi"
  return(results)
}


#' Print Method for Fuzzy Delphi Results
#'
#' @param x A fuzzy_delphi object
#' @param ... Additional arguments (not used)
#' @export
print.fuzzy_delphi <- function(x, ...) {
  cat("Fuzzy Delphi Method Results\n")
  cat("============================\n\n")

  cat("Overall Results:\n")
  cat("  - Overall d-construct value:", x$overall_d_construct, "\n")
  cat("  - Overall consensus percentage:", x$overall_consensus, "%\n\n")

  cat("Item-level Results:\n")
  cat("  - Average d-value per item:\n")
  print(x$item_d_values)
  cat("\n")

  cat("  - Consensus percentage per item:\n")
  print(x$consensus_percentage)
  cat("\n")

  cat("  - Defuzzification values:\n")
  print(x$defuzzification)
  cat("\n")

  cat("  - Item rankings:\n")
  print(x$ranking)
  cat("\n")

  invisible(x)
}


#' Summary Method for Fuzzy Delphi Results
#'
#' @param object A fuzzy_delphi object
#' @param ... Additional arguments (not used)
#' @export
summary.fuzzy_delphi <- function(object, ...) {
  cat("Fuzzy Delphi Method - Summary\n")
  cat("==============================\n\n")

  cat("Number of experts:", nrow(object$fuzzy_scale), "\n")
  cat("Number of items:", ncol(object$fuzzy_scale), "\n\n")

  cat("Overall Construct:\n")
  cat("  - d-construct value:", object$overall_d_construct, "\n")
  cat("  - Consensus percentage:", object$overall_consensus, "%\n\n")

  cat("Item Analysis:\n")
  combined <- data.frame(
    Item = names(object$item_d_values),
    d_value = as.numeric(object$item_d_values),
    Consensus_pct = as.numeric(object$consensus_percentage),
    Defuzzification = as.numeric(object$defuzzification),
    Rank = as.numeric(object$ranking)
  )
  print(combined)

  invisible(object)
}
