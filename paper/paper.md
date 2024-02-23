---
title: 'DataRepExp: a R shiny Application that makes Data FAIR for Data Repositories'
tags:
  - R
  - Shiny
  - dashboard
  - repository
  - visualisation
  - FAIR
authors:
  - name: Rory Chen
    orcid: 0000-0002-2094-2682
    affiliation: 1 
  - name: Vibeke S Catts
    affiliation: 1
  - name: Ashleigh Vella
    affiliation: 1
  - name: Juan Carlo San Jose
    affiliation: 2
  - name: Sarah Bauermeister
    affiliation: "3, 4"
  - name: Josh Bauermeister
    affiliation: "3, 4"
  - name: Emma Squires
    affiliation: "3, 5"
  - name: Simon Thompson
    affiliation: "3, 5"
  - name: John Gallacher
    affiliation: "3, 4"
  - name: Perminder S. Sachdev
    affiliation: 1  
affiliations:
 - name: Centre for Healthy Brain Ageing, Discipline of Psychiatry & Mental Health, School of Clinical Medicine, University of New South Wales, Sydney, Australia
   index: 1
 - name: Research Technology Services, University of New South Wales, Sydney, Australia
   index: 2
 - name: Dementias Platform UK, Oxford, United Kingdom
   index: 3
 - name: Department of Psychiatry, University of Oxford, Oxford, United Kingdom
   index: 4
 - name: Population Data Science, Swansea University, Swansea, United Kingdom
   index: 5
date: 23 Feburary 2024
bibliography: paper.bib

---

# Summary

The Data Repository Explorer, DataRepExp, is an open-source R Shiny application developed to improve the findability, accessibility, interoperability, and reusability (FAIR) [@FAIR] of research data hosted on  a data repository. 
The application displays standardised metadata across multiple studies including data availability by categories (such as demographics, medical history, imaging data and genomic data) to allow high-level comparison. It enables users to explore and run preliminary analysis from participants that match certain criteria. In addition, it provides features to export reports and aggregated results for data access application purposes.
The application was initially developed for a discipline-specific data-sharing platform, the Dementias Platform Australia (DPAU) [@DPAU]. Envisioning this work could be utilized by other data repositories, this demo application was created using simulated health-related data for demonstrating purposes, can be populated to other data repositories in diverse disciplines.
Source Code: https://github.com/RoryChenXY/DataRepExp_public 
Web Application: https://rorychenxy.shinyapps.io/DataRepExp/ 
Contact: xinyue.chen1@unsw.edu.au


# Statement of need

Data repositories have become increasingly important in recent years as more emphasis has been placed on open science practices and data sharing. By making data publicly available through repositories, researchers can ensure data persistence and support data preservation, as well as facilitate the reuse of their data, thereby increasing the potential for new scientific discoveries. However, challenges exist for data findability, accessibility, interoperability, and reusability (FAIR) [2].
Even though most data repositories have adopted various metadata schemas to describe the dataset [3], it is increasingly a challenge for researchers to find relevant data that meet research interests or needs [4]. For multi-study research, applying to access different datasets usually comes with diverse and complicated data-sharing requirements and workflows, extensive administrative workloads and waiting periods. Upon approval, substantial efforts of data harmonization are usually required due to inconsistent data structures and labelling conventions, and harmonised dataset are hardly reused. We found that many data repositories do not provide comprehensive metadata, nor centralised tables for comparison. With repositories that provide data visualisation, Power BI and Tableau were commonly used but cost occurs. R-shiny could provide more flexibility and functions with a fraction of the cost.
Designed to enable easier access to research data hosted on data repositories, DPAU `[@DPAU]` seeks to address these challenges with R-Shiny. The application designed for DPAU includes rich metadata and a set of commonly used variables [5], identified as being of broad interest to dementia research, harmonised using the C-Surv data model [6], which has been developed by Dementias Platform UK (DPUK) [7], and adopted by Alzheimer’s Disease Data Initiative (ADDI) [8] and DPAU [1]. Researchers can identify data points from participants that match certain criteria, using filters at study and/or participant levels, then explore and conduct preliminary analysis on the filtered dataset. It allows users to export reports and aggregated results. The exported reports can then be used when submitting a single centralised data access application form for accessing data from multiple studies through the DPAU Data Portal [9].
DataRepExp was created with simulated data and a list of generalized health-related variables. This work can be modified and utilized by other data repositories by adopting the discipline-specific metadata schema and common variables. With rich metadata for findability, interactive visualization dashboard for accessibility, standardization and harmonization for data interoperability and reusability, this tool can improve the FAIR of research data hosted on a data repository. R programming skill is required for reproducibility, detailed documentation and syntax is open-source and publicly available.


# Methods

DataRepExp was written using R [@R-base] and JavaScript using the following libraries:

-  Shiny: shiny [@R-shiny], shinydashboard [@R-shinydashboard], shinyWidgets [@R-shinyWidgets], shinyjs [@R-shinyjs].
-  Data manipulation: dplyr [@R-dplyr], tidyr [@R-tidyr], tidyverse [@R-tidyverse], forcats [@R-forcats], useful [@R-useful], magrittr [@R-magrittr], purrr [@R-purrr].
-  Data Report and Visualisation: ggplot2 [@R-ggplot2], plotly [@R-plotly], scales [@R-scales], DT [@R-DT], htmltools [@R-htmltools], fontawesome [@R-fontawesome].

# Overview

The application layout features a side menu, through which the users can navigate through tabs, and the main view which displays the content of the selected tab (Figure 1).
-  First tab – Overview: includes statement and navigation instructions.
-  Second tab – Summary Tables: three metadata tables for high-level comparison
-  Third tab – Filters and Filter Reports: users can adjust and apply filters to identify participants and studies that match selected criteria. Then download Filter Report with the list of studies that matched the filters selected.
-  Fourth tab – Visualisation: plots organised by different domains, generated using filtered dataset.
-  Fifth tab – Preliminary Analysis: run preliminary analysis with user-selected variables

Application features include:
-  Simulation: For demonstration purposes, we generate simulated data. Scripts and reference documents used to generate the data can be found in the GitHub repository.
-  Modularisation: DataRepExp was built in Shiny modules. Modularity makes the app easy to test, maintain, and deploy. The features can be easily further expanded with loose coupling module design.
-  Interactive: DataRepExp provides an interactive interface that allows users to engage with the data and output. Elevated user experience with integrative charts and figures, which include functions such as sort, filter, zoom, select, adjust axis, hover for information, reset, etc.

## Deployment

The Data Repository Explorer, DataRepExp, the demo app is hosted through easy-to-use shinyapps.io while the DPAU version is hosted on AWS environment using Shiny Server for high availability, scalability, security, and compliance.

# Acknowledgements

This application was previously inspired by the visualisation tool developed by Dementias Platform UK (DPUK) using PowerBI, then developed in R-Shiny for the Dementias Platform Australia (DPAU).

# Funding
This work is supported by a grant from the National Institute on Aging/ National Institute of Health (NIA/NIH). [1RF1AG057531-01 ]

# Availability and Community Guidelines
The application and source code are available at the GitHub repository [https://github.com/RoryChenXY/DataRepExp_public]. Users and contributors are welcome to contribute, request features, and report bugs through the GitHub repository.

# References
