#' tab3_filter UI Function
#'
#' @description A shiny Module for tab 3 applying filters and filter report .
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @rawNamespace import(shiny, except=c(dataTableOutput, renderDataTable))
#' @importFrom shinyjs useShinyjs reset
#' @importFrom shinyWidgets pickerInput
#' @importFrom DT DTOutput renderDT datatable
#' @importFrom dplyr filter select arrange
#' @importFrom magrittr %>%
#' @importFrom purrr map map2 reduce2 set_names
#' @importFrom useful compare.list
mod_tab3_filter_ui <- function(id, metadf, pptdf) {
  ns <- NS(id)
  tagList(
    shinyjs::useShinyjs(), # Java Script for reset
    div(
      id = NS(id, "allfilters"),
      htmlOutput(NS(id, "tab3statement")),
      fluidRow( # Reset Button for all filters
        column(1,
          offset = 10, align = "right",
          div(
            style = "margin-bottom: 20px;",
            actionButton(
              inputId = NS(id, "resetallf"), # Reset All Filters
              label = "Clear All Filters",
              icon = icon("fas fa-sync")
            )
          )
        )
      ),
      tabsetPanel(
        id = NS(id, "filtertabs"),
        type = "tabs",
        tabPanel(
          "Study Filters", ## Start of Study Filters Tab #####################################
          div(
            id = NS(id, "sfilters"),
            fluidRow(br()),
            fluidRow(
              column(1,
                offset = 10, align = "right",
                div(
                  style = "margin-bottom: 20px;",
                  actionButton(
                    inputId = NS(id, "resetsf"), # Reset Study Filters
                    label = "Clear Study Filters",
                    icon = icon("fas fa-sync")
                  )
                )
              )
            ),
            wellPanel( #### Study Metadata #####################################
              h3("Study metadata"),
              fluidRow( # study name and continent
                column(6, wellPanel(
                  shinyWidgets::pickerInput(
                    inputId = NS(id, "study"),
                    label = "Studies Selected",
                    choices = list(
                      "Africa"        = as.character(metadf$STUDY[metadf$CONTINENT == "Africa"]),
                      "Asia"          = as.character(metadf$STUDY[metadf$CONTINENT == "Asia"]),
                      "Europe"        = as.character(metadf$STUDY[metadf$CONTINENT == "Europe"]),
                      "North America" = as.character(metadf$STUDY[metadf$CONTINENT == "North America"]),
                      "Oceania"       = as.character(metadf$STUDY[metadf$CONTINENT == "Oceania"]),
                      "South America" = as.character(metadf$STUDY[metadf$CONTINENT == "South America"])
                    ),
                    selected = as.character(metadf$STUDY),
                    multiple = TRUE,
                    options = list(
                      `actions-box` = TRUE,
                      `selected-text-format` = "count > 3",
                      `count-selected-text` = "{0} Studies selected",
                      `none-selected-text` = "Select Studies",
                      `live-search` = TRUE,
                      `select-all` = TRUE,
                      `deselect-all` = TRUE
                    )
                  )
                )),
                column(6, wellPanel(
                  shinyWidgets::pickerInput(
                    inputId = NS(id, "continent"),
                    label = "Continent Selected",
                    choices = levels(metadf$CONTINENT),
                    selected = levels(metadf$CONTINENT),
                    multiple = TRUE,
                    options = list(
                      `actions-box` = TRUE,
                      `select-all` = TRUE,
                      `deselect-all` = TRUE
                    )
                  )
                )),
              ),
              fluidRow( # min age and sample size
                column(6, wellPanel(
                  sliderInput(
                    inputId = NS(id, "minage"),
                    label = "Min Age at Recruitment",
                    min = 0, max = 110,
                    value = c(0, 110),
                    step = 5
                  )
                )),
                column(6, wellPanel(
                  sliderInput(
                    inputId = NS(id, "studysize"),
                    label = "Sample Size",
                    min = 500, max = 5000,
                    value = c(500, 5000),
                    step = 50
                  )
                ))
              ),
              fluidRow( # data access, follow up, country income level
                column(4, yn_inputs(NS(id, "access"), "Data Available Through Repository")),
                column(4, yn_inputs(NS(id, "studyfollow"), "Follow-up Data Available")),
                column(4, fct_inputs(
                  NS(id, "incomegroup"), "Country Income Level",
                  metadf, "INCOMEGROUP"
                ))
              )
            ),
            wellPanel( #### Data Availability  #####################################
              h3("Data Availability by Categories"),
              fluidRow(
                column(3, yn_inputs(NS(id, "cat01"), "Administration")),
                column(3, yn_inputs(NS(id, "cat02"), "Demographics")),
                column(3, yn_inputs(NS(id, "cat03"), "Medical History")),
                column(3, yn_inputs(NS(id, "cat04"), "Family History of Diseases"))
              ),
              fluidRow(
                column(3, yn_inputs(NS(id, "cat05"), "Service Utilisation")),
                column(3, yn_inputs(NS(id, "cat06"), "Hospital Data")),
                column(3, yn_inputs(NS(id, "cat07"), "Survey Data")),
                column(3, yn_inputs(NS(id, "cat08"), "Linkage Data"))
              ),
              fluidRow(
                column(3, yn_inputs(NS(id, "cat09"), "Imaging Data")),
                column(3, yn_inputs(NS(id, "cat10"), "Genomic Data")),
                column(3, yn_inputs(NS(id, "cat11"), "OtherA")),
                column(3, yn_inputs(NS(id, "cat12"), "OtherB"))
              ),
              fluidRow(
                column(3, yn_inputs(NS(id, "cat13"), "OtherC")),
                column(3, yn_inputs(NS(id, "cat14"), "OtherD")),
                column(3, yn_inputs(NS(id, "cat15"), "OtherE"))
              )
            )
          )
        ), ## End of Study Filters Tab###############################
        tabPanel(
          "Participant Filters", ## Start of Participant Filters Tab ###############################
          div(
            id = NS(id, "pfilters"),
            fluidRow(br()),
            fluidRow( #### Reset buttons#####################################
              column(1,
                offset = 10, align = "right",
                div(
                  style = "margin-bottom: 20px;",
                  actionButton(
                    inputId = NS(id, "resetpf"), # Reset Participant Filters
                    label = "Clear Participant Filters",
                    icon = icon("fas fa-sync")
                  )
                )
              )
            ),
            wellPanel( #### Demographics#######################
              h3("Demographics"),
              fluidRow(
                column(3, fct_inputs(NS(id, "ethnicback"), "Ethnic Background", pptdf, "ETHNICBACK")),
                column(3, fct_inputs(NS(id, "sex"), "Sex", pptdf, "SEX" )),
                column(3, ynm_inputs(NS(id, "eduhighs"), "High School Educated")),
                column(3, ynm_inputs(NS(id, "maristat"), "Married/De-facto"))
              ),
              fluidRow(
                column(
                  6,
                  wellPanel(
                    sliderInput(NS(id, "ageatass"), "Age at Assessment", min = 0, max = 110, value = c(0, 110), step = 5),
                    checkboxInput(NS(id, "agemiss"), "Include Missing", value = TRUE)
                  )
                ),
                column(
                  6,
                  wellPanel(
                    checkboxGroupInput(NS(id, "deceased"), "Deceased", inline = TRUE, choices = c("No", "Yes", "Missing"), selected = c("No", "Yes", "Missing")),
                    sliderInput(NS(id, "yod"), "Year of Death", min = 1990, max = 2030, value = c(1990, 2030)),
                    checkboxInput(NS(id, "yodmiss"), "Include Missing (Year of Death)", value = TRUE)
                  )
                )
              )
            ),
            wellPanel( #### Lifestyle ############################################
              h3("Lifestyle"),
              fluidRow(
                column(3, fct_inputs(NS(id, "smokestat"), "Smoking Status", pptdf, "SMOKESTAT")),
                column(3, fct_inputs(NS(id, "alcstat"), "Alcohol Use Status", pptdf, "ALCSTAT")),
                column(
                  6,
                  wellPanel(
                    sliderInput(NS(id, "bmi"), "BMI", min = 10, max = 40, value = c(10, 40)),
                    checkboxInput(NS(id, "bmimiss"), "Include Missing", value = TRUE)
                  )
                )
              )
            ),
            wellPanel( #### Scales ############################################
              h3("Scales"),
              fluidRow(
                column(
                  3,
                  wellPanel(
                    sliderInput(NS(id, "scale1"), "Scale 1", min = 20, max = 40, value = c(20, 40)),
                    checkboxInput(NS(id, "s1miss"), "Include Missing", value = TRUE)
                  )
                ),
                column(
                  3,
                  wellPanel(
                    sliderInput(NS(id, "scale2"), "Scale 2", min = 10, max = 25, value = c(10, 25)),
                    checkboxInput(NS(id, "s2miss"), "Include Missing", value = TRUE)
                  )
                ),
                column(
                  3,
                  wellPanel(
                    sliderInput(NS(id, "scale3"), "Scale 3", min = 0, max = 25, value = c(0, 25)),
                    checkboxInput(NS(id, "s3miss"), "Include Missing", value = TRUE)
                  )
                ),
                column(
                  3,
                  wellPanel(
                    sliderInput(NS(id, "scale4"), "Scale 4", min = 1, max = 100, value = c(1, 100)),
                    checkboxInput(NS(id, "s4miss"), "Include Missing", value = TRUE)
                  )
                )
              )
            ),
            wellPanel( #### Disease Diagnoses  ############################################
              h3("Disease Diagnoses"),
              fluidRow(
                column(3, ynm_inputs(NS(id, "dia1"), "Diagnosis 1")),
                column(3, ynm_inputs(NS(id, "dia2"), "Diagnosis 2")),
                column(3, ynm_inputs(NS(id, "dia3"), "Diagnosis 3")),
                column(3, ynm_inputs(NS(id, "dia4"), "Diagnosis 4"))
              )
            ),
            wellPanel( #### Service Utilisation  ############################################
              h3("Service Utilisation"),
              fluidRow(
                column(3, ynm_inputs(NS(id, "hosoup"), "Hospital Outpatient")),
                column(3, ynm_inputs(NS(id, "hosinp"), "Hospital Inpatient")),
                column(3, ynm_inputs(NS(id, "gp"), "GP"))
              )
            ),
            wellPanel( #### Family Diseases History  ############################################
              h3("Family History of Diseases"),
              fluidRow(
                column(3, ynm_inputs(NS(id, "famdia1"), "Family History of Diagnosis 1")),
                column(3, ynm_inputs(NS(id, "famdia2"), "Family History of Diagnosis 2")),
                column(3, ynm_inputs(NS(id, "famdia3"), "Family History of Diagnosis 3"))
              )
            ),
            wellPanel( #### Imaging Data  ############################################
              h3("Imaging Data"),
              fluidRow(
                column(3, yn_inputs(NS(id, "mricoll"), "MRI Collected")),
                column(3, yn_inputs(NS(id, "imgcoll1"), "Imaging 1 Collected")),
                column(3, yn_inputs(NS(id, "imgcoll2"), "Imaging 1 Collected"))
              )
            ),
            wellPanel( #### Genomics Data  ############################################
              h3("Genomic Data"),
              fluidRow(
                column(
                  4,
                  wellPanel(checkboxGroupInput(NS(id, "geno1"), "Geno type 1",
                    inline = TRUE,
                    choices = levels(pptdf$GENO1),
                    selected = levels(pptdf$GENO1)
                  ))
                ),
                column(
                  6,
                  wellPanel(checkboxGroupInput(NS(id, "geno2"), "Geno type 2",
                    inline = TRUE,
                    choices = levels(pptdf$GENO2),
                    selected = levels(pptdf$GENO2)
                  ))
                )
              )
            )
          )
        ), ## End of Participant Filters Tab###############################
        tabPanel(
          "Filters Report", ## Start of Filters Report Tab#######################
          h4("The filters you have applied include:"),
          wellPanel(fluidRow(DT::DTOutput(NS(id, "filter_sel")))),
          h4("The studies you have identified include:"),
          wellPanel(fluidRow(DT::DTOutput(NS(id, "filtered_study")))),
          h4("The data availability by categories of the studies you have identified:"),
          wellPanel(fluidRow(DT::DTOutput(NS(id, "filtered_ava"))))
        ) ## End of Filters Report Tab#######################
      )
    )
  )
}


#' tab3_filter Server Functions
#'
#' @noRd
mod_tab3_filter_server <- function(id, metadf, pptdf, infodf) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns
    # DT table option for Summary Tables Tab
    dtoptions2 <- list(
      searching = FALSE,
      scrollX = TRUE,
      dom = 'Bfrtip',
      buttons = list('pageLength',
                     list(
                       extend = 'colvis',
                       columns = ":gt(0)"),
                     'colvisRestore',
                     list(
                       extend = 'csv',
                       title = 'Metadata'
                     ),
                     'copy',
                     'print')
    )

    # Check Reset Buttons ######################################################
    # Reset All Filters
    observeEvent(input$resetallf, {
      shinyjs::reset("allfilters")
    })
    # Reset study Filters
    observeEvent(input$resetsf, {
      shinyjs::reset("sfilters")
    })
    # Reset Participant Filters
    observeEvent(input$resetpf, {
      shinyjs::reset("pfilters")
    })

    # Applying Filters #########################################################
    # Filtered metadf (study filters)
    filtered_metadf <- reactive({
      if (is.null(input$filtertabs)) { # Check if the filter tab was not clicked
        f_metadf <- metadf
      } else {

        # First, apply selected Study Filters
        if (is.null(input$study)){
          temp1 <- metadf # if none study selected - considered as no filter applied
        } else {
          temp1 <- metadf %>%
            dplyr::filter(STUDY %in% input$study)
        }

        # Second, apply filters for factor variables of metadata
        # All factor variables of metadata
        meta_fct_col <- names(Filter(is.factor, metadf)) # 'Filter' - this is the {base} function
        meta_fct_col[!meta_fct_col == "COUNTRY"] # Country was not used as a filter
        # List the input values for factor variable filters
        meta_fct_filter_ls <- purrr::map(tolower(meta_fct_col), ~ input[[.x]])

        temp_metadf <- purrr::reduce2(meta_fct_col,
                                      meta_fct_filter_ls,
                                      apply_factor_filter,
                                      .init = temp1
        ) # Applying the factor filters based on inputs

        # Applying other filters of metadata
        f_metadf <- temp_metadf %>%
          dplyr::filter(MINAGE >= input$minage[1] & MINAGE <= input$minage[2]) %>%
          dplyr::filter(STUDYSIZE >= input$studysize[1] & STUDYSIZE <= input$studysize[2])
      }
      f_metadf
    })
    # Filtered pptdf (Participant Filters)
    filtered_pptdf <- reactive({
      if (is.null(input$filtertabs)) {
        f_pptdf <- pptdf
      } else {
        # Applying factor Participant filters
        # All factors of Participant filters
        ppt_fct_col <- names(Filter(is.factor, pptdf)) # 'Filter' - this is the {base} function
        # List the input values for factor variable filters
        ppt_fct_filter_ls <- purrr::map(tolower(ppt_fct_col), ~ input[[.x]])
        # Using the reduce2 to apply filters
        temp_pptdf <- purrr::reduce2(ppt_fct_col,
                                     ppt_fct_filter_ls,
                                     apply_factor_filter,
                                     .init = pptdf
        )

        # Applying Numeric Filters
        # All numeric Participant filters
        ppt_num_col <- names(Filter(is.numeric, pptdf))
        # List the input values for numeric Participant filters
        range_ls <- purrr::map(tolower(ppt_num_col), ~ input[[.x]])
        missv_ls <- purrr::map(purrr::set_names(grep("miss", names(input), value = TRUE)), ~ input[[.x]])
        combined_list <- purrr::map2(range_ls, missv_ls, ~ list(.x, .y))

        f_pptdf <- purrr::reduce2(ppt_num_col,
                                  combined_list,
                                  apply_slide_filter,
                                  .init = temp_pptdf
        )
      }
      f_pptdf
    })
    # filtered results Combined filters from both tab
    filtered_all <- reactive({
      if (is.null(input$filtertabs)) {
        f_df <- pptdf
      } else {
        f_study <- filtered_metadf()
        f_df <- filtered_pptdf() %>%
          filter(STUDY %in% f_study$STUDY)
      }
      f_df
    })

    # Tab Contents #############################################################
    # Statement
    output$tab3statement <- renderUI({
      a <- paste(nrow(filtered_metadf()), "/", nrow(metadf)) # filtered studies
      b <- paste(nrow(filtered_pptdf()), "/", nrow(pptdf)) # filtered participants
      c <- paste(nrow(filtered_all()), "/", nrow(pptdf)) # Applied both filters - ppt
      d <- paste(length(unique(filtered_all()$STUDY)), "/", nrow(metadf)) # Applied both filters - studies
      statement <- paste('<br>','<br>',
                         "Based on the filters you applied on the Study Filters sub-tab,",
                         "you have found ", a, "studies.", '<br>','<br>',
                         "Based on the filters you applied on the Participant Filters sub-tab,",
                         "you have found ", b, "participants.", '<br>','<br>',
                         "Based on the filters you applied on the both sub-tabs,",
                         "you have found ", c, "participants from", d, 'studies.',
                         sep = " ")

      fluidPage(
        h2('The Filters Tab provides filter functions to identify studies and participants that meet your research interests.'),
        h3('The Study Filters sub-tab includes some common metadata, and data availability by categories.'),
        h3('The Participant Filters sub-tab includes some harmonised commonly used variables.'),
        h3('The Filters Report sub-tab provides a report of the filters you have selected, the identified studies,
     and can be downloaded for future reference.'),
        h4(HTML(statement))
      )
    })
    # Filters selected

    output$filter_sel <- DT::renderDT({

      # Prepare the data

      # All factor variables of metadata
      meta_fct_col <- names(Filter(is.factor, metadf))
      meta_fct_col <- meta_fct_col[!meta_fct_col == "COUNTRY"]

      # All factor variables of Participant
      ppt_fct_col <- names(Filter(is.factor, pptdf))

      # List the input values for ALL factor variable filters
      all_fct_col <- c(meta_fct_col, ppt_fct_col)
      all_fct_inputs <- purrr::map(tolower(all_fct_col), ~ input[[.x]]) # retrieve the corresponding factor inputs
      all_fct_inputs_str <- sapply(all_fct_inputs, paste, collapse = ",") # convert to a string


      # List the default range for ALL factor variable filters
      meta_fct_filter_range <- purrr::map(meta_fct_col, ~ levels(metadf[[.x]]))
      ppt_fct_filter_range <- purrr::map(ppt_fct_col, ~ levels(pptdf[[.x]]))
      all_fct_range <- c(meta_fct_filter_range, ppt_fct_filter_range)
      all_fct_range_str <- sapply(all_fct_range, paste, collapse = ",")


      # All Numeric variables of metadata
      meta_num_col <- names(Filter(is.numeric, metadf))
      # All Numeric variables of Participant
      ppt_num_col <- names(Filter(is.numeric, pptdf))
      # List the input values for ALL factor variable filters
      all_num_col <- c(meta_num_col, ppt_num_col)
      all_num_inputs <- purrr::map(tolower(all_num_col), ~ unlist(input[[.x]])) # retrieve the corresponding numeric inputs
      all_num_inputs_str <- sapply(all_num_inputs, paste, collapse = "-")
      # List the default range for ALL numeric variable filters
      all_num_range_str <- c(
        '0-110', # Min Age at Recruitment
        '500-5000', # Sample Size
        '0-110', # Age at Assessment
        '1990-2030', # Year of Death
        '10-40', # BMI
        '20-40', # Scale 1
        '10-25', # Scale 2
        '0-25', # Scale 3
        '1-100' # Scale 4
      )

      # Input values of Filters for include missing values
      ppt_inclumiss <- grep("miss", names(input), value = TRUE)
      ppt_inclumiss_input <- purrr::map(purrr::set_names(grep("miss", names(input), value = TRUE)),
                                        ~ input[[.x]])

      ppt_inclumiss_input <- toupper(ppt_inclumiss_input)
      # Default values
      ppt_inclumiss_range <- toupper(rep(TRUE, 7))


      df <- data.frame(VARNAME = 1:57)

      df$VARNAME <- c(all_fct_col, all_num_col,toupper(ppt_inclumiss))
      df$InputValue <- c(all_fct_inputs_str, all_num_inputs_str, ppt_inclumiss_input)
      df$DefaultV <- c(all_fct_range_str, all_num_range_str, ppt_inclumiss_range)

      df$compare <- useful::compare.list(df$InputValue, df$DefaultV)

      crsinput <- paste(input$study, collapse = ',')
      studydf <- data.frame(VARNAME = 'STUDY',
                            InputValue = crsinput,
                            DefaultV = 'All 30 studies',
                            compare = (length(input$study) == 30))

      filterdf <- rbind.data.frame(studydf, df)

      dfx <- merge(infodf, filterdf, by = 'VARNAME') %>%
        dplyr::filter(compare == FALSE & InputValue!='') %>%
        dplyr::select(LABELS, PM, InputValue, DefaultV)

      DT::datatable(dfx,
                    colnames = c('Filters', 'Types', 'Selected', 'Default'),
                    rownames = FALSE,
                    extensions = 'Buttons',
                    options = list(
                      searching = FALSE,
                      scrollX = TRUE,
                      dom = 'Bfrtip',
                      buttons = list('pageLength',
                                     list(
                                       extend = 'colvis',
                                       columns = ":gt(0)"),
                                     'colvisRestore',
                                     list(
                                       extend = 'csv',
                                       title = 'filter_selected'
                                     ),
                                     'copy',
                                     'print')
                    )
                    )
    })

    # Filtered Studies metadata
    output$filtered_study <- DT::renderDT({

      f_study_list <- unique(filtered_all()$STUDY) # list of filtered study

      f_study_meta <- metadf[1:9] %>% dplyr::filter(STUDY %in% f_study_list) #metadata

      var_info <- infodf %>%
        dplyr::filter(VARNAME %in% colnames(f_study_meta)) %>%
        dplyr::arrange(match(VARNAME, colnames(f_study_meta)))

      var_label <- var_info$LABEL

      DT::datatable(f_study_meta,
                    colnames = var_label,
                    rownames = FALSE,
                    extensions = 'Buttons',
                    options = list(
                      searching = FALSE,
                      scrollX = TRUE,
                      dom = 'Bfrtip',
                      buttons = list('pageLength',
                                     list(
                                       extend = 'colvis',
                                       columns = ":gt(0)"),
                                     'colvisRestore',
                                     list(
                                       extend = 'csv',
                                       title = 'metadata_filtered'
                                     ),
                                     'copy',
                                     'print')
                    )
                    )

    })

    # Filtered Studies Data availability by categories
    output$filtered_ava <- DT::renderDT({

      f_study_list <- unique(filtered_all()$STUDY) # list of filtered study

      f_study_ava <- metadf %>%
        dplyr::select(c(STUDY, cat01:cat15)) %>%
        dplyr::filter(STUDY %in% f_study_list)

      var_info <- infodf %>%
        dplyr::filter(VARNAME %in% colnames(f_study_ava)) %>%
        dplyr::arrange(match(VARNAME, colnames(f_study_ava)))

      var_label <- var_info$LABEL

      DT::datatable(f_study_ava,
                    colnames = var_label,
                    rownames = FALSE,
                    extensions = 'Buttons',
                    options = list(
                      searching = FALSE,
                      scrollX = TRUE,
                      dom = 'Bfrtip',
                      buttons = list('pageLength',
                                     list(
                                       extend = 'colvis',
                                       columns = ":gt(0)"),
                                     'colvisRestore',
                                     list(
                                       extend = 'csv',
                                       title = 'data_ava_filtered'
                                     ),
                                     'copy',
                                     'print')
                    )
                    )

    })



    return(filtered_all)
  })
}

## To be copied in the UI
# mod_tab3_filter_ui("tab3_filter_1", metadf = studymeta, pptdf = ppt_all_fc)

## To be copied in the server
# mod_tab3_filter_server("tab3_filter_1", metadf = studymeta, pptdf = ppt_all_fc, infodf = VAR_info)

#' tab3_filter module app
#'
#' @export
#'
#' @noRd
mod_tab3_filter_app <- function() {

  ui <- fluidPage(
    mod_tab3_filter_ui("tab3_filter_0", metadf = studymeta, pptdf = ppt_all_fc)
  )

  server <- function(input, output, session) {
    mod_tab3_filter_server("tab3_filter_0", metadf = studymeta, pptdf = ppt_all_fc, infodf = VAR_info)
  }

  shinyApp(ui, server)
}

