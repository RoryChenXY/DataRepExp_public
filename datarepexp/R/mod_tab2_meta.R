#' tab2_meta UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @import dplyr
#' @import DT
#' @import shiny
#' @import shinipsum
#' @importFrom magrittr %>%
mod_tab2_meta_ui <- function(id){
  ns <- NS(id)
  tagList(
    h2("This tab provides a summary of studies currently available in the Data Repository,
        including common metadata and data availability by categories."),
    h2("All tables on this tab have enabled search, sort, filter and reset functions."),
    ## Summary Stats ####################################################
    fluidRow(
      column(5, h2(shiny::htmlOutput(NS(id, "nstudy")))), # total number of studies
      column(5, h2(shiny::htmlOutput(NS(id, "nppt")))) # total number of participants
    ),
    br(),
    ## Common metadata table#############################################
    h3("The table below includes the study metadata."),
    fluidRow(column(1,# CLEAR button to reset
                    offset = 11, align = "right", # on the right side
                    div(
                      style = "margin-bottom: 20px;",
                      actionButton(NS(id, "clearmeta"), "CLEAR")
                    )
    )),
    fluidRow(column(12, DT::DTOutput(NS(id, "metatb")))),
    br(),
    ## Data availability by categories############################################
    h3("The table below provides the data availability by categories."),
    fluidRow(column(1,# CLEAR button to reset
                    offset = 11, align = "right", # on the right side
                    div(
                      style = "margin-bottom: 20px;",
                      actionButton(NS(id, "clearava"), "CLEAR")
                    )
    )),
    fluidRow(column(12, DT::DTOutput(NS(id, "studyava"))))
  )
}

#' tab2_meta Server Functions
#'
#' @noRd
mod_tab2_meta_server <- function(id){
  moduleServer(id, function(input, output, session){
    ns <- session$ns

    ## Summary Stats ####################################################
    output$nstudy <- shiny::renderUI({ # Number of Studies
      HTML(paste("Number of Studies:", "123", sep = " "))
    })
    output$nppt <-  shiny::renderUI({ # Total Participants
      HTML(paste("Total Participants: ", "987654", sep = " "))
    })

    ## Common metadata table#############################################
    output$metatb <- DT::renderDT({ #DT table
      shinipsum::random_DT(10, 10)
    })
    metaproxy <- DT::dataTableProxy("metatb") # Proxy of the DT table
    observeEvent(eventExpr = input$clearmeta, clearSearch(metaproxy)) # if button is clicked --> Reset table

    ## Data availability by categories#############################################
    output$studyava <- DT::renderDT({ #DT table
      shinipsum::random_DT(10, 15)
    })
    avaproxy <- DT::dataTableProxy("studyava") # Proxy of the DT table
    observeEvent(eventExpr = input$clearava, clearSearch(avaproxy)) # if button is clicked --> Reset table

  })
}

## To be copied in the UI
# mod_tab2_meta_ui("tab2_meta_1")

## To be copied in the server
# mod_tab2_meta_server("tab2_meta_1")

mod_tab1_statement_app <- function() {

  ui <- fluidPage(
    mod_tab2_meta_ui("tab2_meta_0")
  )

  server <- function(input, output, session) {
    mod_tab2_meta_server("tab2_meta_0")
  }

  shinyApp(ui, server)
}
