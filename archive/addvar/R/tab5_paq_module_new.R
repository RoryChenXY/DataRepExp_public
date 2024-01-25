source("./R/vis_functions.R", local = TRUE)

# Variable Options
quanchoice <- list(
  "Age at Assessment",
  "Year of Death",
  "BMI",
  "Scale 1",
  "Scale 2",
  "Scale 3",
  "Scale 4", 
  "MMSE" #!UPDATES!#
)
catevchoice <- list(
  "Demographics"            = list("Ethnic Background", "Sex", "High School Educated", "Married/De-facto", "Deceased"),
  "Lifestyle"               = list("Smoking Status", "Alcohol Use Status"),
  "Diseases Diagnosis"      = list("Diseases Diagnosis 1", "Diseases Diagnosis 2", "Diseases Diagnosis 3", "Diseases Diagnosis 4"),
  "Service Utilization"     = list("Hospital Outpatient", "Hospital Inpatient", "GP"),
  "Family Diseases History" = list("Family History of Diagnosis 1", "Family History of Diagnosis 2", "Family History of Diagnosis 3"),
  "Imaging Data"            = list("MRI Collected", "Imaging 1 Collected", "Imaging 2 Collected"),
  "Genomic Data"            = list("Geno type 1", "Geno type 2")
)

# colours
Pastel1Colors <- RColorBrewer::brewer.pal(name = "Pastel1", n = 9)

# Tab 5-1 Preliminary Analysis - Quantitative Outcome Module UI ##############################################################
paq_mod_ui <- function(id) {
  ns <- NS("id")
  tagList(
    h2("The Preliminary Analysis tab generates results based on the filters you have selected."),
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
        column(3, pickerInput(
          inputId = NS(id, "qx2c"),
          label = "Categorical X2",
          choices = catevchoice,
          selected = "Alcohol Use Status",
          multiple = FALSE
        )),
        column(3, pickerInput(
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

# Tab 5-1 Preliminary Analysis - Quantitative Outcome Module Server ##########################################################
paq_mod_server <- function(id, df3, react_df) {
  moduleServer(id, function(input, output, session) {
    # Check the filtered results and selected variables
    output$paq_valid <- renderUI({
      if (nrow(react_df()) == 0) {
        h2("Base on the filters you selected,
            no participants were identified, please update your selection.")
      } else {
        if (input$yquan == input$qx1q) {
          h2("Please choose a different Quantitative X1") # Variable selection validation
        } else if (input$qx2c == input$qx3c) {
          h2("Please choose a different Categorical X3") # Variable selection validation
        } else {
          h3(paste0(
            "Base on the filters you selected, you have found ",
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
          column(5, plotlyOutput(NS(id, "unibox"))), # box plot
          column(5, plotlyOutput(NS(id, "unihis"))) # histogram
        ),
        br(),
        fluidRow(
          column(5, plotlyOutput(NS(id, "uniden"))), # density
          column(5, plotlyOutput(NS(id, "uniqq"))) # QQ plot
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
      yqvarinfo <- df3 %>% filter(LABELS == yqlabel)
      yqvar <- yqvarinfo$VARNAME

      a <- df %>%
        summarise(
          SampleSize = n(),
          NACount = sum(is.na(get(yqvar))),
          Mean = mean(get(yqvar), na.rm = TRUE),
          SD = sd(get(yqvar), na.rm = TRUE),
          Medium = quantile(get(yqvar), 0.5, na.rm = TRUE),
          IQR = IQR(get(yqvar), na.rm = TRUE),
          Min = min(get(yqvar), na.rm = TRUE),
          Max = max(get(yqvar), na.rm = TRUE)
        )
      a
    })

    # boxplot - univariate
    output$unibox <- renderPlotly({
      yqlabel <- input$yquan
      yqvarinfo <- df3 %>% filter(LABELS == yqlabel)
      yqvar <- yqvarinfo$VARNAME

      df <- react_df() %>% drop_na(all_of(yqvar))

      p <- ggplot(df, aes(y = get(yqvar))) +
        geom_boxplot(fill = Pastel1Colors[1]) +
        labs(
          title = paste(yqlabel, "- Boxplot"),
          y = yqlabel
        )

      ggplotly(p)
    })

    # histogram - univariate
    output$unihis <- renderPlotly({
      yqlabel <- input$yquan
      yqvarinfo <- df3 %>% filter(LABELS == yqlabel)
      yqvar <- yqvarinfo$VARNAME

      df <- react_df() %>% drop_na(all_of(yqvar))

      p <- ggplot(df, aes(
        x = get(yqvar),
        text = paste0(
          yqlabel, ": ", round(after_stat(x), 2),
          "<br>Count: ", ..count..
        )
      )) +
        geom_histogram(fill = Pastel1Colors[5]) +
        labs(
          title = paste(yqlabel, "- Histogram"),
          x = yqlabel,
          y = "Count"
        )

      ggplotly(p, tooltip = c("text"))
    })

    # density - univariate
    output$uniden <- renderPlotly({
      yqlabel <- input$yquan
      yqvarinfo <- df3 %>% filter(LABELS == yqlabel)
      yqvar <- yqvarinfo$VARNAME

      df <- react_df() %>% drop_na(all_of(yqvar))

      p <- ggplot(df, aes(
        x = get(yqvar),
        text = paste0(
          yqlabel, ": ", round(after_stat(x), 2),
          "<br>Density: ", round(..density.., 2)
        )
      )) +
        geom_density(fill = Pastel1Colors[3], color = "white", alpha = 0.5) +
        labs(
          title = paste("Density of", yqlabel),
          x = yqlabel,
          y = "Density"
        )

      ggplotly(p, tooltip = c("text"))
    })

    # Q-Q plot- univariate
    output$uniqq <- renderPlotly({ # !!Update tooltip

      yqlabel <- input$yquan
      yqvarinfo <- df3 %>% filter(LABELS == yqlabel)
      yqvar <- yqvarinfo$VARNAME

      df <- react_df() %>% drop_na(all_of(yqvar))

      p <- ggplot(df, aes(
        sample = get(yqvar),
        text = paste0(
          yqlabel, ": ", after_stat(sample),
          "<br>Theoretical Quantiles: ", after_stat(theoretical)
        )
      )) +
        stat_qq(color = Pastel1Colors[2]) +
        labs(
          title = paste("Q-Q Plot of", yqlabel),
          x = "Theoretical Quantiles",
          y = "Sample Quantiles"
        )

      # Update the tooltip text
      ggplotly(p, tooltip = c("text"))
    })

    ## Tab 5-1-2 Quantitative Outcome Y~X1+X2 ######################
    ### Tab 5-1-2 Layout
    output$paqx1x2 <- renderUI({
      fluidPage(
        fluidRow(h3(textOutput(NS(id, "qyx12text")))), # statement text
        br(),
        fluidRow(
          column(5, plotlyOutput(NS(id, "qyx1point"))), # Scatter Plot Y~X1
          column(5, plotlyOutput(NS(id, "qyx12point"))) # Scatter Plot Y~X1 coloured by X2
        ),
        br(),
        fluidRow(
          column(10, plotlyOutput(NS(id, "qyx12facet"))) # Scatter Plot Y~X1 panel by X2
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
    output$qyx1point <- renderPlotly({
      yqlabel <- input$yquan
      yqvarinfo <- df3 %>% filter(LABELS == yqlabel)
      yqvar <- yqvarinfo$VARNAME

      x1qlabel <- input$qx1q
      x1qvarinfo <- df3 %>% filter(LABELS == x1qlabel)
      x1qvar <- x1qvarinfo$VARNAME

      df <- react_df() %>%
        drop_na(all_of(yqvar)) %>%
        drop_na(all_of(x1qvar))

      p <- ggplot(df, aes(
        x = get(x1qvar),
        y = get(yqvar),
        text = paste0(
          x1qlabel, ": ", round(after_stat(x), 2),
          "<br>", yqlabel, ": ", round(after_stat(y), 2)
        )
      )) +
        geom_point(color = Pastel1Colors[1], alpha = 0.5) +
        geom_smooth(formula = "y ~ x", color = Pastel1Colors[2], method = lm, se = TRUE) +
        labs(
          title = paste(yqlabel, "by", x1qlabel, "- Scatter Plot"),
          x = x1qlabel,
          y = yqlabel
        )

      ggplotly(p, tooltip = "text")
    })

    # Scatter Plot Y~X1 coloured by X2
    output$qyx12point <- renderPlotly({
      yqlabel <- input$yquan
      yqvarinfo <- df3 %>% filter(LABELS == yqlabel)
      yqvar <- yqvarinfo$VARNAME

      x1qlabel <- input$qx1q
      x1qvarinfo <- df3 %>% filter(LABELS == x1qlabel)
      x1qvar <- x1qvarinfo$VARNAME

      x2clabel <- input$qx2c
      x2cvarinfo <- df3 %>% filter(LABELS == x2clabel)
      x2cvar <- x2cvarinfo$VARNAME

      df <- react_df() %>%
        drop_na(all_of(yqvar)) %>%
        drop_na(all_of(x1qvar))

      p <- ggplot(df, aes(
        x = get(x1qvar),
        y = get(yqvar),
        colour = get(x2cvar),
        text = paste0(
          x1qlabel, ": ", round(after_stat(x), 2),
          "<br>", yqlabel, ": ", round(after_stat(y), 2),
          "<br>", x2clabel, ": ", after_stat(color)
        )
      )) +
        geom_point(alpha = 0.5) +
        scale_color_brewer(palette = "Pastel1", name = x2clabel) +
        labs(
          title = paste(yqlabel, "by", x1qlabel, "colored by", x2clabel, "- Scatter Plot"),
          x = x1qlabel,
          y = yqlabel,
          colour = x2clabel
        )

      ggplotly(p, tooltip = "text")
    })

    # Scatter Plot between two quantitative variables - Facet
    output$qyx12facet <- renderPlotly({
      yqlabel <- input$yquan
      yqvarinfo <- df3 %>% filter(LABELS == yqlabel)
      yqvar <- yqvarinfo$VARNAME

      x1qlabel <- input$qx1q
      x1qvarinfo <- df3 %>% filter(LABELS == x1qlabel)
      x1qvar <- x1qvarinfo$VARNAME

      x2clabel <- input$qx2c
      x2cvarinfo <- df3 %>% filter(LABELS == x2clabel)
      x2cvar <- x2cvarinfo$VARNAME

      df <- react_df() %>%
        drop_na(all_of(yqvar)) %>%
        drop_na(all_of(x1qvar))

      p <- ggplot(df, aes(
        x = get(x1qvar),
        y = get(yqvar),
        colour = get(x2cvar),
        text = paste0(
          x1qlabel, ": ", round(after_stat(x), 2),
          "<br>", yqlabel, ": ", round(after_stat(y), 2),
          "<br>", x2clabel, ": ", after_stat(color)
        )
      )) +
        geom_point(alpha = 0.9) +
        geom_smooth(formula = "y ~ x", method = lm, se = TRUE) +
        facet_wrap(~ get(x2cvar), ncol = 4) +
        scale_color_brewer(palette = "Pastel1", name = x2clabel) +
        labs(
          title = paste(yqlabel, "by", x1qlabel, "colored by", x2clabel, "- Scatter Plot"),
          x = x1qlabel,
          y = yqlabel,
          colour = x2clabel
        )

      ggplotly(p, tooltip = "text")
    })

    ## Tab 5-1-3 Quantitative Outcome Y~X2 ######################
    ### Tab 5-1-3 Layout
    output$paqx2 <- renderUI({
      fluidPage(
        fluidRow(h3(textOutput(NS(id, "qyx2text")))), # statement text
        fluidRow(tableOutput(NS(id, "qyx2stats"))), # summary statistics
        br(),
        fluidRow(
          column(5, plotlyOutput(NS(id, "bibox"))), # box plot Y~X2
          column(5, plotlyOutput(NS(id, "biden"))) # density Y~X2
        ),
        br(),
        fluidRow(
          column(5, plotlyOutput(NS(id, "bihis1"))), # histogram - dodge Y~X2
          column(5, plotlyOutput(NS(id, "bihis2"))) # histogram - stack Y~X2
        ),
        br(),
        fluidRow(
          column(10, plotlyOutput(NS(id, "biqq"))) # QQ plot Y~X2
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
      yqvarinfo <- df3 %>% filter(LABELS == yqlabel)
      yqvar <- yqvarinfo$VARNAME

      x2clabel <- input$qx2c
      x2cvarinfo <- df3 %>% filter(LABELS == x2clabel)
      x2cvar <- x2cvarinfo$VARNAME

      a <- df %>%
        group_by(get(x2cvar)) %>%
        summarise(
          SampleSize = n(),
          NACount = sum(is.na(get(yqvar))),
          Mean = mean(get(yqvar), na.rm = TRUE),
          SD = sd(get(yqvar), na.rm = TRUE),
          Medium = quantile(get(yqvar), 0.5, na.rm = TRUE),
          IQR = IQR(get(yqvar), na.rm = TRUE),
          Min = min(get(yqvar), na.rm = TRUE),
          Max = max(get(yqvar), na.rm = TRUE)
        )
      colnames(a)[1] <- x2clabel
      a
    })

    # boxplot - bivariate
    output$bibox <- renderPlotly({
      yqlabel <- input$yquan
      yqvarinfo <- df3 %>% filter(LABELS == yqlabel)
      yqvar <- yqvarinfo$VARNAME

      x2clabel <- input$qx2c
      x2cvarinfo <- df3 %>% filter(LABELS == x2clabel)
      x2cvar <- x2cvarinfo$VARNAME

      df <- react_df() %>% drop_na(all_of(yqvar))

      p <- ggplot(df, aes(
        x = get(x2cvar),
        y = get(yqvar),
        fill = get(x2cvar)
      )) +
        geom_violin(alpha = 0.3) +
        geom_boxplot(alpha = 0.8, width = .2) +
        scale_fill_brewer(palette = "Pastel1") +
        labs(
          title = paste(yqlabel, "by", x2clabel, "- Boxplot/Violin Plot"),
          y = yqlabel, x = x2clabel, fill = x2clabel
        )

      ggplotly(p, tooltip = NULL)
    })

    # density - bivariate
    output$biden <- renderPlotly({
      yqlabel <- input$yquan
      yqvarinfo <- df3 %>% filter(LABELS == yqlabel)
      yqvar <- yqvarinfo$VARNAME

      x2clabel <- input$qx2c
      x2cvarinfo <- df3 %>% filter(LABELS == x2clabel)
      x2cvar <- x2cvarinfo$VARNAME

      df <- react_df() %>% drop_na(all_of(yqvar))

      p <- ggplot(df, aes(
        x = get(yqvar),
        fill = get(x2cvar),
        text = paste0(
          x2clabel, ": ", ..fill..,
          "<br>", yqlabel, ": ", round(..x.., 2),
          "<br>Density: ", round(..density.., 2)
        )
      )) +
        geom_density(alpha = 0.5) +
        scale_fill_brewer(palette = "Pastel1") +
        labs(
          title = paste(yqlabel, "by", x2clabel, "- Kernel Density plot"),
          x = yqlabel,
          y = "Density",
          fill = x2clabel
        )

      ggplotly(p, tooltip = c("text"))
    })

    # histogram - dodge - bivariate
    output$bihis1 <- renderPlotly({
      yqlabel <- input$yquan
      yqvarinfo <- df3 %>% filter(LABELS == yqlabel)
      yqvar <- yqvarinfo$VARNAME

      x2clabel <- input$qx2c
      x2cvarinfo <- df3 %>% filter(LABELS == x2clabel)
      x2cvar <- x2cvarinfo$VARNAME

      df <- react_df() %>% drop_na(all_of(yqvar))

      p <- ggplot(df, aes(
        x = get(yqvar),
        fill = get(x2cvar),
        text = paste0(
          x2clabel, ": ", ..fill..,
          "<br>", yqlabel, ": ", round(..x.., 2),
          "<br>Count: ", ..count..
        )
      )) +
        geom_histogram(position = "dodge") +
        scale_fill_brewer(palette = "Pastel1") +
        labs(
          title = paste(yqlabel, "by", x2clabel, "- Dodge Histogram"),
          x = yqlabel,
          y = "Count",
          fill = x2clabel
        )

      ggplotly(p, tooltip = c("text"))
    })

    # histogram - stack - bivariate
    output$bihis2 <- renderPlotly({
      yqlabel <- input$yquan
      yqvarinfo <- df3 %>% filter(LABELS == yqlabel)
      yqvar <- yqvarinfo$VARNAME

      x2clabel <- input$qx2c
      x2cvarinfo <- df3 %>% filter(LABELS == x2clabel)
      x2cvar <- x2cvarinfo$VARNAME

      df <- react_df() %>% drop_na(all_of(yqvar))

      p <- ggplot(df, aes(
        x = get(yqvar),
        fill = get(x2cvar),
        text = paste0(
          x2clabel, ": ", ..fill..,
          "<br>", yqlabel, ": ", round(..x.., 2),
          "<br>Count: ", ..count..
        )
      )) +
        geom_histogram(position = "stack") +
        scale_fill_brewer(palette = "Pastel1") +
        labs(
          title = paste(yqlabel, "by", x2clabel, "- Stack Histogram"),
          x = yqlabel,
          y = "Count",
          fill = x2clabel
        )

      ggplotly(p, tooltip = c("text"))
    })

    ## Q-Q plot by cate var
    output$biqq <- renderPlotly({
      yqlabel <- input$yquan
      yqvarinfo <- df3 %>% filter(LABELS == yqlabel)
      yqvar <- yqvarinfo$VARNAME

      x2clabel <- input$qx2c
      x2cvarinfo <- df3 %>% filter(LABELS == x2clabel)
      x2cvar <- x2cvarinfo$VARNAME

      df <- react_df() %>% drop_na(all_of(yqvar))

      p <- ggplot(df, aes(sample = get(yqvar))) +
        geom_qq_line(colour = "darkgrey") +
        geom_qq(aes(colour = get(x2cvar)), alpha = 0.3, size = 0.5) +
        facet_wrap(~ get(x2cvar), ncol = 4) +
        scale_color_brewer(palette = "Pastel1", name = x2clabel) +
        labs(
          title = paste(yqlabel, "by", x2clabel, "- Q-Q Plot"),
          x = "Theoretical Quantiles",
          y = yqlabel,
          colour = x2clabel
        ) +
        theme(legend.position = "none")

      ggplotly(p, tooltip = NULL)
    })

    ## Tab 5-1-4 Quantitative Outcome Y~X2+X3 ######################
    ### Tab 5-1-4 Layout
    output$paqx2x3 <- renderUI({
      fluidPage(
        fluidRow(h3(textOutput(NS(id, "qyx23text")))), # statement text
        br(),
        fluidRow(plotlyOutput(NS(id, "qyx23v"))) # Violin Plots
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
    output$qyx23v <- renderPlotly({
      yqlabel <- input$yquan
      yqvarinfo <- df3 %>% filter(LABELS == yqlabel)
      yqvar <- yqvarinfo$VARNAME

      x2clabel <- input$qx2c
      x2cvarinfo <- df3 %>% filter(LABELS == x2clabel)
      x2cvar <- x2cvarinfo$VARNAME

      x3clabel <- input$qx3c
      x3cvarinfo <- df3 %>% filter(LABELS == x3clabel)
      x3cvar <- x3cvarinfo$VARNAME

      df <- react_df() %>% drop_na(all_of(yqvar))

      p <- ggplot(df, aes(
        x = get(x2cvar),
        y = get(yqvar),
        fill = get(x2cvar)
      )) +
        geom_violin(alpha = 0.3) +
        geom_boxplot(alpha = 0.8, width = .1) +
        scale_fill_brewer(palette = "Pastel1") +
        facet_wrap(~ get(x3cvar)) +
        labs(
          title = paste(yqlabel, "by", x2clabel, "and", x3clabel, "- Boxplot/Violin Plot"),
          x = x2clabel,
          y = yqlabel,
          fill = x2clabel
        )


      ggplotly(p, tooltip = NULL)
    })
  })
}


## Module App ##################################################################
paq_mod_app <- function(df3, react_df) {
  ui <- fluidPage(
    paq_mod_ui("paquan")
  )

  server <- function(input, output, session) {
    paq_mod_server("paquan", df1, react_df)
  }

  shinyApp(ui, server)
}
