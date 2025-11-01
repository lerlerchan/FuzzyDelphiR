#' Sample Expert Data for Fuzzy Delphi Analysis
#'
#' A sample dataset containing Likert-5 scale responses from 27 experts
#' on 10 items. This dataset can be used to demonstrate the Fuzzy Delphi Method.
#'
#' @format A data frame with 27 rows (experts) and 10 columns (items):
#' \describe{
#'   \item{Item1}{Likert-5 scale response for Item 1}
#'   \item{Item2}{Likert-5 scale response for Item 2}
#'   \item{Item3}{Likert-5 scale response for Item 3}
#'   \item{Item4}{Likert-5 scale response for Item 4}
#'   \item{Item5}{Likert-5 scale response for Item 5}
#'   \item{Item6}{Likert-5 scale response for Item 6}
#'   \item{Item7}{Likert-5 scale response for Item 7}
#'   \item{Item8}{Likert-5 scale response for Item 8}
#'   \item{Item9}{Likert-5 scale response for Item 9}
#'   \item{Item10}{Likert-5 scale response for Item 10}
#' }
#' @source Simulated data for demonstration purposes
#' @examples
#' data(expert_data)
#' head(expert_data)
#' results <- fuzzy_delphi(expert_data, likert_scale = 5)
"expert_data"
