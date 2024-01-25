# Tab2 Summary Tables Layout################################################################
tab2summary <- fluidPage(
  h2("This page provides a summary of studies currently available on the Data Repository,
      including common metadata, data availability by categories and data availability of harmonised variables."),
  h2("All tables on this tab enabled search, sort and filter function."),
  ## Summary Stats ####################################################
  fluidRow(
    column(5, h2(htmlOutput("nstudy"))), # total number of studies
    column(5, h2(htmlOutput("nppt"))) # total number of participants
  ),
  br(),
  
  ## Common metadata table#############################################
  h3("The table below includes the study metadata."),
  fluidRow(column(1,# CLEAR button to reset 
    offset = 11, align = "right", # on the right side
    div(
      style = "margin-bottom: 20px;",
      actionButton("clearmeta", "CLEAR")
    )
  )), 
  fluidRow(column(12, DT::dataTableOutput("studymeta"))), 
  br(),
  
  ## Data availability by categories############################################
  h3("The table below provides the data availability by categories."),
  fluidRow(column(1,# CLEAR button to reset 
    offset = 11, align = "right", # on the right side
    div(
      style = "margin-bottom: 20px;",
      actionButton("clearava", "CLEAR")
    )
  )), 
  fluidRow(column(12, DT::dataTableOutput("studyava"))), 
  br(),
  
  ## Data availability of harmonised variables##################################
  h3("The table below provides the data availability of harmonised variables."),
  h5("Please sort by any variable to resolve the aligning issue."),
  fluidRow(column(1,# CLEAR button to reset 
    offset = 11, align = "right", # on the right side
    div(
      style = "margin-bottom: 20px;",
      actionButton("clearhava", "CLEAR")
    )
  )), 
  fluidRow(column(12, DT::dataTableOutput("hvarava")))
)