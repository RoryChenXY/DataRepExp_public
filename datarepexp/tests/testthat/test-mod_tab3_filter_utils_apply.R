test_that("apply factor filter", {
  data <- data.frame(fctvar = as.factor(rep(c("a", "b", "c"), 10)))

  applied <- apply_factor_filter(data, 'fctvar', c('a', 'b'))

  results <- data %>% dplyr::filter(fctvar %in% c('a', 'b'))

  expect_equal(applied, results)
})


test_that("apply numeric filter", {
  data <- data.frame(numvar  = rep(c(1,2,3, NA), 10))

  applied1 <- apply_slide_filter(data, 'numvar', list(1, 2, 1))
  applied2 <- apply_slide_filter(data, 'numvar', list(1, 2, 0))

  results1 <- data %>% dplyr::filter(is.na(numvar) | numvar>=1 & numvar<=2)
  results2 <- data %>% dplyr::filter(numvar>=1 & numvar<=2)

  expect_equal(applied1, results1)
  expect_equal(applied2, results2)
})

