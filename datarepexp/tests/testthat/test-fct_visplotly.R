test_that("plotly_pie generate a plotly pie chart", {

  fctvar <- as.factor(rep(c("a", "b", "c", "c"), 10))
  data <- data.frame(fctvar)

  p <- plotly_pie(data, fctvar)

  # check p is a plotly object
  expect_s3_class(p, "plotly")

  # check data used to generate the pie chart
  pie_data <- data %>%
    dplyr::count(fctvar, name = "freq") %>% # count unique values
    dplyr::mutate(var_level = fctvar) # column variable level
  plotly_pie_data <- p$x$visdat[[1]]
  plotly_pie_data <- plotly_pie_data()
  expect_identical(plotly_pie_data, pie_data)

  # check plot type
  p_type <- p$x$attrs[[1]]$type
  expect_identical(p_type, "pie") # type is pie

  # check error
  expect_error(plotly_pie(fctvar, fctvar))
})

test_that("plotly_bar_multifct generate a plotly bar chart", {

  bar_multifct_df <- data.frame(var_label = c("AA", "AA", "BB", "BB", "CC","CC", "DD", "DD"),
                                var_level = as.factor(rep(c("No", "Yes"), 4)),
                                freq      = c(0, 10, 3, 7, 2, 8, 4, 6),
                                percent   = c("0%", "100%", "30%", "70%","20%", "80%", "40%", "60%"))

  p <- plotly_bar_multifct(bar_multifct_df)

  expect_s3_class(p, "plotly") # check p is a plotly object

  # check data used to generate the pie chart
  plotly_data <- p$x$visdat[[1]]
  plotly_data <- plotly_data()
  expect_identical(plotly_data, bar_multifct_df)

  # check plot type
  p_type <- p$x$attrs[[1]]$type
  expect_identical(p_type, "bar") # type is bar

  # check error
  df <- data.frame(fctvar = as.factor(rep(c("a", "b", "c", "d"), 10)))
  expect_error(plotly_bar_multifct(df))
})

test_that("plotly_histogram_grouped generate a grouped plotly histogram", {

  group_his_df <- data.frame(numvar = rep(1: 20, 5),
                             fctvar = as.factor(c(rep(c("A", "B", "C"), 30), rep("A", 10))))

  p <- plotly_histogram_grouped(df = group_his_df, var = "numvar", varlabel = "Numbers", grouplabel = "Groups")

  expect_s3_class(p, "plotly") # check p is a plotly object

  # check data used to generate the pie chart
  plotly_data <- p$x$visdat[[1]]
  plotly_data <- plotly_data()
  expect_identical(plotly_data, group_his_df)

  # check error
  df_error <- as.matrix(group_his_df)
  expect_error(plotly_histogram_grouped(df = df_error, var = "numvar", groupvar = "fctvar", varlabel = "Numbers", grouplabel = "Groups"))
})
