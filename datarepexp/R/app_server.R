#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @import shinydashboard
#' @noRd
app_server <- function(input, output, session) {
  # Your application server logic
  output$sidebarpanel <- shiny::renderUI({
    shinydashboard::sidebarMenu(
      shinydashboard::menuItem("Overview", tabName = "ovtab", icon = icon("bolt")),
      shinydashboard::menuItem("Metadata", tabName = "metatab", icon = icon("table")),
      shinydashboard::menuItem("Filters", tabName = "filtab", icon = icon("filter")),
      shinydashboard::menuItem("Visualisation", tabName = "vistab", icon = icon("chart-line")),
      shinydashboard::menuItem("Preliminary Analysis",
                               icon = icon("magnifying-glass-chart"),
                               startExpanded = TRUE,
                               menuSubItem("Quantitative Outcome", tabName = "paquan"),
                               menuSubItem("Categorical Outcome", tabName = "pacate")
      )
    )
  })

  tab3filters <- fluidPage(
    h1('Filters Tab Contents'))
  tab4visua <- fluidPage(
    h1('Visualisation Tab Contents'))
  tab5paq <- fluidPage(
    h1('Preliminary Analysis Tab Contents'))
  tab5pac <- fluidPage(
    h1('Preliminary Analysis Tab Contents'))

  ## Body############################################################################################################
  output$body <- shiny::renderUI({
    tabItems(
      ## Tab1 - Overview Tab#####################################################################
      tabItem(tabName = "ovtab", class = "active", fluidPage(mod_tab1_statement_ui("tab1_statement_1"))),
      ## Tab2 - Summary Tab######################################################################
      tabItem(tabName = "metatab", fluidPage(mod_tab2_meta_ui("tab2_meta_1"))),
      ## Tab3 - Filters Tab######################################################################
      tabItem(tabName = "filtab", tab3filters),
      ## Tab4 - Visualisation Tab################################################################
      tabItem(tabName = "vistab", tab4visua),
      # Tab5 - Preliminary Analysis Tab########################################################
      tabItem(tabName = "paquan", tab5paq),
      tabItem(tabName = "pacate", tab5pac)
    )
  })

  mod_tab1_statement_server("tab1_statement_1")

  mod_tab2_meta_server("tab2_meta_1", metadf = studymeta, infodf = VAR_info)

}
