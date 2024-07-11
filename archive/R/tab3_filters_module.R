# Tab 3 Filters Module##########################################################
#DT table option 2 for Filters - Filter Report Tab with download buttons
dtoptions2 <- list(searching = FALSE, scrollX = TRUE, autoWidth = FALSE, 
                   pageLength = 10, lengthMenu = list(c(10,25,50,-1), c(10,25,50,"All")), # Options for number of rows per page, default is 10
                   initComplete = DT::JS(
                     "function(settings, json) {",
                     "$(this.api().table().header()).css({'background-color': 'black', 
                     'color': '#ffffff', 'font-size': '16px'});", #Change header colour
                     "}"),
                   dom = 'Blfrtip',# Elements to show on the table
                   buttons = c('copy', 'csv', 'excel', 'pdf', 'print')) # Add export buttons
# Functions ####################################################################
## Input functions ##########################
# Input with only No/Yes options
my_yn_inputs <- function(vname, vlabel) {
  wellPanel(
    checkboxGroupInput(
      inputId = vname,
      label = vlabel,
      choices = c("No", "Yes"),
      selected = c("No", "Yes")
    )
  )
}
# Input with only No/Yes/Missing options
my_ynm_inputs <- function(vname, vlabel) {
  wellPanel(
    checkboxGroupInput(
      inputId = vname,
      label = vlabel,
      choices = c("No", "Yes", "Missing"),
      selected = c("No", "Yes", "Missing")
    )
  )
}
# Other Factor inputs
my_fct_inputs <- function(vname, vlabel, df, dfvname) {
  wellPanel(
    checkboxGroupInput(
      inputId = vname, # input variable name
      label = vlabel, # input variable label
      choices = levels(df[[dfvname]]),
      selected = levels(df[[dfvname]])
    )
  )
}

## Functions to apply filters ##########################
# Applying factor variable filters
my_factor_filter <- function(df, col, vals) {
  if (!is.null(vals)) {
    filter(df, !!sym(col) %in% vals)
  } else {
    df
  }
}

# Applying Numeric Filters - Range
my_slide_filter <- function(df, col, vals) {
  if (!is.null(vals)) {
    values <- unlist(vals)
    if (values[3] == 1) { # include missing values
      filter(df, is.na(!!sym(col)) | !!sym(col) >= values[1] & !!sym(col) <= values[2])
    } else {
      filter(df, !!sym(col) >= values[1] & !!sym(col) <= values[2])
    }
  } else {
    df
  }
}


# Module UI ###################################################################
filters_mod_ui <- function(id, df1, df2) {
  ns <- NS("id")
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
        id = NS(id, 'filtertabs'),
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
                      "Africa"        = as.character(df1$STUDY[df1$CONTINENT == "Africa"]),
                      "Asia"          = as.character(df1$STUDY[df1$CONTINENT == "Asia"]),
                      "Europe"        = as.character(df1$STUDY[df1$CONTINENT == "Europe"]),
                      "North America" = as.character(df1$STUDY[df1$CONTINENT == "North America"]),
                      "Oceania"       = as.character(df1$STUDY[df1$CONTINENT == "Oceania"]),
                      "South America" = as.character(df1$STUDY[df1$CONTINENT == "South America"])
                    ),
                    selected = as.character(df1$STUDY),
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
                    choices = levels(df1$CONTINENT),
                    selected = levels(df1$CONTINENT),
                    multiple = TRUE,
                    options = list(
                      enable_search = TRUE,
                      non_selected_header = "Choose between:",
                      selected_header = "You have selected:"
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
                column(4, my_yn_inputs(NS(id, "access"), "Data Available Through Repository")),
                column(4, my_yn_inputs(NS(id, "studyfollow"), "Follow-up Data Available")),
                column(4, my_fct_inputs(
                  NS(id, "incomegroup"), "Country Income Level",
                  df1, "INCOMEGROUP"
                ))
              )
            ),
            wellPanel( #### Data Availability  #####################################
              h3("Data Availability by Categories"),
              fluidRow(
                column(3, my_yn_inputs(NS(id, "cat01"), "Administration")),
                column(3, my_yn_inputs(NS(id, "cat02"), "Demographics")),
                column(3, my_yn_inputs(NS(id, "cat03"), "Medical History")),
                column(3, my_yn_inputs(NS(id, "cat04"), "Family History of Diseases"))
              ),
              fluidRow(
                column(3, my_yn_inputs(NS(id, "cat05"), "Service Utilisation")),
                column(3, my_yn_inputs(NS(id, "cat06"), "Hospital Data")),
                column(3, my_yn_inputs(NS(id, "cat07"), "Survey Data")),
                column(3, my_yn_inputs(NS(id, "cat08"), "Linkage Data"))
              ),
              fluidRow(
                column(3, my_yn_inputs(NS(id, "cat09"), "Imaging Data")),
                column(3, my_yn_inputs(NS(id, "cat10"), "Genomic Data")),
                column(3, my_yn_inputs(NS(id, "cat11"), "OtherA")),
                column(3, my_yn_inputs(NS(id, "cat12"), "OtherB"))
              ),
              fluidRow(
                column(3, my_yn_inputs(NS(id, "cat13"), "OtherC")),
                column(3, my_yn_inputs(NS(id, "cat14"), "OtherD")),
                column(3, my_yn_inputs(NS(id, "cat15"), "OtherE"))
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
                column(3, my_fct_inputs(
                  NS(id, "ethnicback"), "Ethnic Background",
                  df2, "ETHNICBACK"
                )),
                column(3, my_fct_inputs(
                  NS(id, "sex"), "Sex",
                  df2, "SEX"
                )),
                column(3, my_ynm_inputs(NS(id, "eduhighs"), "High School Educated")),
                column(3, my_ynm_inputs(NS(id, "maristat"), "Married/De-facto"))
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
                column(3, my_fct_inputs(
                  NS(id, "smokestat"), "Smoking Status",
                  df2, "SMOKESTAT"
                )),
                column(3, my_fct_inputs(
                  NS(id, "alcstat"), "Alcohol Use Status",
                  df2, "ALCSTAT"
                )),
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
                column(3, my_ynm_inputs(NS(id, "dia1"), "Diagnosis 1")),
                column(3, my_ynm_inputs(NS(id, "dia2"), "Diagnosis 2")),
                column(3, my_ynm_inputs(NS(id, "dia3"), "Diagnosis 3")),
                column(3, my_ynm_inputs(NS(id, "dia4"), "Diagnosis 4"))
              )
            ),
            wellPanel( #### Service Utilisation  ############################################
              h3("Service Utilisation"),
              fluidRow(
                column(3, my_ynm_inputs(NS(id, "hosoup"), "Hospital Outpatient")),
                column(3, my_ynm_inputs(NS(id, "hosinp"), "Hospital Inpatient")),
                column(3, my_ynm_inputs(NS(id, "gp"), "GP"))
              )
            ),
            wellPanel( #### Family Diseases History  ############################################
              h3("Family History of Diseases"),
              fluidRow(
                column(3, my_ynm_inputs(NS(id, "famdia1"), "Family History of Diagnosis 1")),
                column(3, my_ynm_inputs(NS(id, "famdia2"), "Family History of Diagnosis 2")),
                column(3, my_ynm_inputs(NS(id, "famdia3"), "Family History of Diagnosis 3"))
              )
            ),
            wellPanel( #### Imaging Data  ############################################
              h3("Imaging Data"),
              fluidRow(
                column(3, my_yn_inputs(NS(id, "mricoll"), "MRI Collected")),
                column(3, my_yn_inputs(NS(id, "imgcoll1"), "Imaging 1 Collected")),
                column(3, my_yn_inputs(NS(id, "imgcoll2"), "Imaging 1 Collected"))
              )
            ),
            wellPanel( #### Genomics Data  ############################################
              h3("Genomic Data"),
              fluidRow(
                column(
                  4,
                  wellPanel(checkboxGroupInput(NS(id, "geno1"), "Geno type 1",
                    inline = TRUE,
                    choices = levels(df2$GENO1),
                    selected = levels(df2$GENO1)
                  ))
                ),
                column(
                  6,
                  wellPanel(checkboxGroupInput(NS(id, "geno2"), "Geno type 2",
                    inline = TRUE,
                    choices = levels(df2$GENO2),
                    selected = levels(df2$GENO2)
                  ))
                )
              )
            )
          )
        ), ## End of Participant Filters Tab###############################
        tabPanel(
          "Filters Report",## Start of Filters Report Tab#######################
          h4("The studies you have identified include:"),
          fluidRow(DT::dataTableOutput(NS(id, 'testcrs'))),
          wellPanel(fluidRow(DT::dataTableOutput(NS(id, "filtered_study")))),
          h4("The filters you have applied include:"),
          wellPanel(fluidRow(DT::dataTableOutput(NS(id, "filter_sel"))))
        )## End of Filters Report Tab#######################
      )
    )
  )
}

# Module Server ###############################################################
filters_mod_server <- function(id, df1, df2, df3) {
  moduleServer(id, function(input, output, session) {
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
    # Filtered df1 (study filters)
    filtered_df1 <- reactive({
      if (is.null(input$filtertabs)) { # Check if the filter tab was not clicked
        f_df1 <- df1
      } else {
        
        # First, apply selected Study Filters
        if (is.null(input$study)){
          temp1 <- df1 # if none study selected - considered as no filter applied
        } else {
          temp1 <- df1 %>%
            filter(STUDY %in% input$study)
        }
        
        # Second, apply filters for factor variables of metadata
        # All factor variables of metadata
        meta_fct_col <- names(Filter(is.factor, df1))
        meta_fct_col[!meta_fct_col == "COUNTRY"] # Country was not used as a filter
        # List the input values for factor variable filters
        meta_fct_filter_ls <- purrr::map(tolower(meta_fct_col), ~ input[[.x]])

        temp_df1 <- purrr::reduce2(meta_fct_col,
          meta_fct_filter_ls,
          my_factor_filter,
          .init = temp1
        )
        
        # Applying other filters of metadata
        f_df1 <- temp_df1 %>%
          filter(MINAGE >= input$minage[1] & MINAGE <= input$minage[2]) %>%
          filter(STUDYSIZE >= input$studysize[1] & STUDYSIZE <= input$studysize[2])
      }
      f_df1
    })
    # Filtered df2 (Participant Filters)
    filtered_df2 <- reactive({
      if (is.null(input$filtertabs)) {
        f_df2 <- df2
      } else {
        # Applying factor Participant filters
        # All factors of Participant filters
        ppt_fct_col <- names(Filter(is.factor, df2))
        # List the input values for factor variable filters
        ppt_fct_filter_ls <- purrr::map(tolower(ppt_fct_col), ~ input[[.x]])
        # Using the reduce2 to apply filters
        temp_df2 <- purrr::reduce2(ppt_fct_col,
          ppt_fct_filter_ls,
          my_factor_filter,
          .init = df2
        )

        # Applying Numeric Filters
        # All numeric Participant filters
        ppt_num_col <- names(Filter(is.numeric, df2))
        # List the input values for numeric Participant filters
        range_ls <- purrr::map(tolower(ppt_num_col), ~ input[[.x]])
        missv_ls <- purrr::map(purrr::set_names(grep("miss", names(input), value = TRUE)), ~ input[[.x]])
        combined_list <- purrr::map2(range_ls, missv_ls, ~ list(.x, .y))
        
        f_df2 <- purrr::reduce2(ppt_num_col,
          combined_list,
          my_slide_filter,
          .init = temp_df2
        )
      }
      f_df2
    })
    # filtered results Combined filters from both tab
    filtered_all <- reactive({
      if (is.null(input$filtertabs)) {
        f_df <- df2
      } else {
        f_study <- filtered_df1()
        f_df <- filtered_df2() %>%
          filter(STUDY %in% f_study$STUDY)
      }
      f_df
    })

    # Tab Contents #############################################################
    # Statement
    output$tab3statement <- renderUI({
      a <- paste(nrow(filtered_df1()), "/", nrow(df1)) # filtered studies
      b <- paste(nrow(filtered_df2()), "/", nrow(df2)) # filtered participants
      c <- paste(nrow(filtered_all()), "/", nrow(df2)) # Applied both filters - ppt
      d <- paste(length(unique(filtered_all()$STUDY)), "/", nrow(df1)) # Applied both filters - studies
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
    

    # Filtered Studies metadata
    output$filtered_study <- DT::renderDataTable({
      
      f_study_list <- unique(filtered_all()$STUDY) # list of filtered study
      
      f_study_meta <- df1[, 1:9] %>% filter(STUDY %in% f_study_list) #metadata
      
      var_info <- df3 %>%
        filter(VARNAME %in% colnames(f_study_meta)) %>%
        arrange(match(VARNAME, colnames(f_study_meta)))
      
      var_label <- var_info$LABEL
      
      DT::datatable(f_study_meta,
                    colnames = var_label,
                    rownames = FALSE, 
                    options = dtoptions2,
                    extensions = 'Buttons')
      
    })
    
    # Filters selected
    
    output$filter_sel <- DT::renderDataTable({
      
      # Prepare the data

      # All factor variables of metadata
      meta_fct_col <- names(Filter(is.factor, df1))
      meta_fct_col <- meta_fct_col[!meta_fct_col == "COUNTRY"]

      # All factor variables of Participant
      ppt_fct_col <- names(Filter(is.factor, df2))
      
      # List the input values for ALL factor variable filters
      all_fct_col <- c(meta_fct_col, ppt_fct_col)
      all_fct_inputs <- purrr::map(tolower(all_fct_col), ~ input[[.x]])
      all_fct_inputs_str <- sapply(all_fct_inputs, paste, collapse = ",")
      
      
      # List the default range for ALL factor variable filters
      meta_fct_filter_range <- purrr::map(meta_fct_col, ~ levels(df1[[.x]]))
      ppt_fct_filter_range <- purrr::map(ppt_fct_col, ~ levels(df2[[.x]]))
      all_fct_range <- c(meta_fct_filter_range, ppt_fct_filter_range)
      all_fct_range_str <- sapply(all_fct_range, paste, collapse = ",")
      
      
      # All Numeric variables of metadata
      meta_num_col <- names(Filter(is.numeric, df1))
      # All Numeric variables of Participant
      ppt_num_col <- names(Filter(is.numeric, df2))
      # List the input values for ALL factor variable filters
      all_num_col <- c(meta_num_col, ppt_num_col)
      all_num_inputs <- purrr::map(tolower(all_num_col), ~ unlist(input[[.x]]))
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
      
      dfx <- merge(df3, filterdf, by = 'VARNAME') %>%
        filter(compare == FALSE & InputValue!='') %>%
        select(LABELS, PM, InputValue, DefaultV)

      DT::datatable(dfx,
                    colnames = c('Filters', 'Types', 'Selected', 'Default'),
                    rownames = FALSE, 
                    options = dtoptions2,
                    extensions = 'Buttons')
    })
    
    return(filtered_all)
    
  })
}

## Module App ##################################################################
filter_mod_app <- function(df1, df2) {
  ui <- fluidPage(
    filters_mod_ui("filter1", df1, df2)
  )

  server <- function(input, output, session) {
    filters_mod_server("filter1", df1, df2, df3)
  }

  shinyApp(ui, server)
}
