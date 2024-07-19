#' tab4_visual UI Function
#'
#' @description A shiny Module for tab 4 visualisation.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @import shiny
#' @import ggplot2
#' @importFrom plotly plotlyOutput renderPlotly ggplotly plot_ly layout
#' @importFrom magrittr %>%
#' @importFrom dplyr mutate select filter summarise group_by ungroup n
#' @importFrom tidyr complete drop_na
#' @importFrom scales breaks_pretty
#' @importFrom forcats fct_rev
mod_tab4_visual_ui <- function(id){
  ns <- NS(id)
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

#' tab4_visual Server Functions
#'
#' @noRd
mod_tab4_visual_server <- function(id, metadf, react_df){
  moduleServer(id, function(input, output, session){
    ns <- session$ns
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
            column(6, h4("Min Age at Recruitment"), plotly::plotlyOutput(NS(id, "minagebar"))),
            column(6, h4("Sample Size"), plotly::plotlyOutput(NS(id, "sizebar")))
          ),
          fluidRow(
            column(3, h4("Data Available through Repository"), plotly::plotlyOutput(NS(id, "avapie"))),
            column(3, h4("Follow-up Data Available"), plotly::plotlyOutput(NS(id, "fupie"))),
            column(3, h4("Continent"), plotly::plotlyOutput(NS(id, "contpie"))),
            column(3, h4("Country Income Level"), plotly::plotlyOutput(NS(id, "incomepie")))
          ),
          h4("Data Availability by Categories"),
          fluidRow(
            column(4, plotly::plotlyOutput(NS(id, "avacatA"))),
            column(4, plotly::plotlyOutput(NS(id, "avacatB"))),
            column(4, plotly::plotlyOutput(NS(id, "avacatC")))
          )
        )
      }
    })
    ###  Tab 4-1 Contents ######################################################
    #### Min Age at Recruitment Bar############################################################################################
    output$minagebar <- plotly::renderPlotly({
      a <- react_df()
      b <- metadf %>% dplyr::filter((STUDY %in% a$STUDY))

      df <- b %>%
        dplyr::mutate(MINAGECat = cut(MINAGE,
                                      c(0, 25, 45, 70, 85, 100),
                                      right = FALSE,
                                      labels = c("15-24", "25-44", "45-69", "70-84", ">=85"))) %>%
        dplyr::group_by(MINAGECat, STUDY) %>%
        dplyr::summarize(Count = dplyr::n(), .groups = "keep") %>%
        dplyr::ungroup() %>%
        dplyr::group_by(MINAGECat) %>%
        dplyr::summarize(Count = sum(Count), Study = paste(unique(STUDY), collapse = "\n"), .groups = "keep") %>%
        dplyr::ungroup() %>%
        tidyr::complete(MINAGECat, fill = list(Count = 0, Study = NA_character_))


      p <- ggplot2::ggplot(df, aes(x = MINAGECat, y = Count, fill = MINAGECat, text = paste("Count: ", Count, "<br>Study: ", Study))) +
        ggplot2::geom_bar(stat = "identity") +
        ggplot2::scale_y_continuous(breaks = scales::breaks_pretty()) +
        ggplot2::scale_fill_brewer(palette = "Pastel1") +
        ggplot2::theme(
          axis.title.x = element_blank(),
          axis.title.y = element_blank(),
          legend.position = "none"
        )

      plotly::ggplotly(p, tooltip = c("text"))
    })

    #### Sample Size Bar############################################################################################
    output$sizebar <- plotly::renderPlotly({
      a <- react_df()
      b <- metadf %>% dplyr::filter((STUDY %in% a$STUDY))

      df <- b %>%
        dplyr::mutate(SIZEcat = cut(STUDYSIZE,
                                    c(0, 500, 1000, 2000, 3000, 4000, 5000),
                                    right = FALSE,
                                    labels = c("<500", "500-999", "1000-1999", "2000-2999", "3000-3999", "4000-4999"))) %>%
        dplyr::group_by(SIZEcat, STUDY) %>%
        dplyr::summarize(Count = dplyr::n(), .groups = "keep") %>%
        dplyr::ungroup() %>%
        dplyr::group_by(SIZEcat) %>%
        dplyr::summarize(Count = sum(Count), Study = paste(unique(STUDY), collapse = "\n"), .groups = "keep") %>%
        dplyr::ungroup() %>%
        tidyr::complete(SIZEcat, fill = list(Count = 0, Study = NA_character_))


      p <- ggplot2::ggplot(df, aes(x = SIZEcat, y = Count, fill = SIZEcat, text = paste("Count: ", Count, "<br>Study: ", Study))) +
        ggplot2::geom_bar(stat = "identity") +
        ggplot2::scale_y_continuous(breaks = scales::breaks_pretty()) +
        ggplot2::scale_fill_brewer(palette = "Pastel1") +
        ggplot2::theme(
          axis.title.x = element_blank(),
          axis.title.y = element_blank(),
          legend.position = "none"
        )

      plotly::ggplotly(p, tooltip = c("text"))
    })

    #### Data Available through Repository Pie############################################################################################
    output$avapie <- plotly::renderPlotly({
      a <- react_df()
      b <- metadf %>% dplyr::filter((STUDY %in% a$STUDY))
      plotly_pie(data = b, var = ACCESS)
    })

    #### Follow-up Data Available Pie############################################################################################
    output$fupie <- plotly::renderPlotly({
      a <- react_df()
      b <- metadf %>% dplyr::filter((STUDY %in% a$STUDY))
      plotly_pie(data = b, var = STUDYFOLLOW)
    })

    #### Continent Pie############################################################################################
    output$contpie <- plotly::renderPlotly({
      a <- react_df()
      b <- metadf %>% dplyr::filter((STUDY %in% a$STUDY))
      plotly_pie(data = b, var = CONTINENT)
    })
    #### Country Income Level Pie############################################################################################
    output$incomepie <- plotly::renderPlotly({
      a <- react_df()
      b <- metadf %>% dplyr::filter((STUDY %in% a$STUDY))
      plotly_pie(data = b, var = INCOMEGROUP)
    })

    #### Data Availability by Categories####################################################################################
    output$avacatA <- plotly::renderPlotly({
      a <- react_df()
      b <- metadf %>% dplyr::filter((STUDY %in% a$STUDY))

      df1 <- countfactor(b, cat01, "Administration")
      df2 <- countfactor(b, cat02, "Demographics")
      df3 <- countfactor(b, cat03, "Medical History")
      df4 <- countfactor(b, cat04, "Family Disease History")
      df5 <- countfactor(b, cat05, "Service Utilisation")

      df <- rbind(df1, df2, df3, df4, df5) %>%
        dplyr::mutate(var_label = as.factor(var_label)) %>%
        dplyr::mutate(var_label = forcats::fct_rev(var_label))

      plotly_bar_multifct(df)
    })

    output$avacatB <- plotly::renderPlotly({
      a <- react_df()
      b <- metadf %>% dplyr::filter((STUDY %in% a$STUDY))

      df1 <- countfactor(b, cat06, "Hospital Data")
      df2 <- countfactor(b, cat07, "Survey Data")
      df3 <- countfactor(b, cat08, "Linkage Data")
      df4 <- countfactor(b, cat09, "Imaging Data")
      df5 <- countfactor(b, cat10, "Genomic Data")

      df <- rbind(df1, df2, df3, df4, df5) %>%
        dplyr::mutate(var_label = as.factor(var_label)) %>%
        dplyr::mutate(var_label = forcats::fct_rev(var_label))

      plotly_bar_multifct(df)
    })

    output$avacatC <- plotly::renderPlotly({
      a <- react_df()
      b <- metadf %>% dplyr::filter((STUDY %in% a$STUDY))

      df1 <- countfactor(b, cat11, "OtherA")
      df2 <- countfactor(b, cat12, "OtherB")
      df3 <- countfactor(b, cat13, "OtherC")
      df4 <- countfactor(b, cat14, "OtherD")
      df5 <- countfactor(b, cat15, "OtherE")

      df <- rbind(df1, df2, df3, df4, df5) %>%
        dplyr::mutate(var_label = as.factor(var_label)) %>%
        dplyr::mutate(var_label = forcats::fct_rev(var_label))

      plotly_bar_multifct(df)
    })

    ## Tab 4-2 Demographics ####################################################
    ###  Tab 4-2 Layout ########################################################
    output$tab4dem <- renderUI({
      if (nrow(react_df()) == 0) {
        h2("Please update the your filter selection.")
      } else {
        fluidPage(
          fluidRow(
            column(6, h4("Age Group by Sex"), plotly::plotlyOutput(NS(id, "agebygender"))),
            column(6, h4("Ethnic Background"), plotly::plotlyOutput(NS(id, "ethpie")))
          ),
          fluidRow(
            column(3, h4("Sex"), plotly::plotlyOutput(NS(id, "sexpie"))),
            column(3, h4("High School Educated"), plotly::plotlyOutput(NS(id, "edupie"))),
            column(3, h4("Married/De-facto"), plotly::plotlyOutput(NS(id, "marrypie"))),
            column(3, h4("Deceased"), plotly::plotlyOutput(NS(id, "deathpie")))
          )
        )
      }
    })
    ###  Tab 4-2 Contents ######################################################
    #### Age Group by Sex########################################################################################
    output$agebygender <- plotly::renderPlotly({
      a <- react_df() %>%
        dplyr::mutate(AgeCat = cut(AGEATASS,
                            c(0, 20, 30, 40, 53, 60, 70, 80, 90, 100, 200),
                            right = FALSE,
                            c("<20", "20-29", "30-39", "40-49", "50-59", "60-69", "70-79", "80-89", "90-99", "100+")
        )) %>%
        dplyr::group_by(SEX) %>%
        count(AgeCat, name = "Count", .drop = FALSE)

      p <- ggplot2::ggplot(a, aes(x = AgeCat, y = Count, fill = SEX, text = paste("Count: ", Count, "<br>Sex: ", SEX))) +
        ggplot2::geom_bar(stat = "identity", position = "dodge") +
        ggplot2::scale_y_continuous(breaks = scales::breaks_pretty()) +
        ggplot2::scale_fill_brewer(palette = "Pastel1") +
        ggplot2::theme(
          axis.title.x = element_blank(),
          axis.title.y = element_blank()
        )

      plotly::ggplotly(p, tooltip = c("text")) %>%
        plotly::layout(legend = list(title = "", orientation = "h"))
    })


    #### Ethnic Background Pie########################################################################################
    output$ethpie <- plotly::renderPlotly({
      a <- react_df()
      plotly_pie(data = a, var = ETHNICBACK)
    })
    #### Sex Pie########################################################################################
    output$sexpie <- plotly::renderPlotly({
      a <- react_df()
      plotly_pie(data = a, var = SEX)
    })
    #### High School Educated Pie########################################################################################
    output$edupie <- plotly::renderPlotly({
      a <- react_df()
      plotly_pie(data = a, var = EDUHIGHS)
    })
    #### Married/De-facto Pie########################################################################################
    output$marrypie <- plotly::renderPlotly({
      a <- react_df()
      plotly_pie(data = a, var = MARISTAT)
    })
    #### Deceased Pie########################################################################################
    output$deathpie <- plotly::renderPlotly({
      a <- react_df()
      plotly_pie(data = a, var = DECEASED)
    })

    ## Tab 4-3 Lifestyle #######################################################
    ###  Tab 4-3 Layout ########################################################
    output$tab4life <- renderUI({
      if (nrow(react_df()) == 0) {
        h2("Please update the your filter selection.")
      } else {
        fluidPage(
          fluidRow(
            column(3, h4("Smoking Status"), plotly::plotlyOutput(NS(id, "smkpie"))),
            column(3, h4("Alcohol Use Status"), plotly::plotlyOutput(NS(id, "alcpie"))),
            column(6, h4("BMI by Sex"), plotly::plotlyOutput(NS(id, "bmihis")))
          )
        )
      }
    })
    ###  Tab 4-3 Contents ######################################################
    #### Smoking Status Pie########################################################################################
    output$smkpie <- plotly::renderPlotly({
      a <- react_df()
      plotly_pie(data = a, var = SMOKESTAT)
    })
    #### Alcohol Use Status Pie########################################################################################
    output$alcpie <- plotly::renderPlotly({
      a <- react_df()
      plotly_pie(data = a, var = ALCSTAT)
    })
    #### BMI by Sex Histogram########################################################################################
    output$bmihis <- plotly::renderPlotly({
      a <- react_df() %>% dplyr::mutate(BMI = round(BMI))
      plotly_histogram_grouped(a, var = "BMI", groupvar = "SEX", varlabel = "BMI", grouplabel = "Sex")
    })
    ## Tab 4-4 Scales ##########################################################
    ###  Tab 4-4 Layout ########################################################
    output$tab4scale <- renderUI({
      if (nrow(react_df()) == 0) {
        h2("Please update the your filter selection.")
      } else {
        fluidPage(
          fluidRow(
            column(6, h4("Scale 1 by Diagnosis 1"), plotly::plotlyOutput(NS(id, "s1his"))),
            column(6, h4("Scale 2 by Alcohol Use Status"), plotly::plotlyOutput(NS(id, "s2his")))
          ),
          fluidRow(
            column(6, h4("Scale 3 by Hospital Inpatient"), plotly::plotlyOutput(NS(id, "s3his"))),
            column(6, h4("Scale 4 by Geno1"), plotly::plotlyOutput(NS(id, "s4his")))
          )
        )
      }
    })
    ###  Tab 4-4 Contents ######################################################
    #### Scale 1 by Diagnosis 1 Histogram########################################################################################
    output$s1his <- plotly::renderPlotly({
      a <- react_df()
      plotly_histogram_grouped(a, var = "SCALE1", groupvar = "DIA1", varlabel = "Scale 1", grouplabel = "Disease Diagnosis 1")

    })
    #### Scale 2 by ALCSTAT Histogram########################################################################################
    output$s2his <- plotly::renderPlotly({
      a <- react_df()
      plotly_histogram_grouped(a, var = "SCALE2", groupvar = "ALCSTAT", varlabel = "Scale 2", grouplabel = "Alcohol Use Status")

    })
    #### Scale 3 by Hospital Inpatient Histogram########################################################################################
    output$s3his <- plotly::renderPlotly({
      a <- react_df()
      plotly_histogram_grouped(a, var = "SCALE3", groupvar = "HOSINP", varlabel = "Scale 3", grouplabel = "Hospital Inpatient")
    })
    #### Scale 4 by GENO1 Histogram########################################################################################
    output$s4his <- plotly::renderPlotly({
      a <- react_df()
      plotly_histogram_grouped(a, var = "SCALE4", groupvar = "GENO1", varlabel = "Scale 4", grouplabel = "Geno type 1")
    })
    ## Tab 4-5 Health and Family History #######################################
    ###  Tab 4-5 Layout ########################################################
    output$tab4health <- renderUI({
      if (nrow(react_df()) == 0) {
        h2("Please update the your filter selection.")
      } else {
        fluidPage(
          fluidRow(
            column(4, h4("Disease Diagnoses"), plotly::plotlyOutput(NS(id, "diaall"))),
            column(4, h4("Family History of Diseases"), plotly::plotlyOutput(NS(id, "famdall"))),
            column(4, h4("Service Utilisation"), plotly::plotlyOutput(NS(id, "suall")))
          )
        )
      }
    })
    ###  Tab 4-5 Contents ######################################################
    #### Diseases Diagnosis########################################################################################
    output$diaall <- plotly::renderPlotly({
      a <- react_df()

      df1 <- countfactor(a, DIA1, "Diagnosis 1")
      df2 <- countfactor(a, DIA2, "Diagnosis 2")
      df3 <- countfactor(a, DIA3, "Diagnosis 3")
      df4 <- countfactor(a, DIA4, "Diagnosis 4")

      df <- rbind(df1, df2, df3, df4) %>%
        dplyr::mutate(var_label = as.factor(var_label)) %>%
        dplyr::mutate(var_label = fct_rev(var_label))

      plotly_bar_multifct(df)
    })

    #### Service Utilisation########################################################################################
    output$suall <- plotly::renderPlotly({
      a <- react_df()

      df1 <- countfactor(a, HOSOUP, "Hospital Outpatient")
      df2 <- countfactor(a, HOSINP, "Hospital Inpatient")
      df3 <- countfactor(a, GP, "GP")

      df <- rbind(df1, df2, df3) %>%
        dplyr::mutate(var_label = as.factor(var_label)) %>%
        dplyr::mutate(var_label = forcats::fct_rev(var_label))

      plotly_bar_multifct(df)
    })
    #### Family Diseases History########################################################################################

    output$famdall <- plotly::renderPlotly({
      a <- react_df()

      df1 <- countfactor(a, FAMDIA1, "Diagnosis 1")
      df2 <- countfactor(a, FAMDIA2, "Diagnosis 2")
      df3 <- countfactor(a, FAMDIA3, "Diagnosis 3")


      df <- rbind(df1, df2, df3) %>%
        dplyr::mutate(var_label = as.factor(var_label)) %>%
        dplyr::mutate(var_label = forcats::fct_rev(var_label))

      plotly_bar_multifct(df)
    })
    ## Tab 4-6 Imaging and Genomic Data ########################################
    ###  Tab 4-6 Layout ########################################################
    output$tab4imgeno <- renderUI({
      if (nrow(react_df()) == 0) {
        h2("Please update the your filter selection.")
      } else {
        fluidPage(
          fluidRow(
            column(4, h4("MRI Collected"), plotly::plotlyOutput(NS(id, "mripie"))),
            column(4, h4("Imaging 1 Collected"), plotly::plotlyOutput(NS(id, "img1pie"))),
            column(4, h4("Imaging 2 Collected"), plotly::plotlyOutput(NS(id, "img2pie")))
          ),
          fluidRow(
            column(4, h4("Geno type 1"), plotly::plotlyOutput(NS(id, "geno1pie"))),
            column(4, h4("Geno type 2"), plotly::plotlyOutput(NS(id, "geno2pie")))
          )
        )
      }
    })
    ###  Tab 4-6 Contents ######################################################
    #### MRIpie########################################################################################
    output$mripie <- plotly::renderPlotly({
      a <- react_df()
      plotly_pie(data = a, var = MRICOLL)
    })

    #### IMG1pie########################################################################################
    output$img1pie <- plotly::renderPlotly({
      a <- react_df()
      plotly_pie(data = a, var = IMGCOLL1)
    })

    #### IMG2pie########################################################################################
    output$img2pie <- plotly::renderPlotly({
      a <- react_df()
      plotly_pie(data = a, var = IMGCOLL2)
    })

    #### Geno type 1 pie########################################################################################
    output$geno1pie <- plotly::renderPlotly({
      a <- react_df()
      plotly_pie(data = a, var = GENO1)
    })

    #### Geno type 2 pie########################################################################################
    output$geno2pie <- plotly::renderPlotly({
      a <- react_df()
      plotly_pie(data = a, var = GENO2)
    })

  })
}

## To be copied in the UI
# mod_tab4_visual_ui("tab4_visual_1")

## To be copied in the server
# mod_tab4_visual_server("tab4_visual_1", metadf = studymeta, react_df = filteredppt)

#' tab4_visual module app
#'
#' @export
#'
#' @noRd
mod_tab4_visual_app <- function() {
  ui <- fluidPage(
    fluidRow(
      mod_tab3_filter_ui("tab3_filter_0", metadf = studymeta, pptdf = ppt_all_fc)
    ),
    fluidRow(
      mod_tab4_visual_ui("tab4_visual_0")
    )
  )

  server <- function(input, output, session) {
    mod_tab3_filter_server("tab3_filter_0", metadf = studymeta, pptdf = ppt_all_fc, infodf = VAR_info)
    filteredppt <- mod_tab3_filter_server("tab3_filter_0", metadf = studymeta, pptdf = ppt_all_fc, infodf = VAR_info)
    mod_tab4_visual_server("tab4_visual_0", metadf = studymeta, react_df = filteredppt)
  }

  shinyApp(ui, server)
}
