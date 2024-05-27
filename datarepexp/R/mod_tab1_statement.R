#' tab1_statement UI Function
#'
#' @description A shiny Module for the first tab - Overview Statement.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_tab1_statement_ui <- function(id){
  ns <- NS(id)
  tagList(
    h1('Data Visualisation Tool for Data Repositories.'),
    h2('This R-shiny app was developed to improve the findability, accessibility, interoperability and reusability (FAIR) of research data.
      Data custodians can display the availability of data categories across multiple research studies.
      The app enables researchers to explore and visualise data from participants that
      match certain criteria or interests,
      which are applied using filters at study and participant levels.
      Simulated data are used for demonstration purposes.
      The development of this app is described in Chen et al. [citation].
      The scripts are open source, but we ask that you kindly acknowledge our work.')
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

# Module App
mod_tab1_statement_app <- function() {

  ui <- fluidPage(
    mod_tab1_statement_ui("tab1_statement_0")
  )

  server <- function(input, output, session) {
    mod_tab1_statement_server("tab1_statement_0")
  }

  shinyApp(ui, server)
}

