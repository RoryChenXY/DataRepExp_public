#' @title plotly_pie
#'
#' @description A standardised function to generate a plotly pie chart
#'
#' @param data A data frame to be processed
#' @param var A variable to generate pie chart
#'
#' @importFrom magrittr %>%
#' @importFrom rlang enquo
#' @importFrom dplyr mutate count
#' @importFrom grDevices hcl.colors
#' @importFrom plotly plot_ly layout
#'
#' @return A plotly pie chart.
#'
#' @export
#'
#' @examples
#' data <- data.frame(fctvar = as.factor(rep(c("a", "b", "c", "c"), 10)))
#' plotly_pie(data, fctvar)
plotly_pie <- function(data, var){

  # Check if Data is a data.frame
  if (class(data) != "data.frame") {
    stop("Expecting a data frame")
  }

  # Capture the variable name as a quosure for use in dplyr functions
  var <- rlang::enquo(var)
  # Create a new data frame with counts for each level and a new column for the variable name
  df <- data %>%
    dplyr::count(!!(var), name = "freq") %>% # count unique values
    dplyr::mutate(var_level = !!(var)) # column variable level

  # Create a colour palette based on the number of levels of the variable
  cpalette <- grDevices::hcl.colors(nrow(df), palette = "Pastel1")

  # Create a pie chart using plotly
  p <- plotly::plot_ly(df, labels = ~var_level, values = ~freq, type = "pie",
                       sort = FALSE,
                       textinfo = "label+percent", # Display the label and percentage for each slice
                       textposition = "inside",
                       insidetextfont = list(color = "#FFFFFF"),
                       hoverinfo = "text", # Display the text string on hover
                       text = ~paste("Count:", freq),# Set the hover text
                       marker = list(colors = cpalette, # Assign colors to each slice
                                     line = list(color = "#FFFFFF", width = 1)),
                       showlegend = TRUE) %>%
    plotly::layout(legend = list(orientation = "h")) # Set the legend to horizontal

  return(p)
}


#' @title plotly_bar_multifct
#'
#' @description A function to generate a plotly bar chart that combined multiple factors with same levels.
#'
#' @param data A data frame generated with [countfactor] function, including 4 variables var_label, var_level, freq, and percent
#'
#' @importFrom ggplot2 ggplot aes geom_bar geom_text coord_flip scale_fill_brewer theme
#' @importFrom plotly ggplotly layout
#'
#' @return A plotly bar chart for multiple factors with same level.
#'
#' @export
#'
#' @examples
#' bar_multifct_df <- data.frame(var_label = c("AA", "AA", "BB", "BB", "CC","CC", "DD", "DD"),
#'                               var_level = as.factor(rep(c("No", "Yes"), 4)),
#'                               freq      = c(0, 10, 3, 7, 2, 8, 4, 6),
#'                               percent   = c("0%", "100%", "30%", "70%","20%", "80%", "40%", "60%"))
#' plotly_bar_multifct(bar_multifct_df)
plotly_bar_multifct <- function(data){
  # Used with the countfactor Function to produce combined bar charts for multiple factors

  if (all(names(data) != c("var_label", "var_level", "freq", "percent"))) {
    stop("Expecting a data frame with following variables: var_label, var_level, freq, and percent")
  }

  p <- ggplot2::ggplot(data,
                       ggplot2::aes(x = var_label,
                                    y = freq,
                                    fill = var_level,
                                    text = paste("Count: ", freq, "<br>Percent: ", percent))) + # Set the text for tooltip
    ggplot2::geom_bar(stat = "identity", position = "dodge", width = 0.5) +
    ggplot2::geom_text(aes(x = var_label, y = freq, label= freq, group = var_level),  # Add text labels above the bars (fixed)
                       size=3, vjust = -2,
                       position = position_dodge(width = .5),
                       inherit.aes = TRUE) +
    ggplot2::coord_flip() + # Flip the x and y axis
    ggplot2::scale_fill_brewer(palette="Pastel1") +
    ggplot2::theme(axis.title.x = element_blank(),
                   axis.title.y = element_blank()) # Remove x-axis and y-axis label
  pp <- plotly::ggplotly(p, tooltip = c("text")) %>%
    plotly::layout(legend = list(title="", orientation = "h")) # Remove the legend title and set the legend to horizontal

  return(pp)
}


#' @title plotly_histogram_grouped
#'
#' @description A standardised function to generate a grouped histogram with three display options.
#'
#' @param df A data frame to be processed
#' @param var A numeric variable to generate histogram
#' @param groupvar A grouping variable
#' @param label Legend label
#'
#' @importFrom rlang enquo
#' @importFrom magrittr %>%
#' @importFrom tidyr drop_na
#' @importFrom plotly plot_ly add_histogram layout
#'
#' @return A plotly histogram compare a numeric variable between groups.
#'
#' @export
#'
#' @examples
#' group_his_df <- data.frame(numvar = rep(1: 20, 5), fctvar = as.factor(c(rep(c("A", "B", "C"), 30), rep("A", 10))))
#' plotly_histogram_grouped(df = group_his_df, var = "numvar", groupvar = "fctvar", label = "Groups")
#'
plotly_histogram_grouped <- function(df, var, groupvar, varlabel, grouplabel){

  if (class(df) != "data.frame") {
    stop("Expecting a data frame")
  }

  enquov <- rlang::enquo(var)
  data <- df %>% tidyr::drop_na(all_of(!!enquov))

  p <- plotly::plot_ly(data = data,
                       x = ~.data[[var]],
                       color = ~.data[[groupvar]],
                       colors = "Pastel1",
                       alpha = 0.6,
                       hovertemplate = paste(varlabel,': %{x}',
                                             '<br>Counts: %{y}<br>')
  ) %>%
    plotly::add_histogram() %>%
    plotly::layout(title  = paste0("<br>Histogram of ", varlabel, " by ", grouplabel),
                   xaxis  = list(title = varlabel),
                   yaxis  = list(title = "Counts", showgrid = T),
                   legend = list(title = list(text = grouplabel), orientation = "v"),
                   updatemenus = list(
                     list(
                       x = 1.2,
                       y = 0.4,
                       type = "buttons",
                       buttons = list(
                         list(method = "relayout",
                              args = list("barmode", "group"),
                              label = "Group"),
                         list(method = "relayout",
                              args = list("barmode", "stack"),
                              label = "Stack"),
                         list(method = "relayout",
                              args = list("barmode", "overlay"),
                              label = "Overlay"))))
    )

  return(p)
}
