---
title: 'DataRepExp: a R shiny Dashboard that makes Data FAIR for Data Repositories'

tags:
  - R
  - shiny
  - dashboard
  - data repository
  - visualisation
  - FAIR

authors:
  - name: Rory Chen
    orcid: 0000-0002-2094-2682
    affiliation: 1
affiliations:
 - name: CHeBA
   index: 1
date: 27 September 2023
bibliography: packages.bib
---

# Summary
DataRepExp stands for Data Repository Explorer. This interactive data visualisation tool was initially developed for a discipline-specific data-sharing platform - Dementias Platform Australia [Citation].

The application displays standardised metadata across studies including data availability by categories (such as demographics, medical history, imaging data and genomic data) to allow high-level comparison. It enables users to explore and visualise data from participants that match certain criteria or interests, which are applied using filters at study and participant levels. In addition, it provides features to export tables and aggregated results for data access application purposes.

While the demo application is discipline-specific, it can be populated to other data repositories in various disciplines. 

# Statement of need
Data repositories have become increasingly important in recent years as more emphasis has been placed on data sharing and open science practices. By making data publicly available through repositories, researchers can facilitate the reuse of their data by others, increasing the potential for new scientific discoveries, while ensuring data persistence and supporting data preservation. However, challenges exist for data findability, accessibility, interoperability, and reusability (FAIR) [FAIR Citation].

Even though most data repositories have adopted various metadata schemas to describe the dataset, it has been increasingly a challenge for researchers to find relevant data that meet research interests or needs. For multi-cohort research, applying to access different datasets usually comes with variable and complicated data-sharing requirements and workflow, extensive administrative workloads and waiting periods. Upon approval, substantial efforts of data harmonization are required due to inconsistent data structures and labelling conventions, and these efforts are hardly reused.

Designed to enable easier access to research data hosted on data repositories, DataRepExp is intended to address these challenges. The application includes rich metadata and a set of commonly used variables, identified as being of broad interest to dementia research, harmonised using the C-Surv data model, which has been adopted by DPUK, ADDI and DPAU. Researchers can identify data from participants that match certain criteria or interests, using filters at study and participant levels, then explore and conduct preliminary analysis on the filtered results. It also allows users to export aggregated results and then submit one centralised data access application form for multiple cohorts through the DPAU Data Portal.

To be populated to other data repositories, the application can be modified to use relevant discipline-specific metadata schema and common variables.

# Methods
DataRepExp was written using R and JavaScript using the following libraries:
- Shiny: shiny[@R-shiny], shinydashboard[@R-shinydashboard], shinyWidgets, shinyjs
- Data manipulation: dplyr, tidyr, tidyverse, forecasts, useful, magrittr, purrr
- Data Report and Visualisation: ggplot2, plotly, scales, DT, htmltools, fontawesome, RColorBrewer

# Overview
The app layout is split into a side menu, through which the users can navigate through tabs and the main view with various outputs.
- First tab – overview (statement)
- Second tab – Summary Tables (metadata for high-level comparison)
- Third tab – Filters (study level and participant level) and Filter Reports (filters selected and identified studies)
- Fourth tab – Visualisation (basic plots, separated by different domains)
- Fifth tab – Preliminary Analysis (select variables of interest)

Some of the application features are: 
- Simulation: For demonstration purposes, we generate simulated data. Scripts and reference documents used to generate the data can be found in the GitHub repository.
- Modularisation: DataRepExp was built in Shiny modules. Modularity makes the app easy to test, maintain, and deploy.
- Interactive: DataRepExp provides an interactive interface that allows users to engage with the data and output.

# Acknowledgements
DPUK?

# Funding 
This work is supported by a grant from the National Institute of Health (NIH). [Grant number]

# Availability and Community Guidelines
The software is available at the GitHub repository[link]. The GitHub repository also contains the source code for this paper. Users and contributors are welcome to contribute, request features,
and report bugs in this GitHub repository.

# References
