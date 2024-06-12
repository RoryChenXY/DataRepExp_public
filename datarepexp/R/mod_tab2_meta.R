#' tab2_meta UI Function
#'
#' @description A shiny Module for the second tab - Metadata.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @rawNamespace import(shiny, except=c(dataTableOutput, renderDataTable))
#' @importFrom dplyr select filter arrange
#' @importFrom magrittr %>%
#' @importFrom DT renderDT DTOutput datatable dataTableProxy clearSearch
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
                      shiny::actionButton(NS(id, "clearmeta"), "CLEAR")
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
                      shiny::actionButton(NS(id, "clearava"), "CLEAR")
                    )
    )),
    fluidRow(column(12, DT::DTOutput(NS(id, "studyava"))))
  )
}

#' tab2_meta Server Functions
#'
#' @noRd
mod_tab2_meta_server <- function(id, metadf, infodf){
  moduleServer(id, function(input, output, session){
    ns <- session$ns

    # DT table option
    dtoptions1 <- list(
      searching = TRUE,
      scrollX = TRUE,
      dom = 'Bfrtip',
      buttons = list('pageLength',
                     list(
                       extend = 'colvis',
                       columns = ":gt(0)"),
                     'colvisRestore',
                     'csv',
                     'print')
    )

    ## Summary Stats ####################################################
    output$nstudy <- shiny::renderUI({ # Number of Studies
      HTML(paste("Number of Studies:", nrow(metadf), sep = " "))
    })
    output$nppt <-  shiny::renderUI({ # Total Participants
      HTML(paste("Total Participants: ", sum(metadf$STUDYSIZE), sep = " "))
    })

    ## Common metadata table#############################################
    output$metatb <- DT::renderDT({ #DT table
      temp1 <- metadf[, 1:9]
      var_label <- infodf %>%
        dplyr::filter(VARNAME %in% colnames(temp1)) %>%
        dplyr::arrange(match(VARNAME, colnames(temp1)))

      DT::datatable(temp1,
                    filter = "top",
                    colnames = var_label$LABELS,
                    rownames = FALSE,
                    extensions = 'Buttons',
                    options = dtoptions1
      )
    })
    metaproxy <- DT::dataTableProxy("metatb") # Proxy of the DT table
    shiny::observeEvent(eventExpr = input$clearmeta, DT::clearSearch(metaproxy)) # if button is clicked --> Reset table

    ## Data availability by categories#############################################
    output$studyava <- DT::renderDT({ #DT table
      temp2 <- metadf %>% dplyr::select(c(STUDY, cat01:cat15))
      var_label <- infodf %>%
        dplyr::filter(VARNAME %in% colnames(temp2)) %>%
        dplyr::arrange(match(VARNAME, colnames(temp2)))
      DT::datatable(temp2,
                    filter = "top",
                    colnames = var_label$LABELS,
                    rownames = FALSE,
                    extensions = 'Buttons',
                    options = dtoptions1
      )
    })
    avaproxy <- DT::dataTableProxy("studyava") # Proxy of the DT table
    shiny::observeEvent(eventExpr = input$clearava, DT::clearSearch(avaproxy)) # if button is clicked --> Reset table

  })
}

## To be copied in the UI
# mod_tab2_meta_ui("tab2_meta_1")

## To be copied in the server
# mod_tab2_meta_server("tab2_meta_1", metadf = studymeta, infodf = VAR_info)

#' tab2_meta module app
#'
#' @export
#'
#' @noRd
mod_tab2_meta_app <- function() {

  ui <- fluidPage(
    mod_tab2_meta_ui("tab2_meta_0")
  )

  server <- function(input, output, session) {
    mod_tab2_meta_server("tab2_meta_0", metadf = studymeta, infodf = VAR_info)
  }

  shinyApp(ui, server)
}
