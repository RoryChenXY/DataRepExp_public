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
#' dfsample <- data.frame(fctvar = as.factor(sample(letters[1:3], 10, replace = TRUE)))
#' df_filtered <- apply_factor_filter(dfsample, 'fctvar', c('a', 'b'))
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
#' dfsample <- data.frame(numvar = sample(1:10, 100, replace = TRUE))
#' df_filtered <- apply_slide_filter(dfsample, 'numvar', list(3, 8, TRUE))
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

