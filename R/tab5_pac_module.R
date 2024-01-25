source("./R/vis_functions.R", local = TRUE)

# Variable Options
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
  "Demographics"            = list("Ethnic Background", "Sex", "High School Educated", "Married/De-facto", "Deceased"),
  "Lifestyle"               = list("Smoking Status", "Alcohol Use Status"),
  "Diseases Diagnosis"      = list("Diseases Diagnosis 1", "Diseases Diagnosis 2", "Diseases Diagnosis 3", "Diseases Diagnosis 4"),
  "Service Utilization"     = list("Hospital Outpatient", "Hospital Inpatient", "GP"),
  "Family Diseases History" = list("Family History of Diagnosis 1", "Family History of Diagnosis 2", "Family History of Diagnosis 3"),
  "Imaging Data"            = list("MRI Collected", "Imaging 1 Collected", "Imaging 2 Collected"),
  "Genomic Data"            = list("Geno type 1", "Geno type 2")
)


# Tab 5-2 Preliminary Analysis - Categorical Outcome Module UI ##############################################################
pac_mod_ui <- function(id) {
  ns <- NS("id")
  tagList(
    h2("The Preliminary Analysis tab generates results based on the filters you have selected."),
    h2("Please allow up to a minute for the results to load."),
    fluidPage(
      fluidRow(
        column(3, selectInput(
          inputId = NS(id, "ycate"),
          label = "Categorical Y",
          choices = catevchoice,
          selected = "Diseases Diagnosis 1",
          multiple = FALSE
        )),
        column(3, selectInput(
          inputId = NS(id, "cx1q"),
          label = "Quantitative X1",
          choices = quanchoice,
          selected = "Scale 2",
          multiple = FALSE
        )),
        column(3, pickerInput(
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

# Tab 5-2 Preliminary Analysis - Categorical Outcome Module Server ##########################################################
pac_mod_server <- function(id, df3, react_df) {
  moduleServer(id, function(input, output, session) {
    # Check the filtered results and selected variables
    output$pac_valid <- renderUI({
      if (nrow(react_df()) == 0) {
        h2("Base on the filters you selected,
            no participants were identified, please update your selection.")
      } else {
        if (input$ycate == input$cx2c) {
          h2("Please choose a different Categorical X2") # Variable selection validation
        } else {
          h3(paste0(
            "Base on the filters you selected, you have found ",
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
          column(5, tableOutput(NS(id, "ycstats"))), # summary statistics
          column(5, plotlyOutput(NS(id, "unibar"))) # bar plot
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
      ycvarinfo <- df3 %>% filter(LABELS == yclabel)
      ycvar <- ycvarinfo$VARNAME

      df <- react_df()

      a <- df %>% count(get(ycvar))
      names(a) <- c(yclabel, "Counts")
      a
    })

    # bar plot
    output$unibar <- renderPlotly({
      yclabel <- input$ycate
      ycvarinfo <- df3 %>% filter(LABELS == yclabel)
      ycvar <- ycvarinfo$VARNAME

      df <- react_df()

      temp <- df %>% count(get(ycvar))
      names(temp) <- c("Level", "Counts")

      p <- temp %>%
        ggplot(aes(
          x = Level, y = Counts, fill = Level,
          text = paste0(
            yclabel, ":", ..fill..,
            "<br>Counts:", ..y..
          )
        )) +
        geom_bar(stat = "identity", width = 0.5) +
        scale_fill_brewer(palette = "Pastel1") +
        coord_flip() +
        labs(
          title = paste("Participants by", yclabel),
          x = yclabel,
          fill = yclabel
        )

      ggplotly(p, tooltip = "text")
    })


    ## Tab 5-2-2 Categorical Outcome Y~X1 Analysis ######################

    ### Tab 5-2-2 Layout ######################
    output$pacx1 <- renderUI({
      fluidPage(
        br(),
        fluidRow(h3(textOutput(NS(id, "cyx1text")))), # statement text
        plotlyOutput(NS(id, "cyx1jitter")) # scatter plots
      )
    })
    ### Tab 5-2-2 Contents ######################
    # statement text
    output$cyx1text <- renderText({
      paste("Analysis of: ", input$ycate, "(Y) and", input$cx1q, "(X1)")
    })

    # scatterplots
    output$cyx1jitter <- renderPlotly({
      yclabel <- input$ycate
      ycvarinfo <- df3 %>% filter(LABELS == yclabel)
      ycvar <- ycvarinfo$VARNAME

      x1qlabel <- input$cx1q
      x1qvarinfo <- df3 %>% filter(LABELS == x1qlabel)
      x1qvar <- x1qvarinfo$VARNAME


      df <- react_df() %>% drop_na(all_of(x1qvar))

      p <- ggplot(df, aes(
        y = get(ycvar),
        x = get(x1qvar),
        colour = get(ycvar),
        text = paste0(
          x1qlabel, ":", ..x..,
          "<br>", yclabel, ":", ..colour..
        )
      )) +
        geom_jitter(alpha = 0.7, size = 1.5) +
        scale_color_brewer(palette = "Pastel1", name = yclabel) +
        labs(
          title = " ",
          x = x1qlabel,
          y = yclabel,
          colour = yclabel
        )

      ggplotly(p, tooltip = "text")
    })


    ## Tab 5-2-3 Categorical Outcome Y~X2 Analysis ######################
    ### Tab 5-2-3 Layout ######################
    output$pacx2 <- renderUI({
      fluidPage(
        br(),
        fluidRow(h3(textOutput(NS(id, "cyx2text")))), # statement text
        fluidRow(tableOutput(NS(id, "cyx2stats"))), # summary statistics
        br(),
        fluidRow(
          column(5, plotlyOutput(NS(id, "cyx2bar1"))), # bar plot - stacked
          column(5, plotlyOutput(NS(id, "cyx2bar2"))) # bar plot - dodge
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
      ycvarinfo <- df3 %>% filter(LABELS == yclabel)
      ycvar <- ycvarinfo$VARNAME

      x2clabel <- input$cx2c
      x2cvarinfo <- df3 %>% filter(LABELS == x2clabel)
      x2cvar <- x2cvarinfo$VARNAME

      df <- react_df()

      a <- df %>% count(get(ycvar), get(x2cvar))

      b <- a %>%
        tidyr::pivot_wider(
          names_from = "get(x2cvar)", values_from = n
        )

      names(b)[1] <- yclabel

      b
    })

    # Barplot - stack
    output$cyx2bar1 <- renderPlotly({
      yclabel <- input$ycate
      ycvarinfo <- df3 %>% filter(LABELS == yclabel)
      ycvar <- ycvarinfo$VARNAME

      x2clabel <- input$cx2c
      x2cvarinfo <- df3 %>% filter(LABELS == x2clabel)
      x2cvar <- x2cvarinfo$VARNAME

      df <- react_df()

      temp <- df %>% count(get(ycvar), get(x2cvar))
      names(temp) <- c("yLevel", "xLevel", "Counts")

      p <- temp %>%
        ggplot(aes(
          x = yLevel, y = Counts, fill = xLevel,
          text = paste(
            yclabel, ":", yLevel,
            "<br>", x2clabel, ":", xLevel,
            "<br>Counts:", Counts
          )
        )) +
        geom_bar(stat = "identity", position = "stack", width = 0.5) +
        scale_fill_brewer(palette = "Pastel1") +
        labs(
          title = " ",
          x = yclabel,
          y = "Counts",
          fill = x2clabel
        )

      ggplotly(p, tooltip = "text")
    })
    # Barplot - dodge
    output$cyx2bar2 <- renderPlotly({
      yclabel <- input$ycate
      ycvarinfo <- df3 %>% filter(LABELS == yclabel)
      ycvar <- ycvarinfo$VARNAME

      x2clabel <- input$cx2c
      x2cvarinfo <- df3 %>% filter(LABELS == x2clabel)
      x2cvar <- x2cvarinfo$VARNAME

      df <- react_df()

      temp <- df %>% count(get(ycvar), get(x2cvar))
      names(temp) <- c("yLevel", "xLevel", "Counts")

      p <- temp %>%
        ggplot(aes(
          x = yLevel, y = Counts, fill = xLevel,
          text = paste(
            yclabel, ":", yLevel,
            "<br>", x2clabel, ":", xLevel,
            "<br>Counts:", Counts
          )
        )) +
        geom_bar(stat = "identity", position = "dodge", width = 0.5) +
        scale_fill_brewer(palette = "Pastel1") +
        labs(
          title = " ",
          x = yclabel,
          y = "Counts",
          fill = x2clabel
        )

      ggplotly(p, tooltip = "text")
    })
  })
}


## Module App ##################################################################
pac_mod_app <- function(df3, react_df) {
  ui <- fluidPage(
    pac_mod_ui("pacate")
  )

  server <- function(input, output, session) {
    pac_mod_server("pacate", df1, react_df)
  }

  shinyApp(ui, server)
}
