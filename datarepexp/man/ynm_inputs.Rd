% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mod_tab3_filter_utils_inputs.R
\name{ynm_inputs}
\alias{ynm_inputs}
\title{ynm_inputs}
\usage{
ynm_inputs(inputId, label)
}
\arguments{
\item{inputId}{Input ID}

\item{label}{Input label}
}
\value{
A list of HTML elements that can be added to a UI definition.
}
\description{
Create a check box group input with only No/Yes/Missing Options
}
\examples{
## Only run examples in interactive R sessions
if (interactive()) {

ui <- fluidPage(
  ynm_inputs("somevalue", "A Yes or No or Missing checkbox"),
  verbatimTextOutput("value")
)

server <- function(input, output, session) {
  output$value <- renderText({input$somevalue})
}

shinyApp(ui, server)
}

}
