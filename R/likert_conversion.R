#' Convert Likert-5 Scale to Fuzzy Triangular Numbers
#'
#' Converts Likert 5-point scale responses (1-5) to fuzzy triangular numbers
#' represented by three membership values (m1, m2, m3).
#'
#' @param data A data frame or matrix containing Likert-5 scale responses (values 1-5).
#' @return A data frame with fuzzy triangular numbers. Each original column generates
#'   three columns with suffixes .m1, .m2, and .m3.
#' @export
#' @examples
#' data <- data.frame(Item1 = c(5, 4, 5, 3), Item2 = c(4, 5, 4, 4))
#' fuzzy_data <- likert5_to_fuzzy(data)
likert5_to_fuzzy <- function(data) {
  # Fuzzy set mapping for Likert-5
  likert5_map <- data.frame(
    r = c(1, 2, 3, 4, 5),
    m1 = c(0, 0, 0.2, 0.4, 0.6),
    m2 = c(0, 0.2, 0.4, 0.6, 0.8),
    m3 = c(0.2, 0.4, 0.6, 0.8, 1)
  )

  # Function to match a single response
  match_response <- function(response) {
    index <- match(response, likert5_map$r)
    if (!is.na(index)) {
      return(likert5_map[index, c("m1", "m2", "m3")])
    } else {
      return(data.frame(m1 = NA, m2 = NA, m3 = NA))
    }
  }

  # Process each column
  result_list <- list()
  col_names <- names(data)

  for (col_name in col_names) {
    matched_values <- lapply(data[[col_name]], match_response)
    matched_df <- do.call(rbind, matched_values)

    # Rename columns with original name prefix
    colnames(matched_df) <- paste(col_name, c("m1", "m2", "m3"), sep = ".")
    result_list[[col_name]] <- matched_df
  }

  # Combine all results
  result_df <- do.call(cbind, result_list)
  return(as.data.frame(result_df))
}


#' Convert Likert-7 Scale to Fuzzy Triangular Numbers
#'
#' Converts Likert 7-point scale responses (1-7) to fuzzy triangular numbers
#' represented by three membership values (m1, m2, m3).
#'
#' @param data A data frame or matrix containing Likert-7 scale responses (values 1-7).
#' @return A data frame with fuzzy triangular numbers. Each original column generates
#'   three columns with suffixes .m1, .m2, and .m3.
#' @export
#' @examples
#' data <- data.frame(Item1 = c(7, 6, 7, 5), Item2 = c(6, 7, 6, 6))
#' fuzzy_data <- likert7_to_fuzzy(data)
likert7_to_fuzzy <- function(data) {
  # Fuzzy set mapping for Likert-7
  likert7_map <- data.frame(
    r = c(1, 2, 3, 4, 5, 6, 7),
    m1 = c(0, 0, 0, 0.2, 0.4, 0.6, 0.8),
    m2 = c(0, 0.2, 0.4, 0.6, 0.8, 1, 1),
    m3 = c(0.2, 0.4, 0.6, 0.8, 1, 1, 1)
  )

  # Function to match a single response
  match_response <- function(response) {
    index <- match(response, likert7_map$r)
    if (!is.na(index)) {
      return(likert7_map[index, c("m1", "m2", "m3")])
    } else {
      return(data.frame(m1 = NA, m2 = NA, m3 = NA))
    }
  }

  # Process each column
  result_list <- list()
  col_names <- names(data)

  for (col_name in col_names) {
    matched_values <- lapply(data[[col_name]], match_response)
    matched_df <- do.call(rbind, matched_values)

    # Rename columns with original name prefix
    colnames(matched_df) <- paste(col_name, c("m1", "m2", "m3"), sep = ".")
    result_list[[col_name]] <- matched_df
  }

  # Combine all results
  result_df <- do.call(cbind, result_list)
  return(as.data.frame(result_df))
}
