# DT table option for Summary Tables Tab
dtoptions1 <- list(
  searching = TRUE, scrollX = TRUE, autoWidth = FALSE,
  pageLength = 10, lengthMenu = list(c(10, 25, 50, -1), c(10, 25, 50, "All")), # Options for number of rows per page, default is 10
  initComplete = DT::JS(
    "function(settings, json) {",
    "$(this.api().table().header()).css({'background-color': 'black', 'color': '#ffffff', 'font-size': '16px'});", # Change header colour
    "}"
  )
)

# Tab 2 Summary Tables Module UI##################################################
summary_mod_ui <- function(id){
  ns <- NS("id")
  tagList(
    h2("This tab provides a summary of studies currently available in the Data Repository,
        including common metadata and data availability by categories."),
    h2("All tables on this tab have enabled search, sort, filter and reset functions."),
    ## Summary Stats ####################################################
    fluidRow(
      column(5, h2(htmlOutput(NS(id, "nstudy")))), # total number of studies
      column(5, h2(htmlOutput(NS(id, "nppt")))) # total number of participants
    ),
    br(),
    ## Common metadata table#############################################
    h3("The table below includes the study metadata."),
    fluidRow(column(1,# CLEAR button to reset 
                    offset = 11, align = "right", # on the right side
                    div(
                      style = "margin-bottom: 20px;",
                      actionButton(NS(id, "clearmeta"), "CLEAR")
                    )
    )), 
    fluidRow(column(12, DT::dataTableOutput(NS(id, "metatb")))),
    br(),
    
    ## Data availability by categories############################################
    h3("The table below provides the data availability by categories."),
    fluidRow(column(1,# CLEAR button to reset 
                    offset = 11, align = "right", # on the right side
                    div(
                      style = "margin-bottom: 20px;",
                      actionButton(NS(id, "clearava"), "CLEAR")
                    )
    )), 
    fluidRow(column(12, DT::dataTableOutput(NS(id, "studyava")))),
    br(),
    
    ## Data availability of harmonised variables##################################
    h3("The table below provides the data availability of harmonised variables."),
    h5("If the columns are misaligned, please sort by any variable to resolve this issue."),
    fluidRow(column(1,# CLEAR button to reset 
                    offset = 11, align = "right", # on the right side
                    div(
                      style = "margin-bottom: 20px;",
                      actionButton(NS(id, "clearhava"), "CLEAR")
                    )
    )), 
    fluidRow(column(12, DT::dataTableOutput(NS(id, "hvarava"))))
  )
  
}
# Tab 2 Summary Tables Module Server##################################################
summary_mod_server <- function(id, df1, df3, df4) {
  moduleServer(id, function(input, output, session) {
    ## Summary Stats ####################################################
    output$nstudy <- renderUI({ # Number of Studies
      HTML(paste("Number of Studies:", nrow(df1), sep = " "))
    })
    output$nppt <- renderUI({ # Total Participants 
      HTML(paste("Total Participants: ", sum(df1$STUDYSIZE), sep = " "))
    })
    
    
    ## Common metadata table#############################################
    output$metatb <- DT::renderDataTable({ #DT table
      temp1 <- df1[, 1:9]
      var_label <- df3 %>%
        filter(VARNAME %in% colnames(temp1)) %>%
        arrange(match(VARNAME, colnames(temp1)))
      
      DT::datatable(temp1,
                    filter = "top",
                    colnames = var_label$LABELS,
                    rownames = FALSE,
                    options = dtoptions1
      )
    })
    metaproxy <- dataTableProxy("metatb") # Proxy of the DT table
    observeEvent(eventExpr = input$clearmeta, clearSearch(metaproxy)) # if button is clicked --> Reset table
    
    ## Data availability by categories#############################################
    output$studyava <- DT::renderDataTable({ #DT table
      temp2 <- df1 %>% select(c(STUDY, cat01:cat15))
      var_label <- df3 %>%
        filter(VARNAME %in% colnames(temp2)) %>%
        arrange(match(VARNAME, colnames(temp2)))
      DT::datatable(temp2,
                    filter = "top",
                    colnames = var_label$LABELS,
                    rownames = FALSE,
                    options = dtoptions1
      )
    })
    avaproxy <- dataTableProxy("studyava") # Proxy of the DT table
    observeEvent(eventExpr = input$clearava, clearSearch(avaproxy)) # if button is clicked --> Reset table
    
    ## Data availability of harmonised variables##################################
    output$hvarava <- DT::renderDataTable({ #DT table
      # preparing the data
      temp1 <- df1 %>% select(c(STUDY, STUDYSIZE)) # Study size
      temp2 <- df4 %>%
        select(-ID) %>%
        group_by(STUDY) %>%
        summarise_all(~ (sum(!is.na(.)) / n())) # Percentage not missing
      temp3 <- df4 %>%
        select(c(STUDY, MRICOLL, IMGCOLL1, IMGCOLL2)) %>%
        group_by(STUDY) %>%
        summarise_all(~ mean(.)) # These data is YES/NO so not calculated using NA
      temp2[, 26:28] <- temp3[, 2:4] # Replaced
      sumdf <- merge(temp1, temp2, by = "STUDY") %>% mutate(STUDY = as.factor(STUDY))
      
      # Variable labels
      var_label <- df3 %>%
        filter(VARNAME %in% colnames(sumdf)) %>%
        arrange(match(VARNAME, colnames(sumdf)))
      
      # DT table
      DT::datatable(sumdf,
                    filter = "top",
                    colnames = var_label$LABELS,
                    rownames = FALSE,
                    options = dtoptions1
      ) %>%
        DT::formatPercentage(3:31, 1) %>% # Set percentage format
        DT::formatStyle(
          names(sumdf[, 3:31]),
          background = styleColorBar(c(0, 1), "#dddddd"),
          backgroundSize = "100% 50%",
          backgroundRepeat = "no-repeat",
          backgroundPosition = "center",
          borderBottomColor = "white",
          borderBottomStyle = "solid",
          borderBottomWidth = "1px",
          borderCollapse = "collapse",
          borderRightColor = "white",
          borderRightStyle = "solid",
          borderRightWidth = "2px"
        ) %>%
        DT::formatStyle( # Set Sample size style
          "STUDYSIZE",
          background = styleColorBar(c(0, max(sumdf$STUDYSIZE)), "#bebebe"),
          backgroundSize = "100% 50%",
          backgroundRepeat = "no-repeat",
          backgroundPosition = "center"
        )
    })
    
    havaproxy <- dataTableProxy("hvarava") # Proxy of the DT table
    observeEvent(eventExpr = input$clearhava, clearSearch(havaproxy)) # if button is clicked --> Reset table
    
  })
}

# Module App ##################################################################
summary_mod_app <- function(df1, df3, df4) {
  ui <- fluidPage(
    summary_mod_ui("sumtables")
  )
  
  server <- function(input, output, session) {
    summary_mod_server("sumtables", df1, df3, df4)
  }
  
  shinyApp(ui, server)
}

