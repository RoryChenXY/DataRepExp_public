#' tab3_filter UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_tab3_filter_ui <- function(id){
  ns <- NS(id)
  tagList(
 
  )
}
    
#' tab3_filter Server Functions
#'
#' @noRd 
mod_tab3_filter_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
 
  })
}
    
## To be copied in the UI
# mod_tab3_filter_ui("tab3_filter_1")
    
## To be copied in the server
# mod_tab3_filter_server("tab3_filter_1")
