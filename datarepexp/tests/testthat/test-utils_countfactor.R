test_that("countfactor works", {
  fctvar = as.factor(rep(c("a", "b", "c", "d"), 10))
  data <-  data.frame(fctvar) %>% dplyr::filter(fctvar %in% c("a", "b"))

  count1 <- countfactor(data, fctvar, "Factor ABCD")

  count2 <- data %>%
    dplyr::count(fctvar, name = 'freq', .drop = FALSE) %>%
    dplyr::mutate(var_level = fctvar)%>%
    dplyr::mutate(var_label = "Factor ABCD")%>%
    dplyr::select(var_label, var_level, freq) %>% ##
    dplyr::mutate(percent = scales::percent(freq/sum(freq)))

  expect_identical(count1, count2)

  expect_identical(nrow(count1), length(levels(fctvar)))

  expect_error(countfactor(fctvar, fctvar, "Factor ABCD"))


})
