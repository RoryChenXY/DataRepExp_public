# Building a Prod-Ready, Robust Shiny Application.
#
# README: each step of the dev files is optional, and you don't have to
# fill every dev scripts before getting started.
# 01_start.R should be filled at start.
# 02_dev.R should be used to keep track of your development during the project.
# 03_deploy.R should be used once you need to deploy your app.
#
#
########################################
#### CURRENT FILE: ON START SCRIPT #####
########################################

## Fill the DESCRIPTION ----
## Add meta data about your application
##
## /!\ Note: if you want to change the name of your app during development,
## either re-run this function, call golem::set_golem_name(), or don't forget
## to change the name in the app_sys() function in app_config.R /!\
##
golem::fill_desc(
  pkg_name = "datarepexp", # The Name of the package containing the App
  pkg_title = "Data Repository Explorer", # The Title of the package containing the App
  pkg_description = "The Data Repository Explorer, is an open-source R Shiny application developed to improve the
                     findability, accessibility, interoperability, and reusability (FAIR) of research data held in a data repository.", # The Description of the package containing the App
  author_first_name = "Rory", # Your First Name
  author_last_name = "Chen", # Your Last Name
  author_email = "rory.chen.xy@gmail.com", # Your Email
  repo_url = NULL, # The URL of the GitHub Repo (optional),
  pkg_version = "0.0.0.9000" # The Version of the package containing the App
)

## Set Dependencies in the DESCRIPTION
usethis::use_package("R", type = "Depends", min_version = TRUE)
usethis::use_package("shiny", type = "Depends", min_version = TRUE)

## Use functions to add a list of pkgs to DESCRIPTION
pkglist1 <- list("config",
                 "golem",
                 "dplyr",
                 "magrittr",
                 "purrr",
                 "rlang",
                 "tidyr",
                 "useful" ,
                 "shinydashboard",
                 "shinyWidgets",
                 "shinyjs",
                 "DT",
                 "ggplot2",
                 "plotly",
                 "scales",
                 "collapse",
                 "forcats",
                 "grDevices",
                 "RColorBrewer",
                 "testthat")
purrr::modify(pkglist1, ~usethis::use_package(.x, type = "Imports", min_version = TRUE))

## Set {golem} options ----
golem::set_golem_options()

## Install the required dev dependencies ----
golem::install_dev_deps()

## Create Common Files ----
## See ?usethis for more information
usethis::use_mit_license("Rory Chen") # You can set another license here
usethis::use_readme_rmd(open = FALSE)
devtools::build_readme()
# Note that `contact` is required since usethis version 2.1.5
# If your {usethis} version is older, you can remove that param
usethis::use_code_of_conduct(contact = "Rory Chen")
usethis::use_lifecycle_badge("Experimental")
usethis::use_news_md(open = FALSE)

## Use git ----
usethis::use_git()

## Init Testing Infrastructure ----
## Create a template for tests
golem::use_recommended_tests()

## Favicon ----
# If you want to change the favicon (default is golem's one)
golem::use_favicon() # path = "path/to/ico". Can be an online file.
#golem::remove_favicon() # Uncomment to remove the default favicon

## Add helper functions ----
#golem::use_utils_ui(with_test = TRUE)
#golem::use_utils_server(with_test = TRUE)

# You're now set! ----

# go to dev/02_dev.R
rstudioapi::navigateToFile("dev/02_dev.R")
