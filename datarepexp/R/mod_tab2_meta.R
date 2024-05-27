#' tab2_meta UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_tab2_meta_ui <- function(id){
  ns <- NS(id)
  tagList(
 
  )
}
    
#' tab2_meta Server Functions
#'
#' @noRd 
mod_tab2_meta_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
 
  })
}
    
## To be copied in the UI
# mod_tab2_meta_ui("tab2_meta_1")
    
## To be copied in the server
# mod_tab2_meta_server("tab2_meta_1")
