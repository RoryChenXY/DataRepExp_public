# LIBRARY######################################################################################
library(shiny) # RShiny
library(shinydashboard) # Create a Dashboard
library(shinyWidgets) # Shiny Widgets
library(shinyjs)

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
load("data/simdata_new.RData") #!UPDATES!#

# UI####################
ui <- dashboardPage(
  skin = "black",
  dashboardHeader(title = "Data Repository Explorer"),
  dashboardSidebar(uiOutput("sidebarpanel")),
  dashboardBody(uiOutput("body")),
  tags$head(#CSS to fix the position of the sidebar
    tags$link(rel = "stylesheet", type = "text/css", href = "styles.css")
  )
)



## Tab Contents####################
source("./R/tab1_contents.R", local = TRUE)
source("./R/tab2_layout.R", local = TRUE)
source("./R/tab2_output_new.R", local = TRUE) #!UPDATES!#

# Note modules would be load automatically, no source needed
tab3filters <- fluidPage(filters_mod_ui("filterall", df1 = studymeta_new, df2 = ppt_all_fc_new))#!UPDATES!#

tab4visua <- fluidPage(vis_mod_ui("Visual"))

tab5paq <- fluidPage(paq_mod_ui("paqvisual"))

tab5pac <- fluidPage(pac_mod_ui("pacvisual"))

server <- function(input, output, session) {
  # SERVER####################
  ## Side Menu#################################################################################
  output$sidebarpanel <- renderUI({
    sidebarMenu(
      menuItem("Overview", tabName = "ovtab", icon = icon("bolt")),
      menuItem("Summary Tables", tabName = "sumtab", icon = icon("table")),
      menuItem("Filters", tabName = "filtab", icon = icon("filter")),
      menuItem("Visualisation", tabName = "vistab", icon = icon("chart-line")),
      menuItem("Preliminary Analysis",
        icon = icon("magnifying-glass-chart"),
        startExpanded = TRUE,
        menuSubItem("Quantitative Outcome", tabName = "paquan"),
        menuSubItem("Categorical Outcome", tabName = "pacate")
      )
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
      ## Tab4 - Visualisation Tab################################################################
      tabItem(tabName = "vistab", tab4visua),
      # Tab5 - Preliminary Analysis Tab########################################################
      tabItem(tabName = "paquan", tab5paq),
      tabItem(tabName = "pacate", tab5pac)
    )
  })

  ## Outputs#####################################################################
  tab2_output(input, output, session)

  filters_mod_server("filterall", df1 = studymeta_new, df2 = ppt_all_fc_new, df3 = VAR_info_new) #!UPDATES!#
  
  filteredppt <- filters_mod_server("filterall", df1 = studymeta_new, df2 = ppt_all_fc_new, df3 = VAR_info_new) #!UPDATES!#
  
  ### Warning message for no participants identified####################################################################################
  observeEvent(filteredppt(), { #update whenever filter changes
    
    if(nrow(filteredppt()) == 0){
      showNotification(id = 'fppt_warning', # Save the ID for removal later
                       'Base on the filters you have selected, no participants were identified, please update your selection.', 
                       duration = NULL, type='warning', closeButton=TRUE)
    } else{
      removeNotification(id = 'fppt_warning')
    }
  })
  

  vis_mod_server("Visual", df1 = studymeta_new, react_df = filteredppt) #!UPDATES!#

  paq_mod_server("paqvisual", df3 = VAR_info_new, react_df = filteredppt) #!UPDATES!#

  pac_mod_server("pacvisual", df3 = VAR_info_new, react_df = filteredppt) #!UPDATES!#
  
  
}

# APP####################
shinyApp(ui = ui, server = server)
