% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mod_tab3_filter_utils_inputs.R
\name{yn_inputs}
\alias{yn_inputs}
\title{yn_inputs}
\usage{
yn_inputs(inputId, label)
}
\arguments{
\item{inputId}{Input ID}

\item{label}{Input label}
}
\value{
A list of HTML elements that can be added to a UI definition.
}
\description{
Create a check box group input with only No/Yes Options
}
\examples{
## Only run examples in interactive R sessions
if (interactive()) {

ui <- fluidPage(
  yn_inputs("somevalue", "A Yes or No checkbox"),
  verbatimTextOutput("value")
)

server <- function(input, output, session) {
  output$value <- renderText({input$somevalue})
}

shinyApp(ui, server)
}

}
