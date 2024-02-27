# LIBRARY######################################################################################
library(shiny) # RShiny
library(shinydashboard) # Create a Dashboard
library(shinyjs)
library(shinyWidgets) # Shiny Widgets


# data manipulation
library(dplyr)
library(tidyr)
library(tidyverse)
library(forcats)
library(useful)
library(magrittr) # for piping+
library(purrr)

# outputs
library(DT) # interactive table
library(htmltools) # HTML generation and output
library(fontawesome) # icons

# data visualisation
library(ggplot2)
library(plotly) # interactive plot
library(scales)

# Load data######################################################################
load("data/sim_meta.RData")


# UI####################
ui <- dashboardPage(
  skin = "black",
  dashboardHeader(title = "Metadata Explorer"),
  dashboardSidebar(uiOutput("sidebarpanel")),
  dashboardBody(uiOutput("body")),
  tags$head(#CSS to fix the position of the sidebar
    tags$link(rel = "stylesheet", type = "text/css", href = "styles.css")
  )
)

## Tab Contents####################
source("./R/tab1_contents.R", local = TRUE)
tab2summary <- fluidPage(summary_mod_ui("sumtables"))
tab3filters <- fluidPage(filters_mod_ui("sfilters", df1 = studymeta))
tab4report <- fluidPage(report_mod_ui("freport"))
tab5visual <- fluidPage(vis_mod_ui("visual"))

# SERVER####################
server <- function(input, output, session) {
  
  ## Side Menu#################################################################################
  output$sidebarpanel <- renderUI({
    sidebarMenu(
      menuItem("Overview", tabName = "ovtab", icon = icon("bolt")),
      menuItem("Summary Tables", tabName = "sumtab", icon = icon("table")),
      menuItem("Study Filters", tabName = "filtab", icon = icon("filter")),
      menuItem("Filter Report", tabName = "reptab", icon = icon("file")),
      menuItem("Visualisation", tabName = "vistab", icon = icon("chart-line"))
    )
  })
  
  
  ## Body############################################################################################################
  output$body <- renderUI({
    tabItems(
      ## Tab1 - Overview Tab#####################################################################
      tabItem(tabName = "ovtab", class = "active", tab1overview),
      ## Tab2 - Summary Tab######################################################################
      tabItem(tabName = "sumtab", tab2summary),
      ## Tab3 - Filters Tab######################################################################
      tabItem(tabName = "filtab", tab3filters),
      ## Tab4 - Filter Report Tab################################################################
      tabItem(tabName = "reptab", tab4report),
      ## Tab5 - Visualisation Tab################################################################
      tabItem(tabName = "vistab", tab5visual)
    )
  })
  
  ## Outputs#####################################################################
  summary_mod_server("sumtables", df1= studymeta, df3 = VAR_info)
  filters_mod_server("sfilters", df1 = studymeta, df3 = VAR_info)
  filtered_study <- filters_mod_server("sfilters", df1 = studymeta, df3 = VAR_info)
  report_mod_server("freport", df1 = studymeta, df3 = VAR_info, react_df = filtered_study)
  vis_mod_server("visual", df1 = studymeta, react_df = filtered_study)
}

# APP####################
shinyApp(ui = ui, server = server)
