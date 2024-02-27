# Tab 3 Filters Module##########################################################
# DT table option 2 for Filters - Filter Report Tab with download buttons
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


# Module UI ###################################################################
filters_mod_ui <- function(id, df1) {
  ns <- NS("id")
  tagList(
    shinyjs::useShinyjs(), # Java Script for reset
    htmlOutput(NS(id, "tab3statement")),
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
      wellPanel( #### Data Availability #####################################
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
      ),
      wellPanel( #### Filters Selected #####################################
                h4("The filters you have applied include:"),
                fluidRow(DT::dataTableOutput(NS(id, "filter_sel")))
      )
    ) ## End of Study Filters Tab###############################
  )
}

# Module Server ###############################################################
filters_mod_server <- function(id, df1, df3) {
  moduleServer(id, function(input, output, session) {
    # Check Reset Buttons ######################################################
    
    # Reset study Filters
    observeEvent(input$resetsf, {
      shinyjs::reset("sfilters")
    })
    
    # Applying Filters #########################################################

    filtered_df1 <- reactive({
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
      meta_fct_col <- meta_fct_col[!meta_fct_col == "COUNTRY"] # Country was not used as a filter
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
      
      f_df1
    })
    
    
    ## Output##################################################################
    # Statement
    output$tab3statement <- renderUI({
      a <- paste(nrow(filtered_df1()), "/", nrow(df1)) # filtered studies
      statement <- paste('<br>','<br>',
                         "Based on the filters you applied you have found",
                         a, "studies.",
                         sep = " ")
      
      fluidPage(
        h2('The Filters Tab provides filter functions to identify studies that meet your research interests.'),
        h3('The Filters includes some common metadata, and data availability by categories.'),
        h3('The filters you have selected are listed and can be downloaded for future reference.'),
        h4(HTML(statement))
      )
    })
    
    # Filters Selected
    output$filter_sel <- DT::renderDataTable({
      
      # Prepare the data
      # All factor variables of metadata
      meta_fct_col <- names(Filter(is.factor, df1))
      meta_fct_col <- meta_fct_col[!meta_fct_col == "COUNTRY"]
      
      # List the input values for ALL factor variable filters
      meta_fct_inputs <- purrr::map(tolower(meta_fct_col), ~ input[[.x]])
      meta_fct_inputs_str <- sapply(meta_fct_inputs, paste, collapse = ",")
      
      
      # List the default range for ALL factor variable filters
      meta_fct_filter_range <- purrr::map(meta_fct_col, ~ levels(df1[[.x]]))
      meta_fct_range_str <- sapply(meta_fct_filter_range, paste, collapse = ",")
      
      
      # All Numeric variables of metadata
      meta_num_col <- names(Filter(is.numeric, df1))
      
      # List the input values for ALL factor variable filters
      
      meta_num_inputs <- purrr::map(tolower(meta_num_col), ~ unlist(input[[.x]]))
      meta_num_inputs_str <- sapply(meta_num_inputs, paste, collapse = "-")
      # List the default range for ALL numeric variable filters
      meta_num_range_str <- c(
        '0-110', # Min Age at Recruitment
        '500-5000' # Sample Size
      )
      
      
      df <- data.frame(VARNAME = 1:21)
      
      df$VARNAME <- c(meta_fct_col, meta_num_col)
      df$InputValue <- c(meta_fct_inputs_str, meta_num_inputs_str)
      df$DefaultV <- c(meta_fct_range_str, meta_num_range_str)
      
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
    
    return(filtered_df1)
    
  })
}

## Module App ##################################################################
filter_mod_app <- function(df1, df3) {
  ui <- fluidPage(
    filters_mod_ui("filter1", df1)
  )
  
  server <- function(input, output, session) {
    filters_mod_server("filter1", df1, df3)
  }
  
  shinyApp(ui, server)
}    

