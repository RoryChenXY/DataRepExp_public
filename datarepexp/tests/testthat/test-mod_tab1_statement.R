test_that("the module 1 retrive correct version number",{
  shiny::testServer(mod_tab1_statement_server,{

    version <- paste("Current Version:", desc::desc_get_version(), sep = " ")

    expect_equal(as.character(output$version_n$html),  version)
  }
  )

})
