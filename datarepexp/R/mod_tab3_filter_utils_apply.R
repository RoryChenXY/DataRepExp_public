#' @title Applying filters to factor variable
#'
#' @param df A data frame
#' @param col A column name, of the factor variable
#' @param vals A list of values that were selected
#'
#' @return A filtered data frame
#'
#' @importFrom rlang sym !!
#' @importFrom dplyr filter
#'
#' @examples
#' data <- data.frame(fctvar = as.factor(rep(c("a", "b", "c"), 10)))
#' df_filtered <- apply_factor_filter(data, 'fctvar', c('a', 'b'))
#'
#' @export
apply_factor_filter <- function(df, col, vals) {
  if (!is.null(vals)) {
    dplyr::filter(df, !!sym(col) %in% vals)
  } else {
    df
  }
}


#' @title Applying filters to numeric variable based on the slider inputs
#'
#' @param df A data frame
#' @param col A column name, of the numeric variable
#' @param vals A list of values, min, max, include missing
#'
#' @return A filtered data frame
#'
#' @importFrom rlang sym !!
#' @importFrom dplyr filter
#'
#' @examples
#' data <- data.frame(numvar  = rep(c(1,2,3, NA), 10))
#' df_filtered_a <- apply_slide_filter(data, 'numvar', list(1, 2, 1))
#' df_filtered_b <- apply_slide_filter(data, 'numvar', list(1, 2, 0))
#'
#' @export
apply_slide_filter <- function(df, col, vals) {
  if (!is.null(vals)) {
    values <- unlist(vals)
    if (values[3] == 1) { # include missing values
      dplyr::filter(df, is.na(!!sym(col)) | !!sym(col) >= values[1] & !!sym(col) <= values[2])
    } else {
      dplyr::filter(df, !!sym(col) >= values[1] & !!sym(col) <= values[2])
    }
  } else {
    df
  }
}

