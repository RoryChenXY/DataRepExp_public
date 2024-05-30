#' @title Check Box Group Input with only No/Yes Options
#'
#' @description
#' Create a check box group input with only No/Yes Options
#'
#' @param inputId Input ID
#' @param label Input label
#'
#' @return A list of HTML elements that can be added to a UI definition.
#'
#' @examples
#' ## Only run examples in interactive R sessions
#' if (interactive()) {
#'
#' ui <- fluidPage(
#'   yn_inputs("somevalue", "A Yes or No checkbox"),
#'   verbatimTextOutput("value")
#' )
#'
#' server <- function(input, output, session) {
#'   output$value <- renderText({input$somevalue})
#' }
#'
#' shinyApp(ui, server)
#' }
#'
#' @importFrom shiny checkboxGroupInput
#'
#' @export
yn_inputs <- function(inputId, label) {
  shiny::checkboxGroupInput(
    inputId = inputId,
    label = label,
    choices = c("No", "Yes"),
    selected = c("No", "Yes")
  )
}

#' @title Check Box Group Input with only No/Yes/Missing Options
#'
#' @description
#' Create a check box group input with only No/Yes/Missing Options
#'
#' @param inputId Input ID
#' @param label Input label
#'
#' @return A list of HTML elements that can be added to a UI definition.
#'
#' @examples
#' ## Only run examples in interactive R sessions
#' if (interactive()) {
#'
#' ui <- fluidPage(
#'   ynm_inputs("somevalue", "A Yes or No or Missing checkbox"),
#'   verbatimTextOutput("value")
#' )
#'
#' server <- function(input, output, session) {
#'   output$value <- renderText({input$somevalue})
#' }
#'
#' shinyApp(ui, server)
#' }
#'
#' @importFrom shiny checkboxGroupInput
#'
#' @export
ynm_inputs <- function(inputId, label) {
  shiny::checkboxGroupInput(
    inputId = inputId,
    label = label,
    choices = c("No", "Yes", "Missing"),
    selected = c("No", "Yes", "Missing")
  )
}
