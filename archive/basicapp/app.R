#LIBRARY######################################################################################
library(shiny) #RShiny
library(shinydashboard) #Create a Dashboard

#UI####################
ui <- dashboardPage(
  skin = "black",
  dashboardHeader(title = "Data Repository Explorer"),
  dashboardSidebar(uiOutput("sidebarpanel")),
  dashboardBody(uiOutput("body"))
)

#SERVER####################
##Tab Contents####################
tab1overview <- fluidPage(
  h1('Overview Tab Contents'))
tab2summary <- fluidPage(
  h1('Summary Tab Contents'))
tab3filters <- fluidPage(
  h1('Filters Tab Contents'))
tab4visua <- fluidPage(
  h1('Visualisation Tab Contents'))
tab5pa <- fluidPage(
  h1('Preliminary Analysis Tab Contents'))

server <- function(input, output, session) {
  
  ##Side Menu#################################################################################
  output$sidebarpanel <- renderUI({
    sidebarMenu(menuItem("Overview", tabName = "ovtab", icon = icon("bolt")),
                menuItem("Summary Tables", tabName = "sumtab", icon = icon("table")),
                menuItem("Filters",  tabName = "filtab", icon = icon("filter")),
                menuItem("Visualisation", tabName = "vistab", icon = icon("chart-line")),
                menuItem("Preliminary Analysis", tabName = "patab", icon = icon("magnifying-glass-chart"))
    )
  })
  
  ##Body############################################################################################################
  output$body <- renderUI({
    tabItems(
      ##Tab1 - Overview Tab#####################################################################
      tabItem(tabName ="ovtab",class = "active", tab1overview),
      ##Tab2 - Summary Tab######################################################################
      tabItem(tabName = "sumtab", tab2summary),
      ##Tab3 - Filters Tab######################################################################
      tabItem(tabName = "filtab", tab3filters),
      ##Tab4 - Visualisation Tab################################################################
      tabItem(tabName = "vistab", tab4visua),
      #Tab5 - Preliminary Analysis Tab########################################################
      tabItem(tabName = "patab", tab5pa)
    )
  })
  
}

#APP####################
shinyApp(ui = ui, server = server)