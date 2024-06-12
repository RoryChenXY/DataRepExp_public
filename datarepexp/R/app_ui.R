#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @import shinydashboard
#' @noRd
app_ui <- function(request) {
  tagList(
    # Your application UI logic
    shinydashboard::dashboardPage(
      skin = "black",
      shinydashboard::dashboardHeader(title = "Repository Explorer"),
      shinydashboard::dashboardSidebar(uiOutput("sidebarpanel")),
      shinydashboard::dashboardBody(uiOutput("body"))
    ),
    # Leave this function for adding external resources
    golem_add_external_resources()
  )
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @import shinydashboard
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @export
#' @noRd
golem_add_external_resources <- function() {
  add_resource_path(
    "www",
    app_sys("app/www")
  )

  tags$head(
    tags$link(rel="stylesheet", type="text/css", href="www/custom.css"),
    golem::favicon(),
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}
