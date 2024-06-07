#' tab5_pac UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @import shiny
#' @importFrom shinyWidgets pickerInput
#' @importFrom magrittr %>%
#' @importFrom dplyr count mutate
#' @importFrom tidyr drop_na pivot_wider
#' @importFrom RColorBrewer brewer.pal
#' @importFrom plotly plotlyOutput renderPlotly ggplotly plot_ly layout

mod_tab5_pac_ui <- function(id){
  ns <- NS(id)
  quanchoice <- list(
    "Age at Assessment",
    "Year of Death",
    "BMI",
    "Scale 1",
    "Scale 2",
    "Scale 3",
    "Scale 4"
  )

  catevchoice <- list(
    "Demographics"               = list("Ethnic Background", "Sex", "High School Educated", "Married/De-facto", "Deceased"),
    "Lifestyle"                  = list("Smoking Status", "Alcohol Use Status"),
    "Disease Diagnoses"          = list("Disease Diagnosis 1", "Disease Diagnosis 2", "Disease Diagnosis 3", "Disease Diagnosis 4"),
    "Service Utilization"        = list("Hospital Outpatient", "Hospital Inpatient", "GP"),
    "Family History of Diseases" = list("Family History of Diagnosis 1", "Family History of Diagnosis 2", "Family History of Diagnosis 3"),
    "Imaging Data"               = list("MRI Collected", "Imaging 1 Collected", "Imaging 2 Collected"),
    "Genomic Data"               = list("Geno type 1", "Geno type 2")
  )
  tagList(
    h2("The Preliminary Analysis Tab generates results based on the filters you have applied."),
    h2("Please allow up to a minute for the results to load."),
    fluidPage(
      fluidRow(
        column(3, shinyWidgets::pickerInput(
          inputId = NS(id, "ycate"),
          label = "Categorical Y",
          choices = catevchoice,
          selected = "Disease Diagnosis 1",
          multiple = FALSE
        )),
        column(3, selectInput(
          inputId = NS(id, "cx1q"),
          label = "Quantitative X1",
          choices = quanchoice,
          selected = "Scale 2",
          multiple = FALSE
        )),
        column(3, shinyWidgets::pickerInput(
          inputId = NS(id, "cx2c"),
          label = "Categorical X2",
          choices = catevchoice,
          selected = "Alcohol Use Status",
          multiple = FALSE
        ))
      ),
      uiOutput(NS(id, "pac_valid")),
      tabsetPanel(
        id = NS(id, "pactabs"),
        type = "tabs",
        tabPanel("Univariate", uiOutput(NS(id, "pacuni"))),
        tabPanel("Y~X1", uiOutput(NS(id, "pacx1"))),
        tabPanel("Y~X2", uiOutput(NS(id, "pacx2")))
      )
    )
  )
}

#' tab5_pac Server Functions
#'
#' @noRd
mod_tab5_pac_server <- function(id, react_df){
  moduleServer(id, function(input, output, session){
    ns <- session$ns

    # Check the filtered results and selected variables
    output$pac_valid <- renderUI({
      if (nrow(react_df()) == 0) {
        h2("Base on the filters you applied,
            no participants were identified, please update your selection.")
      } else {
        if (input$ycate == input$cx2c) {
          h2("Please choose a different Categorical X2") # Variable selection validation
        } else {
          h3(paste0(
            "Base on the filters you applied, you have found ",
            nrow(react_df()), " participants from ",
            length(unique(react_df()$STUDY)), " study/studies."
          ))
        }
      }
    })

    ## Tab 5-2-1 Categorical Outcome Univariate Analysis ######################
    ### Tab 5-2-1 Layout ######################
    output$pacuni <- renderUI({
      fluidPage(
        fluidRow(h3(textOutput(NS(id, "cunitext")))), # statement text
        br(),
        fluidRow(
          column(4, tableOutput(NS(id, "ycstats"))), # summary statistics
          column(5, plotly::plotlyOutput(NS(id, "unibar"))) # bar plot
        )
      )
    })
    ### Tab 5-2-1 Contents ######################
    # statement text
    output$cunitext <- renderText({
      paste("Univariate Analysis of: ", input$ycate)
    })

    # summary statistics
    output$ycstats <- renderTable({
      yclabel <- input$ycate
      ycvar <- selectedvar(yclabel)

      df <- react_df()

      a <- df %>%
        dplyr::count(get(ycvar), name = 'Counts', .drop=FALSE) %>% # .drop=FALSE include counts for empty groups
        dplyr::mutate(Percent = scales::percent(Counts/sum(Counts)))  # Calculate percentage of counts and format as percentage using the percent() function

      names(a)[1] <- yclabel

      a
    })

    # univariate bar plot
    output$unibar <- plotly::renderPlotly({
      yclabel <- input$ycate
      ycvar <- selectedvar(yclabel)

      data <- react_df() %>%
        dplyr::count(get(ycvar), name = 'Counts', .drop=FALSE)
      names(data)[1] <- 'Level'

      p <- plotly::plot_ly(data = data,
                           x = ~Level,
                           y = ~Counts,
                           color = ~Level,
                           colors = "Pastel1",
                           type = 'bar',
                           hovertemplate = paste(yclabel, ': %{x}',
                                                 '<br>Counts: %{y:.d}<br>')) %>%
        plotly::layout(xaxis  = list(title = yclabel),
                       yaxis  = list(title = "Counts"),
                       legend = list(title = list(text = yclabel), orientation = "v"))

      return(p)
    })

    ## Tab 5-2-2 Categorical Outcome Y ~ Quantitative X1 Analysis ######################

    ### Tab 5-2-2 Layout ######################
    output$pacx1 <- renderUI({
      fluidPage(
        br(),
        fluidRow(h3(textOutput(NS(id, "cyx1text")))), # statement text
        fluidRow(
          column(6, plotly::plotlyOutput(NS(id, "cyx1hist")))
        )
      )
    })
    ### Tab 5-2-2 Contents ######################
    # statement text
    output$cyx1text <- renderText({
      paste("Analysis of: ", input$ycate, "(Y) and", input$cx1q, "(X1)")
    })

    # histogram
    output$cyx1hist <- plotly::renderPlotly({
      yclabel <- input$ycate
      ycvar <- selectedvar(yclabel)

      x1qlabel <- input$cx1q
      x1qvar <- selectedvar(x1qlabel)

      a <- react_df()

      plotly_histogram_grouped(a, var = x1qvar, groupvar = ycvar, varlabel = x1qlabel, grouplabel = yclabel)
    })


    ## Tab 5-2-3 Categorical Outcome Y~X2 Analysis ######################
    ### Tab 5-2-3 Layout ######################
    output$pacx2 <- renderUI({
      fluidPage(
        br(),
        fluidRow(h3(textOutput(NS(id, "cyx2text")))), # statement text
        br(),
        fluidRow(
          column(5, tableOutput(NS(id, "cyx2stats"))), # # summary statistics
          column(7, plotly::plotlyOutput(NS(id, "cyx2bar1")))
        )
      )
    })

    ### Tab 5-2-3 Contents ######################

    # statement text
    output$cyx2text <- renderText({
      paste(" Analysis of: ", input$ycate, "(Y) and", input$cx2c, "(X2)")
    })

    # summary statistics
    output$cyx2stats <- renderTable({
      yclabel <- input$ycate
      ycvar <- selectedvar(yclabel)

      x2clabel <- input$cx2c
      x2cvar <- selectedvar(x2clabel)

      a <- react_df() %>%
        count(get(ycvar), get(x2cvar)) %>%
        tidyr::pivot_wider(
          names_from = "get(x2cvar)", values_from = n
        )

      names(a)[1] <- yclabel

      a
    })

    # Barplot with two categorical variables
    output$cyx2bar1 <- plotly::renderPlotly({
      yclabel <- input$ycate
      ycvar <- selectedvar(yclabel)

      x2clabel <- input$cx2c
      x2cvar <- selectedvar(x2clabel)

      data <- react_df() %>% count(get(ycvar), get(x2cvar))
      names(data) <- c(ycvar, x2cvar, 'n')

      p <- plotly::plot_ly(
        data = data,
        x = ~.data[[ycvar]],
        y = ~.data[['n']],
        color = ~.data[[x2cvar]],
        colors = "Pastel1",
        type = 'bar',
        hovertemplate = paste(yclabel,': %{x}',
                              '<br>Counts: %{y:.d}<br>')) %>%
        plotly::layout(xaxis  = list(title = yclabel),
                       yaxis  = list(title = "Counts"),
                       legend = list(title = list(text = x2clabel), orientation = "v"),
                       updatemenus = list(
                         list(
                           x = 1.2,
                           y = 0.2,
                           type = "buttons",
                           buttons = list(
                             list(method = "relayout",
                                  args = list("barmode", "group"),
                                  label = "Group"),
                             list(method = "relayout",
                                  args = list("barmode", "stack"),
                                  label = "Stack")))))

      return(p)
    })


  })
}

## To be copied in the UI
# mod_tab5_pac_ui("tab5_pac_1")

## To be copied in the server
# mod_tab5_pac_server("tab5_pac_1",  react_df = filteredppt)


mod_tab5_pac_app <- function() {

  ui <- fluidPage(
    mod_tab5_pac_ui("tab5_pac_0")
  )

  server <- function(input, output, session) {
    mod_tab5_pac_server("tab5_pac_0", react_df = filteredppt)
  }

  shinyApp(ui, server)
}
