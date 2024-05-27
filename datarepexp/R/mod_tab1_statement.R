#' tab1_statement UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_tab1_statement_ui <- function(id){
  ns <- NS(id)
  tagList(
 
  )
}
    
#' tab1_statement Server Functions
#'
#' @noRd 
mod_tab1_statement_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
 
  })
}
    
## To be copied in the UI
# mod_tab1_statement_ui("tab1_statement_1")
    
## To be copied in the server
# mod_tab1_statement_server("tab1_statement_1")
