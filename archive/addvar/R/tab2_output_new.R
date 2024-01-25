studymeta <- studymeta_new #!UPDATES!#
VAR_info <- VAR_info_new #!UPDATES!#
ppt_all <- ppt_all_new #!UPDATES!#

# Tab 2 Summary Tables Tab Output################################################################################################
tab2_output <- function(input, output, session) {
  
  # DT table option for Summary Tables Tab
  dtoptions1 <- list(
    searching = TRUE, scrollX = TRUE, autoWidth = FALSE,
    pageLength = 10, lengthMenu = list(c(10, 25, 50, -1), c(10, 25, 50, "All")), # Options for number of rows per page, default is 10
    initComplete = JS(
      "function(settings, json) {",
      "$(this.api().table().header()).css({'background-color': 'black', 'color': '#ffffff', 'font-size': '16px'});", # Change header colour
      "}"
    )
  )
  
  ## Summary Stats ####################################################
  output$nstudy <- renderUI({ # Number of Studies
    HTML(paste("Number of Studies:", nrow(studymeta), sep = " "))
  })
  output$nppt <- renderUI({ # Total Participants 
    HTML(paste("Total Participants: ", sum(studymeta$STUDYSIZE), sep = " "))
  })
  
  ## Common metadata table#############################################
  output$studymeta <- DT::renderDataTable({ #DT table
    temp1 <- studymeta[, 1:9]
    var_label <- VAR_info %>% 
      filter(VARNAME %in% colnames(temp1)) %>%
      arrange(match(VARNAME, colnames(temp1)))

    DT::datatable(temp1,
      filter = "top",
      colnames = var_label$LABELS,
      rownames = FALSE,
      options = dtoptions1
    )
  })
  metaproxy <- dataTableProxy("studymeta") # Proxy of the DT table
  observeEvent(eventExpr = input$clearmeta, clearSearch(metaproxy)) # if button is clicked --> Reset table

  ## Data availability by categories#############################################
  output$studyava <- DT::renderDataTable({ #DT table
    temp2 <- studymeta %>% select(c(STUDY, cat01:cat16)) #!UPDATES!#
    var_label <- VAR_info %>% #!UPDATES!#
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
    temp1 <- studymeta %>% select(c(STUDY, STUDYSIZE)) # Study size
    temp2 <- ppt_all %>%
      select(-ID) %>%
      group_by(STUDY) %>%
      summarise_all(~ (sum(!is.na(.)) / n())) # Percentage not missing
    temp3 <- ppt_all %>%
      select(c(STUDY, MRICOLL, IMGCOLL1, IMGCOLL2)) %>%
      group_by(STUDY) %>%
      summarise_all(~ mean(.)) # These data is YES/NO so not calculated using NA
    temp2[, 26:28] <- temp3[, 2:4] # Replaced
    sumdf <- merge(temp1, temp2, by = "STUDY") %>% mutate(STUDY = as.factor(STUDY))

    # Variable labels
    var_label <- VAR_info %>%
      filter(VARNAME %in% colnames(sumdf)) %>%
      arrange(match(VARNAME, colnames(sumdf)))

    # DT table
    DT::datatable(sumdf,
      filter = "top",
      colnames = var_label$LABELS,
      rownames = FALSE,
      options = dtoptions1
    ) %>%
      DT::formatPercentage(3:32, 1) %>% # Set percentage format  #!UPDATES! from 31 to 32#
      DT::formatStyle(
        names(sumdf[, 3:32]), #!UPDATES! from 31 to 32#
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
}
