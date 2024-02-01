source("./R/vis_functions.R", local = TRUE)

# Tab 4 Module UI ##############################################################
vis_mod_ui <- function(id) {
  ns <- NS("id")
  tagList(
    h2("The Visualisation Tab generates results
        based on the filters you have applied."),
    fluidPage(
      uiOutput(NS(id, "fvalid")),
      tabsetPanel(
        id = NS(id, "visaultabs"),
        type = "tabs",
        tabPanel("Metadata", uiOutput(NS(id, "tab4meta"))),
        tabPanel("Demographics", uiOutput(NS(id, "tab4dem"))),
        tabPanel("Lifestyle", uiOutput(NS(id, "tab4life"))),
        tabPanel("Scales", uiOutput(NS(id, "tab4scale"))),
        tabPanel("Health and Family History", uiOutput(NS(id, "tab4health"))),
        tabPanel("Imaging and Genomic Data", uiOutput(NS(id, "tab4imgeno")))
      )
    )
  )
}

# Tab 4 Module Server ##########################################################
vis_mod_server <- function(id, df1, react_df) {
  moduleServer(id, function(input, output, session) {
    # Check the filtered results
    output$fvalid <- renderUI({
      if (nrow(react_df()) == 0) {
        h2("Base on the filters you have applied,
            no participants were identified, please update your selection.")
      } else {
        a <- react_df()
        df <- a %>% count(SEX, .drop = FALSE, name = "Count")
        fluidPage(
          h3("Base on the filters you applied,
              you have found: "),
          fluidRow(
            column(width = 2, HTML(paste(icon("object-ungroup"), "Studies: ", length(unique(a$STUDY))))),
            column(width = 2, HTML(paste(icon("users"), "Participants: ", nrow(a)))),
            column(width = 2, HTML(paste(icon("male"), "Male: ", df$Count[1]))),
            column(width = 2, HTML(paste(icon("female"), "Female: ", df$Count[2]))),
            column(width = 2, HTML(paste(icon("transgender"), "Other: ", df$Count[3]))),
            column(width = 2, HTML(paste(icon("question-circle"), "Sex Missing: ", df$Count[4])))
          ),
        )
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




    ## Tab 4-2 Demographics ####################################################
    ###  Tab 4-2 Layout ########################################################
    output$tab4dem <- renderUI({
      if (nrow(react_df()) == 0) {
        h2("Please update the your filter selection.")
      } else {
        fluidPage(
          fluidRow(
            column(6, h4("Age Group by Sex"), plotlyOutput(NS(id, "agebygender"))),
            column(6, h4("Ethnic Background"), plotlyOutput(NS(id, "ethpie")))
          ),
          fluidRow(
            column(3, h4("Sex"), plotlyOutput(NS(id, "sexpie"))),
            column(3, h4("High School Educated"), plotlyOutput(NS(id, "edupie"))),
            column(3, h4("Married/De-facto"), plotlyOutput(NS(id, "marrypie"))),
            column(3, h4("Deceased"), plotlyOutput(NS(id, "deathpie")))
          )
        )
      }
    })
    ###  Tab 4-2 Contents ######################################################
    #### Age Group by Sex########################################################################################
    output$agebygender <- renderPlotly({
      a <- react_df() %>%
        mutate(AgeCat = cut(AGEATASS,
          c(0, 20, 30, 40, 53, 60, 70, 80, 90, 100, 200),
          right = FALSE,
          c("<20", "20-29", "30-39", "40-49", "50-59", "60-69", "70-79", "80-89", "90-99", "100+")
        )) %>%
        group_by(SEX) %>%
        count(AgeCat, name = "Count", .drop = FALSE)


      p <- ggplot(a, aes(x = AgeCat, y = Count, fill = SEX, text = paste("Count: ", Count, "<br>Sex: ", SEX))) +
        geom_bar(stat = "identity", position = "dodge") +
        scale_y_continuous(breaks = pretty_breaks()) +
        scale_fill_brewer(palette = "Pastel1") +
        theme(
          axis.title.x = element_blank(),
          axis.title.y = element_blank()
        )

      ggplotly(p, tooltip = c("text")) %>%
        layout(legend = list(title = "", orientation = "h"))
    })


    #### Ethnic Background Pie########################################################################################
    output$ethpie <- renderPlotly({
      a <- react_df()
      PieChart(Data = a, VAR = ETHNICBACK)
    })
    #### Sex Pie########################################################################################
    output$sexpie <- renderPlotly({
      a <- react_df()
      PieChart(Data = a, VAR = SEX)
    })
    #### High School Educated Pie########################################################################################
    output$edupie <- renderPlotly({
      a <- react_df()
      PieChart(Data = a, VAR = EDUHIGHS)
    })
    #### Married/De-facto Pie########################################################################################
    output$marrypie <- renderPlotly({
      a <- react_df()
      PieChart(Data = a, VAR = MARISTAT)
    })
    #### Deceased Pie########################################################################################
    output$deathpie <- renderPlotly({
      a <- react_df()
      PieChart(Data = a, VAR = DECEASED)
    })

    ## Tab 4-3 Lifestyle #######################################################
    ###  Tab 4-3 Layout ########################################################
    output$tab4life <- renderUI({
      if (nrow(react_df()) == 0) {
        h2("Please update the your filter selection.")
      } else {
        fluidPage(
          fluidRow(
            column(3, h4("Smoking Status"), plotlyOutput(NS(id, "smkpie"))),
            column(3, h4("Alcohol Use Status"), plotlyOutput(NS(id, "alcpie"))),
            column(6, h4("BMI by Sex"), plotlyOutput(NS(id, "bmihis")))
          )
        )
      }
    })
    ###  Tab 4-3 Contents ######################################################
    #### Smoking Status Pie########################################################################################
    output$smkpie <- renderPlotly({
      a <- react_df()
      PieChart(Data = a, VAR = SMOKESTAT)
    })
    #### Alcohol Use Status Pie########################################################################################
    output$alcpie <- renderPlotly({
      a <- react_df()
      PieChart(Data = a, VAR = ALCSTAT)
    })
    #### BMI by Sex Histogram########################################################################################
    output$bmihis <- renderPlotly({
      a <- react_df() %>% drop_na(BMI)
      HisOption(a, BMI, SEX, "stack")
    })
    ## Tab 4-4 Scales ##########################################################
    ###  Tab 4-4 Layout ########################################################
    output$tab4scale <- renderUI({
      if (nrow(react_df()) == 0) {
        h2("Please update the your filter selection.")
      } else {
        fluidPage(
          fluidRow(
            column(6, h4("Scale 1 by Diagnosis 1"), plotlyOutput(NS(id, "s1his"))),
            column(6, h4("Scale 2 by Alcohol Use Status"), plotlyOutput(NS(id, "s2his")))
          ),
          fluidRow(
            column(6, h4("Scale 3 by Hospital Inpatient"), plotlyOutput(NS(id, "s3his"))),
            column(6, h4("Scale 4 by Geno1"), plotlyOutput(NS(id, "s4his")))
          )
        )
      }
    })
    ###  Tab 4-4 Contents ######################################################
    #### Scale 1 by Diagnosis 1 Histogram########################################################################################
    output$s1his <- renderPlotly({
      a <- react_df() %>% drop_na(SCALE1)
      HisOption(a, SCALE1, DIA1, "dodge")
    })
    #### Scale 2 by ALCSTAT Histogram########################################################################################
    output$s2his <- renderPlotly({
      a <- react_df() %>% drop_na(SCALE2)
      HisOption(a, SCALE2, ALCSTAT, "stack")
    })
    #### Scale 3 by Hospital Inpatient Histogram########################################################################################
    output$s3his <- renderPlotly({
      a <- react_df() %>% drop_na(SCALE3)
      HisOption(a, SCALE3, HOSINP, "dodge")
    })
    #### Scale 4 by GENO1 Histogram########################################################################################
    output$s4his <- renderPlotly({
      a <- react_df() %>% drop_na(SCALE4)
      HisOption(a, SCALE4, GENO1, "stack")
    })
    ## Tab 4-5 Health and Family History #######################################
    ###  Tab 4-5 Layout ########################################################
    output$tab4health <- renderUI({
      if (nrow(react_df()) == 0) {
        h2("Please update the your filter selection.")
      } else {
        fluidPage(
          fluidRow(
            column(4, h4("Disease Diagnoses"), plotlyOutput(NS(id, "diaall"))),
            column(4, h4("Family History of Diseases"), plotlyOutput(NS(id, "famdall"))),
            column(4, h4("Service Utilisation"), plotlyOutput(NS(id, "suall")))
          )
        )
      }
    })
    ###  Tab 4-5 Contents ######################################################
    #### Diseases Diagnosis########################################################################################
    output$diaall <- renderPlotly({
      a <- react_df()

      df1 <- countFactor(a, DIA1, "Diagnosis 1")
      df2 <- countFactor(a, DIA2, "Diagnosis 2")
      df3 <- countFactor(a, DIA3, "Diagnosis 3")
      df4 <- countFactor(a, DIA4, "Diagnosis 4")

      df <- rbind(df1, df2, df3, df4) %>%
        mutate(Attribute = as.factor(Attribute)) %>%
        mutate(Attribute = fct_rev(Attribute))

      CombBar(df)
    })

    #### Service Utilisation########################################################################################
    output$suall <- renderPlotly({
      a <- react_df()

      df1 <- countFactor(a, HOSOUP, "Hospital Outpatient")
      df2 <- countFactor(a, HOSINP, "Hospital Inpatient")
      df3 <- countFactor(a, GP, "GP")

      df <- rbind(df1, df2, df3) %>%
        mutate(Attribute = as.factor(Attribute)) %>%
        mutate(Attribute = fct_rev(Attribute))

      CombBar(df)
    })
    #### Family Diseases History########################################################################################

    output$famdall <- renderPlotly({
      a <- react_df()

      df1 <- countFactor(a, FAMDIA1, "Diagnosis 1")
      df2 <- countFactor(a, FAMDIA2, "Diagnosis 2")
      df3 <- countFactor(a, FAMDIA3, "Diagnosis 3")


      df <- rbind(df1, df2, df3) %>%
        mutate(Attribute = as.factor(Attribute)) %>%
        mutate(Attribute = fct_rev(Attribute))

      CombBar(df)
    })
    ## Tab 4-6 Imaging and Genomic Data ########################################
    ###  Tab 4-6 Layout ########################################################
    output$tab4imgeno <- renderUI({
      if (nrow(react_df()) == 0) {
        h2("Please update the your filter selection.")
      } else {
        fluidPage(
          fluidRow(
            column(4, h4("MRI Collected"), plotlyOutput(NS(id, "mripie"))),
            column(4, h4("Imaging 1 Collected"), plotlyOutput(NS(id, "img1pie"))),
            column(4, h4("Imaging 2 Collected"), plotlyOutput(NS(id, "img2pie")))
          ),
          fluidRow(
            column(4, h4("Geno type 1"), plotlyOutput(NS(id, "geno1pie"))),
            column(4, h4("Geno type 2"), plotlyOutput(NS(id, "geno2pie")))
          )
        )
      }
    })
    ###  Tab 4-6 Contents ######################################################
    #### MRIpie########################################################################################
    output$mripie <- renderPlotly({
      a <- react_df()
      PieChart(Data = a, VAR = MRICOLL)
    })

    #### IMG1pie########################################################################################
    output$img1pie <- renderPlotly({
      a <- react_df()
      PieChart(Data = a, VAR = IMGCOLL1)
    })

    #### IMG2pie########################################################################################
    output$img2pie <- renderPlotly({
      a <- react_df()
      PieChart(Data = a, VAR = IMGCOLL2)
    })

    #### Geno type 1 pie########################################################################################
    output$geno1pie <- renderPlotly({
      a <- react_df()
      PieChart(Data = a, VAR = GENO1)
    })

    #### Geno type 2 pie########################################################################################
    output$geno2pie <- renderPlotly({
      a <- react_df()
      PieChart(Data = a, VAR = GENO2)
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
