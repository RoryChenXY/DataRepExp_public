# Tab 4 Filter Report Module ################################################

# DT table option 2 for Filters - Filter Report Tab with download buttons#####
dtoptions2 <- list(searching = FALSE, scrollX = TRUE, autoWidth = FALSE, 
                   pageLength = 10, lengthMenu = list(c(10,25,50,-1), c(10,25,50,"All")), # Options for number of rows per page, default is 10
                   initComplete = DT::JS(
                     "function(settings, json) {",
                     "$(this.api().table().header()).css({'background-color': 'black', 
                     'color': '#ffffff', 'font-size': '16px'});", #Change header colour
                     "}"),
                   dom = 'Blfrtip',# Elements to show on the table
                   buttons = c('copy', 'csv', 'excel', 'pdf', 'print')) # Add export buttons


# Tab 4 Filter Report Module UI################################################
report_mod_ui <- function(id) {
  ns <- NS("id")
  tagList(
    h4("The studies you have identified include:"),
    wellPanel(fluidRow(DT::dataTableOutput(NS(id, "fedstudy")))),
    h4("The data availability of identified studies:"),
    wellPanel(fluidRow(DT::dataTableOutput(NS(id, "data_ava"))))
  )
}

# Tab 4 Filter Report Module Server ###############################################################
report_mod_server <- function(id, df1, df3, react_df) {
  moduleServer(id, function(input, output, session) {
  # Filtered Studies metadata
  output$fedstudy <- DT::renderDataTable({
    
    metadf <- react_df()
    
    f_study_list <- unique(metadf$STUDY) # list of filtered study
    
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
  # Filtered Studies data availability 
  output$data_ava <- DT::renderDataTable({
    metadf <- react_df()
    
    f_study_list <- unique(metadf$STUDY) # list of filtered study
    
    f_study_ava <- df1[, c(1,10:24)] %>% filter(STUDY %in% f_study_list) #metadata
    
    var_info <- df3 %>%
      filter(VARNAME %in% colnames(f_study_ava)) %>%
      arrange(match(VARNAME, colnames(f_study_ava)))
    
    var_label <- var_info$LABEL
    
    DT::datatable(f_study_ava,
                  colnames = var_label,
                  rownames = FALSE, 
                  options = dtoptions2,
                  extensions = 'Buttons')
  })
  
  
  })

  
}