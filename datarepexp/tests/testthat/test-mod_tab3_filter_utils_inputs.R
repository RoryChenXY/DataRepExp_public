
test_that("Default yn_inputs", {
  yntag <- yn_inputs("id_yn", "label_yn")

  expect_equal(yntag$attribs$class, "well") # as wrapped in a wellPanel
  expect_equal(yntag$children[[1]]$attribs$class, "form-group shiny-input-checkboxgroup shiny-input-container") # shiny checkbox group input
  expect_equal(yntag$children[[1]]$attribs$id, "id_yn") # input ID
  expect_equal(yntag$children[[1]]$children[[1]]$children[[1]], "label_yn") # input display label

  # choices list
  choices <- list("No", "Yes")
  choiceslist <- yntag$children[[1]]$children[[2]]$children[[1]]

  expect_length(choiceslist, length(choices)) # same length

  values <- purrr::map2(choiceslist, choices, function(x, y) grepl(pattern = y, x = as.character(x))) # options should be No, Yes
  values <- unlist(values)
  expect_true(all(values))

  checked <- lapply(choiceslist, function(x) grepl(pattern = "checked", x = as.character(x))) # By default, all checked
  checked <- unlist(checked)
  expect_true(all(checked))
})


test_that("Default ynm_inputs", {
  ynmtag <- ynm_inputs("id_ynm", "label_ynm")

  expect_equal(ynmtag$attribs$class, "well") # as wrapped in a wellPanel

  expect_equal(ynmtag$children[[1]]$attribs$class, "form-group shiny-input-checkboxgroup shiny-input-container") # shiny checkbox group input
  expect_equal(ynmtag$children[[1]]$attribs$id, "id_ynm") # input ID
  expect_equal(ynmtag$children[[1]]$children[[1]]$children[[1]], "label_ynm") # input display label
  # choices list
  choices <- list("No", "Yes", "Missing")
  choiceslist <- ynmtag$children[[1]]$children[[2]]$children[[1]]

  expect_length(choiceslist, length(choices)) # same length

  values <- purrr::map2(choiceslist, choices, function(x, y) grepl(pattern = y, x = as.character(x))) # options should be No, Yes, Missing
  values <- unlist(values)
  expect_true(all(values))

  checked <- lapply(choiceslist, function(x) grepl(pattern = "checked", x = as.character(x))) # By default, all checked
  checked <- unlist(checked)
  expect_true(all(checked))
})

test_that("Default fct_inputs",{

  data <- data.frame(charvar = rep(c("a", "b", "c"), 10),
                     numvar  = rep(c(1,2,3), 10),
                     fctvar = as.factor(rep(c("a", "b", "c"), 10)))

  fcttag <- fct_inputs("id_fct_abc", "label_fct_abc", data, "fctvar")

  expect_equal(fcttag$attribs$class, "well") # as wrapped in a wellPanel
  expect_equal(fcttag$children[[1]]$attribs$class, "form-group shiny-input-checkboxgroup shiny-input-container") # shiny checkbox group input
  expect_equal(fcttag$children[[1]]$attribs$id, "id_fct_abc") # input ID
  expect_equal(fcttag$children[[1]]$children[[1]]$children[[1]], "label_fct_abc") # input display label

  # choices list
  choices <- levels(data$fctvar)
  choiceslist <- fcttag$children[[1]]$children[[2]]$children[[1]]

  expect_length(choiceslist, length(choices)) # same length

  values <- purrr::map2(choiceslist, choices, function(x, y) grepl(pattern = y, x = as.character(x))) # options should be the levels and same order
  values <- unlist(values)
  expect_true(all(values))

  checked <- lapply(choiceslist, function(x) grepl(pattern = "checked", x = as.character(x))) # By default, all checked
  checked <- unlist(checked)
  expect_true(all(checked))

  expect_error(fct_inputs("id_fct_abc", "label_fct_abc", data, "charvar"))
  expect_error(fct_inputs("id_fct_abc", "label_fct_abc", data, "numvar"))

})
