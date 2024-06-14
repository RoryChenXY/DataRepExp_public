
<!-- README.md is generated from README.Rmd. Please edit that file -->

# datarepexp

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![Codecov test
coverage](https://codecov.io/gh/RoryChenXY/DataRepExp_public/branch/main/graph/badge.svg)](https://app.codecov.io/gh/RoryChenXY/DataRepExp_public?branch=main)
<!-- badges: end -->

[datarepexp](https://github.com/RoryChenXY/DataRepExp_public/datarepexp),
is an open-source R Shiny application and an R package built using the
[golem](https://github.com/ThinkR-open/golem) framework.

Data Repository Explorer is developed to improve the findability,
accessibility, interoperability, and reusability (FAIR) of research data
held in a data repository.

The application displays standardised metadata across multiple studies
including data availability by categories (such as demographics, medical
history, imaging data and genomic data) to allow high-level comparison.
It enables users to explore and run preliminary analysis from
participants that match certain criteria. In addition, it provides
features to export reports and aggregated results for data access
application purposes. The application was initially developed for a
discipline-specific data-sharing platform, the Dementias Platform
Australia (DPAU). Envisioning this work could be utilized by other data
repositories in diverse disciplines, this demo application was created
using simulated health-related data for demonstration purposes.

It can be modified and utilized by other data repositories by adopting
the discipline-specific metadata schema and common variables.

## Installation

You can install the development version of datarepexp from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("RoryChenXY/DataRepExp_public/", subdir="datarepexp")
```

## Demo

The demo app is deployed on shinyapps.io:
<https://rorychenxy.shinyapps.io/repexp/>

To run the dev version of this app locally:

``` r
library(datarepexp)
datarepexp::repexp_app()
```
