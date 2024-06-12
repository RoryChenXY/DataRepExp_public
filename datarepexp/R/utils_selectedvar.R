#' @title selectedvar
#'
#' @description Return variable name based on the variable label
#'
#' @param var_label variable label
#'
#' @importFrom magrittr %>%
#' @importFrom dplyr filter
#'
#' @return variable name as a string
#'
#' @export
#'
#' @examples
#' vlabel <- "Year of Death"
#' vname <- selectedvar(vlabel)
selectedvar <- function(var_label){
  temp <- VAR_info %>% dplyr::filter(LABELS == var_label)
  var_name <- temp$VARNAME
  return(var_name)
}
