#' tab5_paq UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @import shiny
#' @import ggplot2
#' @importFrom shinyWidgets pickerInput
#' @importFrom magrittr %>%
#' @importFrom dplyr count mutate group_by summarise
#' @importFrom stats IQR lm quantile sd
#' @importFrom collapse fmin fmax
#' @importFrom tidyr drop_na pivot_wider
#' @importFrom RColorBrewer brewer.pal
#' @importFrom plotly plotlyOutput renderPlotly ggplotly plot_ly layout add_boxplot
mod_tab5_paq_ui <- function(id){
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
        column(3, selectInput(
          inputId = NS(id, "yquan"),
          label = "Quantitative Y",
          choices = quanchoice,
          selected = "Scale 4",
          multiple = FALSE
        )),
        column(3, selectInput(
          inputId = NS(id, "qx1q"),
          label = "Quantitative X1",
          choices = quanchoice,
          selected = "Age at Assessment",
          multiple = FALSE
        )),
        column(3, shinyWidgets::pickerInput(
          inputId = NS(id, "qx2c"),
          label = "Categorical X2",
          choices = catevchoice,
          selected = "Alcohol Use Status",
          multiple = FALSE
        )),
        column(3, shinyWidgets::pickerInput(
          inputId = NS(id, "qx3c"),
          label = "Categorical X3",
          choices = catevchoice,
          selected = "Deceased",
          multiple = FALSE
        ))
      ),
      uiOutput(NS(id, "paq_valid")),
      tabsetPanel(
        id = NS(id, "paqtabs"),
        type = "tabs",
        tabPanel("Univariate", uiOutput(NS(id, "paquni"))),
        tabPanel("Y~X1+X2", uiOutput(NS(id, "paqx1x2"))),
        tabPanel("Y~X2", uiOutput(NS(id, "paqx2"))),
        tabPanel("Y~X2+X3", uiOutput(NS(id, "paqx2x3")))
      )
    )

  )
}

#' tab5_paq Server Functions
#'
#' @noRd
mod_tab5_paq_server <- function(id, react_df){
  moduleServer(id, function(input, output, session){
    ns <- session$ns
    Pastel1Colors <- RColorBrewer::brewer.pal(name = "Pastel1", n = 9)

    # Check the filtered results and selected variables
    output$paq_valid <- renderUI({
      if (nrow(react_df()) == 0) {
        h2("Based on the filters you applied,
            no participants were identified, please update your selection.")
      } else {
        if (input$yquan == input$qx1q) {
          h2("Please choose a different Quantitative X1") # Variable selection validation
        } else if (input$qx2c == input$qx3c) {
          h2("Please choose a different Categorical X3") # Variable selection validation
        } else {
          h3(paste0(
            "Based on the filters you applied, you have found ",
            nrow(react_df()), " participants from ",
            length(unique(react_df()$STUDY)), " study/studies."
          ))
        }
      }
    })

    ## Tab 5-1-1 Quantitative Outcome Univariate Analysis ######################
    ### Tab 5-1-1 Layout
    output$paquni <- renderUI({
      fluidPage(
        fluidRow(h3(textOutput(NS(id, "qunitext")))), # statement text
        fluidRow(tableOutput(NS(id, "yqstats"))), # summary statistics
        fluidRow(
          column(5, plotly::plotlyOutput(NS(id, "univio"))), # box plot
          column(5, plotly::plotlyOutput(NS(id, "unihis"))) # histogram
        ),
        br(),
        fluidRow(
          column(5, plotly::plotlyOutput(NS(id, "uniden"))), # density
          column(5, plotly::plotlyOutput(NS(id, "uniqq"))) # QQ plot
        )
      )
    })
    ### Tab 5-1-1 Contents
    # statement text
    output$qunitext <- renderText({
      paste("Univariate Analysis of: ", input$yquan)
    })

    # summary statistics
    output$yqstats <- renderTable({

      df <- react_df()

      yqlabel <- input$yquan
      yqvar <- selectedvar(yqlabel)

      a <- df %>%
        dplyr::summarise(
          SampleSize = n(),
          NACount = sum(is.na(get(yqvar))),
          Mean = mean(get(yqvar), na.rm = TRUE),
          SD = stats::sd(get(yqvar), na.rm = TRUE),
          Medium = stats::quantile(get(yqvar), 0.5, na.rm = TRUE),
          IQR = stats::IQR(get(yqvar), na.rm = TRUE),
          Min = min(get(yqvar), na.rm = TRUE),
          Max = max(get(yqvar), na.rm = TRUE)
        )

      a
    })

    # violin plot - univariate
    output$univio <- plotly::renderPlotly({

      yqlabel <- input$yquan
      yqvar <- selectedvar(yqlabel)

      data <- react_df() %>% tidyr::drop_na(all_of(yqvar))

      p <- plotly::plot_ly(data = data,
                           y=~.data[[yqvar]],
                           type = "violin",
                           box = list(visible = T),
                           meanline = list(visible = T),
                           x0 = yqlabel,
                           color = I(Pastel1Colors[1])) %>%
        plotly::layout(title = paste0("<br>Violin plot of ", yqlabel),
                       yaxis  = list(title = "", zeroline = F))
      p
    })

    # histogram - univariate
    output$unihis <- plotly::renderPlotly({
      yqlabel <- input$yquan
      yqvar <- selectedvar(yqlabel)

      data <- react_df() %>% tidyr::drop_na(all_of(yqvar))

      p <- plotly::plot_ly(data = data,
                           x = ~.data[[yqvar]],
                           name = yqlabel,
                           hovertemplate = paste(yqlabel,': %{x}',
                                                 '<br>Counts: %{y}<br>')) %>%
        plotly::add_histogram(
          marker = list(color = Pastel1Colors[4],
                        line = list(color = "#FFFFFF", width = 1))) %>%
        plotly::layout(title = paste0("<br>Histogram of ", yqlabel),
                       xaxis  = list(title = yqlabel),
                       yaxis = list(title = "Counts"),
                       showlegend = FALSE)

      return(p)
    })

    # density - univariate
    output$uniden <- plotly::renderPlotly({
      yqlabel <- input$yquan
      yqvar <- selectedvar(yqlabel)


      df <- react_df() %>% tidyr::drop_na(all_of(yqvar))

      density <- stats::density(df[[yqvar]])

      fig <- plotly::plot_ly(x = ~density$x,
                             y = ~density$y,
                             type = 'scatter',
                             mode = 'lines',
                             fill = 'tozeroy',
                             fillcolor = Pastel1Colors[3],
                             line = list(color = "#FFFFFF", width = 1),
                             hovertemplate = paste(yqlabel,': %{x}',
                                                   '<br>Density: %{y:.2f}<br>')) %>%
        plotly::layout(title = paste("Density of", yqlabel),
                       xaxis  = list(title = yqlabel),
                       yaxis = list(title = 'Density'))


      return(fig)
    })

    # Q-Q plot- univariate
    output$uniqq <- plotly::renderPlotly({ # !!Update tooltip

      yqlabel <- input$yquan
      yqvar <- selectedvar(yqlabel)

      df <- react_df() %>% tidyr::drop_na(all_of(yqvar))

      p <- ggplot2::ggplot(df, aes(
        sample = get(yqvar),
        text = paste0(
          "Sample Quatiles", ": ", after_stat(sample),
          "<br>Theoretical Quantiles: ", round(after_stat(theoretical),2)
        )
      )) +
        ggplot2::stat_qq(color = Pastel1Colors[2]) +
        ggplot2::labs(
          title = paste("Q-Q Plot of", yqlabel),
          x = "Theoretical Quantiles",
          y = "Sample Quantiles"
        )

      # Update the tooltip text
      plotly::ggplotly(p, tooltip = c("text"))
    })

    ## Tab 5-1-2 Quantitative Outcome Y~X1+X2 ######################
    ### Tab 5-1-2 Layout
    output$paqx1x2 <- renderUI({
      fluidPage(
        fluidRow(h3(textOutput(NS(id, "qyx12text")))), # statement text
        br(),
        fluidRow(
          column(6, plotly::plotlyOutput(NS(id, "qyx1point"))), # Scatter Plot Y~X1
          column(6, plotly::plotlyOutput(NS(id, "qyx12point"))) # Scatter Plot Y~X1 coloured by X2
        ),
        br(),
        fluidRow(
          column(12, plotly::plotlyOutput(NS(id, "qyx12facet"))) # Scatter Plot Y~X1 panel by X2
        )
      )
    })

    ### Tab 5-1-2 Y~X1+X2 Contents
    # statement text
    output$qyx12text <- renderText({
      paste(
        "Analysis of: ", input$yquan, "(Y),",
        input$qx1q, "(X1) and", input$qx2c, "(X2)"
      )
    })

    # Scatter Plot Y~X1
    output$qyx1point <- plotly::renderPlotly({
      yqlabel <- input$yquan
      yqvar <- selectedvar(yqlabel)

      x1qlabel <- input$qx1q
      x1qvar <- selectedvar(x1qlabel)

      data <- react_df() %>%
        tidyr::drop_na(all_of(yqvar)) %>%
        tidyr::drop_na(all_of(x1qvar))

      fig <- plotly::plot_ly(data = data,
                             x = ~.data[[x1qvar]],
                             y = ~.data[[yqvar]],
                             type = "scatter",
                             mode = "markers",
                             marker = list(color = Pastel1Colors[5])) %>%
        plotly::layout(title = paste(yqlabel, "by", x1qlabel, "- Scatter Plot"),
                       yaxis = list(title = yqlabel),
                       xaxis = list(title = x1qlabel))

      return(fig)
    })

    # Scatter Plot Y~X1 coloured by X2
    output$qyx12point <- plotly::renderPlotly({
      yqlabel <- input$yquan
      yqvar <- selectedvar(yqlabel)

      x1qlabel <- input$qx1q
      x1qvar <- selectedvar(x1qlabel)

      x2clabel <- input$qx2c
      x2cvar <- selectedvar(x2clabel)

      data <- react_df() %>%
        tidyr::drop_na(all_of(yqvar)) %>%
        tidyr::drop_na(all_of(x1qvar))

      fig <- plotly::plot_ly(data = data,
                             x = ~.data[[x1qvar]],
                             y = ~.data[[yqvar]],
                             color = ~.data[[x2cvar]],
                             colors = "Pastel1",
                             type = "scatter",
                             mode = "markers") %>%
        plotly::layout(title = paste(yqlabel, "by", x1qlabel, "colored by", x2clabel, "<br>- Scatter Plot"),
                       yaxis = list(title = yqlabel),
                       xaxis = list(title = x1qlabel),
                       legend = list(title = list(text = x2clabel)))

      return(fig)
    })

    # Scatter Plot between two quantitative variables - Facet
    output$qyx12facet <- plotly::renderPlotly({
      yqlabel <- input$yquan
      yqvar <- selectedvar(yqlabel)

      x1qlabel <- input$qx1q
      x1qvar <- selectedvar(x1qlabel)

      x2clabel <- input$qx2c
      x2cvar <- selectedvar(x2clabel)

      df <- react_df() %>%
        tidyr::drop_na(all_of(yqvar)) %>%
        tidyr::drop_na(all_of(x1qvar))

      p <- ggplot2::ggplot(df, aes(x = get(x1qvar),
                                   y = get(yqvar),
                                   colour = get(x2cvar),
                                   text = paste0(
                                     x1qlabel, ": ", round(after_stat(x), 2),
                                     "<br>", yqlabel, ": ", round(after_stat(y), 2),
                                     "<br>", x2clabel, ": ", after_stat(color)
                                   ))) +
        ggplot2::geom_point(alpha = 0.9) +
        ggplot2::geom_smooth(formula = "y ~ x", method = lm, se = TRUE) +
        ggplot2::facet_wrap(~ get(x2cvar), ncol = 4) +
        ggplot2::scale_color_brewer(palette = "Pastel1", name = x2clabel) +
        ggplot2::labs(
          title = paste(yqlabel, "by", x1qlabel, "colored by", x2clabel, "- Scatter Plot"),
          x = x1qlabel,
          y = yqlabel,
          colour = x2clabel
        )

      plotly::ggplotly(p, tooltip = "text")
    })

    ## Tab 5-1-3 Quantitative Outcome Y~X2 ######################
    ### Tab 5-1-3 Layout
    output$paqx2 <- renderUI({
      fluidPage(
        fluidRow(h3(textOutput(NS(id, "qyx2text")))), # statement text
        fluidRow(
          column(6, tableOutput(NS(id, "qyx2stats"))), # summary statistics
          column(6, plotly::plotlyOutput(NS(id, "bihis"))) # histogram - Y~X2
        ),
        br(),
        fluidRow(
          column(6, plotly::plotlyOutput(NS(id, "bivio"))), # box plot Y~X2
          column(6, plotly::plotlyOutput(NS(id, "biden"))) # density Y~X2
        ),
        br(),
        fluidRow(
          column(12, plotly::plotlyOutput(NS(id, "biqq"))) # QQ plot Y~X2
        )
      )
    })
    ### Tab 5-1-3 Contents
    # statement text
    output$qyx2text <- renderText({
      paste(" Analysis of: ", input$yquan, "(Y) and", input$qx2c, "(X2)")
    })

    # summary statistics
    output$qyx2stats <- renderTable({
      df <- react_df()

      yqlabel <- input$yquan
      yqvar <- selectedvar(yqlabel)

      x2clabel <- input$qx2c
      x2cvar <- selectedvar(x2clabel)

      a <- df %>%
        dplyr::group_by(get(x2cvar)) %>%
        dplyr::summarise(
          SampleSize = n(),
          NACount = sum(is.na(get(yqvar))),
          Mean = mean(get(yqvar), na.rm = TRUE),
          SD = stats::sd(get(yqvar), na.rm = TRUE),
          Medium = stats::quantile(get(yqvar), 0.5, na.rm = TRUE),
          IQR = stats::IQR(get(yqvar), na.rm = TRUE),
          Min = collapse::fmin(get(yqvar)),
          Max = collapse::fmax(get(yqvar))
        )

      colnames(a)[1] <- x2clabel
      a
    })

    # histogram - plotly - bivariate
    output$bihis <- plotly::renderPlotly({
      yqlabel <- input$yquan
      yqvar <- selectedvar(yqlabel)

      x2clabel <- input$qx2c
      x2cvar <- selectedvar(x2clabel)

      df <- react_df()

      p <- plotly_histogram_grouped(df = df,
                                    var = yqvar,
                                    groupvar = x2cvar,
                                    varlabel = yqlabel,
                                    grouplabel = x2clabel)

      return(p)
    })

    # Violin - bivariate
    output$bivio <- plotly::renderPlotly({
      yqlabel <- input$yquan
      yqvar <- selectedvar(yqlabel)

      x2clabel <- input$qx2c
      x2cvar <- selectedvar(x2clabel)

      data <- react_df() %>% tidyr::drop_na(all_of(yqvar))

      fig <- plotly::plot_ly(data = data,
                             x = ~.data[[x2cvar]],
                             y = ~.data[[yqvar]],
                             split = ~.data[[x2cvar]],
                             type = "violin",
                             box = list(visible = T),
                             meanline = list(visible = T),
                             colors = "Pastel1") %>%
        plotly::layout(title = paste0("<br>Violin plot of ", yqlabel, " by ", x2clabel),
                       xaxis = list(title = x2clabel),
                       yaxis  = list(title = "", zeroline = F),
                       legend = list(title = list(text = x2clabel)))
      return(fig)
    })

    # density - bivariate
    output$biden <- plotly::renderPlotly({
      yqlabel <- input$yquan
      yqvar <- selectedvar(yqlabel)

      x2clabel <- input$qx2c
      x2cvar <- selectedvar(x2clabel)

      df <- react_df() %>% tidyr::drop_na(all_of(yqvar))

      p <- ggplot2::ggplot(df, aes(
        x = get(yqvar),
        fill = get(x2cvar),
        text = paste0(
          x2clabel, ": ", after_stat(fill),
          "<br>", yqlabel, ": ", round(after_stat(x), 2),
          "<br>Density: ", round(after_stat(density), 2)
        )
      )) +
        ggplot2::geom_density(alpha = 0.5) +
        ggplot2::scale_fill_brewer(palette = "Pastel1") +
        ggplot2::labs(
          title = paste(yqlabel, "by", x2clabel, "- Kernel Density plot"),
          x = yqlabel,
          y = "Density",
          fill = x2clabel
        )

      plotly::ggplotly(p, tooltip = c("text"))
    })




    ## Q-Q plot by cate var
    output$biqq <- plotly::renderPlotly({
      yqlabel <- input$yquan
      yqvar <- selectedvar(yqlabel)

      x2clabel <- input$qx2c
      x2cvar <- selectedvar(x2clabel)

      df <- react_df() %>% tidyr::drop_na(all_of(yqvar))

      p <- ggplot2::ggplot(df, aes(sample = get(yqvar))) +
        ggplot2::geom_qq_line(colour = "darkgrey") +
        ggplot2::geom_qq(aes(colour = get(x2cvar)), alpha = 0.3, size = 0.5) +
        ggplot2::facet_wrap(~ get(x2cvar), ncol = 4) +
        ggplot2::scale_color_brewer(palette = "Pastel1", name = x2clabel) +
        ggplot2::labs(
          title = paste(yqlabel, "by", x2clabel, "- Q-Q Plot"),
          x = "Theoretical Quantiles",
          y = yqlabel,
          colour = x2clabel
        ) +
        ggplot2::theme(legend.position = "none")

      plotly::ggplotly(p, tooltip = NULL)
    })

    ## Tab 5-1-4 Quantitative Outcome Y~X2+X3 ######################
    ### Tab 5-1-4 Layout
    output$paqx2x3 <- renderUI({
      fluidPage(
        fluidRow(h3(textOutput(NS(id, "qyx23text")))), # statement text
        br(),
        fluidRow(plotly::plotlyOutput(NS(id, "qyx23v"))) # Violin Plots
      )
    })

    ### Tab 5-1-4 Contents
    # statement text
    output$qyx23text <- renderText({
      paste(
        "Analysis of: ", input$yquan, "(Y),",
        input$qx2c, "(X2) and", input$qx3c, "(X3)"
      )
    })

    # Violin plot of Y by X2 and X3
    output$qyx23v <- plotly::renderPlotly({
      yqlabel <- input$yquan
      yqvar <- selectedvar(yqlabel)

      x2clabel <- input$qx2c
      x2cvar <- selectedvar(x2clabel)

      x3clabel <- input$qx3c
      x3cvar <- selectedvar(x3clabel)

      df <- react_df() %>% tidyr::drop_na(all_of(yqvar))

      p <- ggplot2::ggplot(df, aes(
        x = get(x2cvar),
        y = get(yqvar),
        fill = get(x2cvar)
      )) +
        ggplot2::geom_violin(alpha = 0.3) +
        ggplot2::geom_boxplot(alpha = 0.8, width = .1) +
        ggplot2::scale_fill_brewer(palette = "Pastel1") +
        ggplot2::facet_wrap(~ get(x3cvar)) +
        ggplot2::labs(
          title = paste(yqlabel, "by", x2clabel, "and", x3clabel, "- Boxplot/Violin Plot"),
          x = x2clabel,
          y = yqlabel,
          fill = x2clabel
        )


      plotly::ggplotly(p, tooltip = NULL)
    })

  })
}

## To be copied in the UI
# mod_tab5_paq_ui("tab5_paq_1")

## To be copied in the server
# mod_tab5_paq_server("tab5_paq_1", react_df = filteredppt)

#' tab5_paq module app
#'
#' @export
#'
#' @noRd
mod_tab5_paq_app <- function() {

  ui <- fluidPage(
    fluidRow(
      mod_tab3_filter_ui("tab3_filter_0", metadf = studymeta, pptdf = ppt_all_fc)
    ),
    fluidRow(
      mod_tab5_paq_ui("tab5_paq_0")
    )
  )

  server <- function(input, output, session) {
    mod_tab3_filter_server("tab3_filter_0", metadf = studymeta, pptdf = ppt_all_fc, infodf = VAR_info)
    filteredppt <- mod_tab3_filter_server("tab3_filter_0", metadf = studymeta, pptdf = ppt_all_fc, infodf = VAR_info)
    mod_tab5_paq_server("tab5_paq_0", react_df = filteredppt)
  }

  shinyApp(ui, server)
}

