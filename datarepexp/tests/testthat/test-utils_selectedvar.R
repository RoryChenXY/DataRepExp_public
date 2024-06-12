test_that("selectedvar works", {

  expect_identical(selectedvar("Study"), "STUDY")

  expect_identical(selectedvar(VAR_info$LABELS[10]), VAR_info$VARNAME[10])

  expect_error(selectedvar("ABC"))

})
