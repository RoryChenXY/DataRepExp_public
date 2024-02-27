source("./R/vis_functions.R", local = TRUE)


# Tab 5 Visulisation Module UI ##############################################################
vis_mod_ui <- function(id) {
  ns <- NS("id")
  tagList(
    h2("The Visualisation Tab generates results based on the filters you have applied."),
    fluidPage(
      uiOutput(NS(id, "fvalid")),
      uiOutput(NS(id, "tab4meta"))
      )
  )
}

# Tab 5 Visulisation Module Server ##########################################################
vis_mod_server <- function(id, df1, react_df) {
  moduleServer(id, function(input, output, session) {
    # Check the filtered results
    output$fvalid <- renderUI({
      if (nrow(react_df()) == 0) {
        h2("Base on the filters you have applied,
            no studies were identified, please update your selection.")
      } else {
        a <- paste(nrow(react_df()), "/", nrow(df1)) # filtered studies
        statement <- paste('<br>','<br>',
                           "Based on the filters you applied you have found",
                           a, "studies.",
                           sep = " ")
        h3(HTML(statement))
      }
    })
    
    ## Tab 4-1 Metadata ########################################################
    ###  Tab 4-1 Layout ########################################################
    output$tab4meta <- renderUI({
      if (nrow(react_df()) == 0) {
        h2("Please update the your filter selection.")
      } else {
        fluidPage(
          fluidRow(
            column(6, h4("Min Age at Recruitment"), plotlyOutput(NS(id, "minagebar"))),
            column(6, h4("Sample Size"), plotlyOutput(NS(id, "sizebar")))
          ),
          fluidRow(
            column(3, h4("Data Available through Repository"), plotlyOutput(NS(id, "avapie"))),
            column(3, h4("Follow-up Data Available"), plotlyOutput(NS(id, "fupie"))),
            column(3, h4("Continent"), plotlyOutput(NS(id, "contpie"))),
            column(3, h4("Country Income Level"), plotlyOutput(NS(id, "incomepie")))
          ),
          h4("Data Availability by Categories"),
          fluidRow(
            column(4, plotlyOutput(NS(id, "avacatA"))),
            column(4, plotlyOutput(NS(id, "avacatB"))),
            column(4, plotlyOutput(NS(id, "avacatC")))
          )
        )
      }
    })
    ###  Tab 4-1 Contents ######################################################
    #### Min Age at Recruitment Bar############################################################################################
    output$minagebar <- plotly::renderPlotly({
      a <- react_df()
      b <- df1 %>% filter((STUDY %in% a$STUDY))
      
      df <- b %>%
        mutate(MINAGECat = cut(MINAGE,
                               c(0, 25, 45, 70, 85, 100),
                               right = FALSE,
                               labels = c("15-24", "25-44", "45-69", "70-84", ">=85")
        )) %>%
        group_by(MINAGECat, STUDY) %>%
        summarize(Count = n(), .groups = "keep") %>%
        ungroup() %>%
        group_by(MINAGECat) %>%
        summarize(Count = sum(Count), Study = paste(unique(STUDY), collapse = ", "), .groups = "keep") %>%
        ungroup() %>%
        tidyr::complete(MINAGECat, fill = list(Count = 0, Study = NA_character_))
      
      
      p <- ggplot(df, aes(x = MINAGECat, y = Count, fill = MINAGECat, text = paste("Count: ", Count, "<br>Study: ", Study))) +
        geom_bar(stat = "identity") +
        scale_y_continuous(breaks = pretty_breaks()) +
        scale_fill_brewer(palette = "Pastel1") +
        theme(
          axis.title.x = element_blank(),
          axis.title.y = element_blank(),
          legend.position = "none"
        )
      
      ggplotly(p, tooltip = c("text"))
    })
    
    #### Sample Size Bar############################################################################################
    output$sizebar <- renderPlotly({
      a <- react_df()
      b <- df1 %>% filter((STUDY %in% a$STUDY))
      
      df <- b %>%
        mutate(SIZEcat = cut(STUDYSIZE,
                             c(0, 500, 1000, 2000, 3000, 4000, 5000),
                             right = FALSE,
                             labels = c("<500", "500-999", "1000-1999", "2000-2999", "3000-3999", "4000-4999")
        )) %>%
        group_by(SIZEcat, STUDY) %>%
        summarize(Count = n(), .groups = "keep") %>%
        ungroup() %>%
        group_by(SIZEcat) %>%
        summarize(Count = sum(Count), Study = paste(unique(STUDY), collapse = ", "), .groups = "keep") %>%
        ungroup() %>%
        complete(SIZEcat, fill = list(Count = 0, Study = NA_character_))
      
      
      p <- ggplot(df, aes(x = SIZEcat, y = Count, fill = SIZEcat, text = paste("Count: ", Count, "<br>Study: ", Study))) +
        geom_bar(stat = "identity") +
        scale_y_continuous(breaks = pretty_breaks()) +
        scale_fill_brewer(palette = "Pastel1") +
        theme(
          axis.title.x = element_blank(),
          axis.title.y = element_blank(),
          legend.position = "none"
        )
      
      ggplotly(p, tooltip = c("text"))
    })
    
    #### Data Available through Repository Pie############################################################################################
    output$avapie <- renderPlotly({
      a <- react_df()
      b <- df1 %>% filter((STUDY %in% a$STUDY))
      PieChart(Data = b, VAR = ACCESS)
    })
    
    #### Follow-up Data Available Pie############################################################################################
    output$fupie <- renderPlotly({
      a <- react_df()
      b <- df1 %>% filter((STUDY %in% a$STUDY))
      PieChart(Data = b, VAR = STUDYFOLLOW)
    })
    
    #### Continent Pie############################################################################################
    output$contpie <- renderPlotly({
      a <- react_df()
      b <- df1 %>% filter((STUDY %in% a$STUDY))
      PieChart(Data = b, VAR = CONTINENT)
    })
    #### Country Income Level Pie############################################################################################
    output$incomepie <- renderPlotly({
      a <- react_df()
      b <- df1 %>% filter((STUDY %in% a$STUDY))
      PieChart(Data = b, VAR = INCOMEGROUP)
    })
    
    #### Data Availability by Categories####################################################################################
    output$avacatA <- renderPlotly({
      a <- react_df()
      b <- df1 %>% filter((STUDY %in% a$STUDY))
      
      df1 <- countFactor(b, cat01, "Administration")
      df2 <- countFactor(b, cat02, "Demographics")
      df3 <- countFactor(b, cat03, "Medical History")
      df4 <- countFactor(b, cat04, "Family Disease History")
      df5 <- countFactor(b, cat05, "Service Utilisation")
      
      df <- rbind(df1, df2, df3, df4, df5) %>%
        mutate(Attribute = as.factor(Attribute)) %>%
        mutate(Attribute = fct_rev(Attribute))
      
      CombBar(df)
    })
    
    output$avacatB <- renderPlotly({
      a <- react_df()
      b <- df1 %>% filter((STUDY %in% a$STUDY))
      
      df1 <- countFactor(b, cat06, "Hospital Data")
      df2 <- countFactor(b, cat07, "Survey Data")
      df3 <- countFactor(b, cat08, "Linkage Data")
      df4 <- countFactor(b, cat09, "Imaging Data")
      df5 <- countFactor(b, cat10, "Genomic Data")
      
      df <- rbind(df1, df2, df3, df4, df5) %>%
        mutate(Attribute = as.factor(Attribute)) %>%
        mutate(Attribute = fct_rev(Attribute))
      
      CombBar(df)
    })
    
    output$avacatC <- renderPlotly({
      a <- react_df()
      b <- df1 %>% filter((STUDY %in% a$STUDY))
      
      df1 <- countFactor(b, cat11, "OtherA")
      df2 <- countFactor(b, cat12, "OtherB")
      df3 <- countFactor(b, cat13, "OtherC")
      df4 <- countFactor(b, cat14, "OtherD")
      df5 <- countFactor(b, cat15, "OtherE")
      
      df <- rbind(df1, df2, df3, df4, df5) %>%
        mutate(Attribute = as.factor(Attribute)) %>%
        mutate(Attribute = fct_rev(Attribute))
      
      CombBar(df)
    })
  
    })
}   

## Module App ##################################################################
vis_mod_app <- function(df1, react_df) {
  ui <- fluidPage(
    vis_mod_ui("vis")
  )
  
  server <- function(input, output, session) {
    vis_mod_server("vis", df1, react_df)
  }
  
  shinyApp(ui, server)
}

    
    