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
#' @importFrom shiny checkboxGroupInput wellPanel
#'
#' @export
yn_inputs <- function(inputId, label) {
  shiny::wellPanel(
    shiny::checkboxGroupInput(
      inputId = inputId,
      label = label,
      choices = c("No", "Yes"),
      selected = c("No", "Yes")
    )
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
#' @importFrom shiny checkboxGroupInput wellPanel
#'
#' @export
ynm_inputs <- function(inputId, label) {
  shiny::wellPanel(
    shiny::checkboxGroupInput(
      inputId = inputId,
      label = label,
      choices = c("No", "Yes", "Missing"),
      selected = c("No", "Yes", "Missing")
    )
  )
}

#' @title Check Box Group Input with choices of the levels of a factor variable.
#'
#' @description
#' Create a check box group input with choices of the levels of a factor variable.
#' @param inputId Input ID
#' @param label Input label
#' @param df A data frame with the factor variable
#' @param dfvname A factor variable name
#'
#' @return A list of HTML elements that can be added to a UI definition.
#' @examples
#' ## Only run examples in interactive R sessions
#' if (interactive()) {
#' dfsample <- data.frame(fctvar = as.factor(sample(letters[1:3], 10, replace = TRUE)))
#'
#' ui <- fluidPage(
#'   fct_inputs("somevalue", "A factor checkbox", dfsample, fctvar),
#'   verbatimTextOutput("value")
#' )
#'
#' server <- function(input, output, session) {
#'   output$value <- renderText({input$somevalue})
#' }
#'
#' shinyApp(ui, server)
#' }
#' @importFrom shiny checkboxGroupInput wellPanel
#' @export

fct_inputs <- function(inputId, label, df, dfvname) {

  # Check if valid
  if (is.null(levels(df[[dfvname]]))) {
    stop("Expecting a factor variable.")
  }

  shiny::wellPanel(
    shiny::checkboxGroupInput(
      inputId = inputId,
      label = label,
      choices = levels(df[[dfvname]]),
      selected = levels(df[[dfvname]])
    )
  )
}
