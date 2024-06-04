#' count factor levels
#'
#' @description A utils function that counts by the levels of a factor variable
#'
#' @param data A data frame that contains a factor variable
#' @param var The variable name of the factor
#' @param varlabel The variable label of the factor
#'
#' @importFrom magrittr %>%
#' @importFrom rlang enquo !!
#' @importFrom dplyr mutate select count
#' @importFrom scales percent
#'
#' @return A data frame that count differentt levels of a factor with four variables: var_label, var_level, freq, and percent
#' @export
#'
#' @examples
#' df <- data.frame(fctvar = as.factor(rep(c("a", "b", "c"), 10)))
#' countfactor(data = df, var = fctvar, varlabel = 'variable label')
#'
#' @noRd
countfactor <- function(data, var, varlabel){

  # Check if Data is a data.frame
  if (class(data) != 'data.frame') {
    stop("Expecting a data frame")
  }

  var <- rlang::enquo(var)

  result <- data %>%
    dplyr::count(!!(var), name = 'freq', .drop=FALSE) %>% # .drop=FALSE include counts for empty groups
    dplyr::mutate(var_level = !!(var))%>%
    dplyr::mutate(var_label = varlabel)%>%
    dplyr::select(var_label, var_level, freq) %>% ##
    dplyr::mutate(percent = scales::percent(freq/sum(freq)))  # Calculate percentage of counts and format as percentage using the percent() function

  return(result)
}
