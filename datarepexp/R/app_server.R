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
                               menuSubItem("Categorical Outcome", tabName = "pacate"),
                               menuSubItem("Quantitative Outcome", tabName = "paquan")

      )
    )
  })



  tab5paq <- fluidPage(
    h1('Preliminary Analysis Tab Contents'))

  ## Body############################################################################################################
  output$body <- shiny::renderUI({
    tabItems(
      ## Tab1 - Overview Tab#####################################################################
      tabItem(tabName = "ovtab", class = "active", fluidPage(mod_tab1_statement_ui("tab1_statement_1"))),
      ## Tab2 - Summary Tab######################################################################
      tabItem(tabName = "metatab", fluidPage(mod_tab2_meta_ui("tab2_meta_1"))),
      ## Tab3 - Filters Tab######################################################################
      tabItem(tabName = "filtab", fluidPage(mod_tab3_filter_ui("tab3_filter_1", metadf = studymeta, pptdf = ppt_all_fc))),
      ## Tab4 - Visualisation Tab################################################################
      tabItem(tabName = "vistab", fluidPage(mod_tab4_visual_ui("tab4_visual_1"))),
      # Tab5 - Preliminary Analysis Tab########################################################
      tabItem(tabName = "pacate", fluidPage(mod_tab5_pac_ui("tab5_pac_1"))),
      tabItem(tabName = "paquan", tab5paq)

    )
  })

  mod_tab1_statement_server("tab1_statement_1")

  mod_tab2_meta_server("tab2_meta_1", metadf = studymeta, infodf = VAR_info)

  mod_tab3_filter_server("tab3_filter_1", metadf = studymeta, pptdf = ppt_all_fc, infodf = VAR_info)

  filteredppt <- mod_tab3_filter_server("tab3_filter_1", metadf = studymeta, pptdf = ppt_all_fc, infodf = VAR_info)

  ### Warning message for no participants identified####################################################################################
  observeEvent(filteredppt(), { #update whenever filter changes

    if(nrow(filteredppt()) == 0){
      shiny::showNotification(id = 'fppt_warning', # Save the ID for removal later
                              'Base on the filters you have selected, no participants were identified, please update your selection.',
                              duration = NULL, type='warning', closeButton=TRUE)
    } else{
      shiny::removeNotification(id = 'fppt_warning')
    }
  })

  mod_tab4_visual_server("tab4_visual_1", metadf = studymeta, react_df = filteredppt)

  mod_tab5_pac_server("tab5_pac_1",  react_df = filteredppt)


}
