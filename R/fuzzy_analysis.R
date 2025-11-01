#' Calculate Fuzzy Scale (d-value)
#'
#' Calculates the fuzzy distance (d-value) between each expert's response and
#' the average fuzzy response for each item. Lower values indicate higher agreement.
#'
#' @param fuzzy_data A data frame with fuzzy triangular numbers (output from
#'   likert5_to_fuzzy or likert7_to_fuzzy).
#' @return A data frame with fuzzy scale values for each expert (rows) and item (columns).
#' @export
#' @examples
#' data <- data.frame(Item1 = c(5, 4, 5, 3), Item2 = c(4, 5, 4, 4))
#' fuzzy_data <- likert5_to_fuzzy(data)
#' fuzzy_scale <- calculate_fuzzy_scale(fuzzy_data)
calculate_fuzzy_scale <- function(fuzzy_data) {
  # Internal function to calculate fuzzy distance
  fuzzy_distance <- function(m1, m2, m3, mean_m1, mean_m2, mean_m3) {
    d <- (((mean_m1 - m1)^2) + ((mean_m2 - m2)^2) + ((mean_m3 - m3)^2))
    d <- (1/3) * d
    d <- sqrt(d)
    return(d)
  }

  # Get column names and identify unique items
  col_names <- names(fuzzy_data)
  item_names <- unique(gsub("\\.(m1|m2|m3)$", "", col_names))

  result_list <- list()

  # Process each item
  for (item_name in item_names) {
    # Get columns for this item
    item_cols <- grep(paste0("^", item_name, "\\."), col_names, value = TRUE)
    subset_df <- fuzzy_data[, item_cols, drop = FALSE]

    # Calculate means for m1, m2, m3
    col_means <- colMeans(subset_df, na.rm = TRUE)

    # Calculate fuzzy distance for each expert
    result <- apply(subset_df, 1, function(row) {
      fuzzy_distance(
        row[paste(item_name, "m1", sep = ".")],
        row[paste(item_name, "m2", sep = ".")],
        row[paste(item_name, "m3", sep = ".")],
        col_means[1], col_means[2], col_means[3]
      )
    })

    # Store result
    result_df_item <- data.frame(result)
    names(result_df_item)[1] <- item_name
    result_list[[item_name]] <- result_df_item
  }

  # Combine results
  final_result_df <- do.call(cbind, result_list)
  return(final_result_df)
}


#' Calculate Expert Consensus Percentage
#'
#' Calculates the percentage of experts who reached consensus for each item.
#' Consensus is defined as fuzzy distance (d-value) <= 0.2.
#'
#' @param fuzzy_scale_data A data frame with fuzzy scale values (output from
#'   calculate_fuzzy_scale).
#' @param threshold Consensus threshold value (default = 0.2).
#' @return A data frame with consensus percentage for each item.
#' @export
#' @examples
#' data <- data.frame(Item1 = c(5, 4, 5, 3), Item2 = c(4, 5, 4, 4))
#' fuzzy_data <- likert5_to_fuzzy(data)
#' fuzzy_scale <- calculate_fuzzy_scale(fuzzy_data)
#' consensus <- calculate_consensus(fuzzy_scale)
calculate_consensus <- function(fuzzy_scale_data, threshold = 0.2) {
  num_rows <- nrow(fuzzy_scale_data)
  result_list <- list()

  # Calculate consensus for each column (item)
  for (col_num in 1:ncol(fuzzy_scale_data)) {
    below_threshold <- sum(fuzzy_scale_data[, col_num] <= threshold, na.rm = TRUE)
    percentage_consensus <- (below_threshold / num_rows) * 100

    result_df_item <- data.frame(percentage = percentage_consensus)
    names(result_df_item)[1] <- names(fuzzy_scale_data)[col_num]
    result_list[[col_num]] <- result_df_item
  }

  # Combine results
  final_df <- do.call(cbind, result_list)
  return(final_df)
}


#' Defuzzification of Fuzzy Triangular Numbers
#'
#' Converts fuzzy triangular numbers back to crisp values using the centroid method.
#'
#' @param fuzzy_data A data frame with fuzzy triangular numbers (output from
#'   likert5_to_fuzzy or likert7_to_fuzzy).
#' @return A data frame with defuzzified values for each item.
#' @export
#' @examples
#' data <- data.frame(Item1 = c(5, 4, 5, 3), Item2 = c(4, 5, 4, 4))
#' fuzzy_data <- likert5_to_fuzzy(data)
#' defuzz_values <- defuzzify(fuzzy_data)
defuzzify <- function(fuzzy_data) {
  # Internal defuzzification function
  defuzz_cell <- function(m1, m2, m3) {
    sum_m <- m1 + m2 + m3
    if (is.finite(sum_m)) {
      a_max <- (1/3) * sum_m
      return(a_max)
    } else {
      return(NA)
    }
  }

  # Calculate column means
  avg_m <- colMeans(fuzzy_data, na.rm = TRUE)
  avg_m_df <- data.frame(t(avg_m))
  colnames(avg_m_df) <- colnames(fuzzy_data)

  result_deflist <- list()

  # Process every three columns (m1, m2, m3)
  for (start_col in seq(1, ncol(avg_m_df), by = 3)) {
    end_col <- min(start_col + 2, ncol(avg_m_df))
    current_columns <- avg_m_df[, start_col:end_col, drop = FALSE]

    # Apply defuzzification
    result_d <- apply(current_columns, 1, function(row) {
      defuzz_cell(row[1], row[2], row[3])
    })

    if (!is.null(result_d)) {
      result_deflist[[length(result_deflist) + 1]] <- result_d
    }
  }

  # Create result data frame
  result_def <- data.frame(result_deflist)

  # Extract item names (remove .m1, .m2, .m3 suffixes)
  col_names <- names(fuzzy_data)
  item_names <- unique(gsub("\\.(m1|m2|m3)$", "", col_names))
  colnames(result_def) <- item_names

  return(result_def)
}


#' Rank Items Based on Defuzzification Values
#'
#' Ranks items in descending order based on their defuzzified values.
#' Higher defuzzified values receive better (lower) ranks.
#'
#' @param defuzz_data A data frame with defuzzified values (output from defuzzify).
#' @return A data frame with rankings for each item.
#' @export
#' @examples
#' data <- data.frame(Item1 = c(5, 4, 5, 3), Item2 = c(4, 5, 4, 4))
#' fuzzy_data <- likert5_to_fuzzy(data)
#' defuzz_values <- defuzzify(fuzzy_data)
#' rankings <- rank_items(defuzz_values)
rank_items <- function(defuzz_data) {
  # Extract numeric values
  numeric_values <- as.numeric(unlist(defuzz_data))

  # Remove NA values if any
  numeric_values <- numeric_values[!is.na(numeric_values)]

  # Rank in descending order (higher values get better ranks)
  ranked_values <- rank(-numeric_values, na.last = "keep")

  # Create result data frame
  result_df <- data.frame(t(ranked_values))
  colnames(result_df) <- names(defuzz_data)
  rownames(result_df) <- NULL

  return(result_df)
}
