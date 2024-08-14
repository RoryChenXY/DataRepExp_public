# Welcome to DataRepExp

The Data Repository Explorer, DataRepExp, is an open-source R Shiny application developed to improve the findability, accessibility, interoperability, and reusability (FAIR) of research data held in a data repository. 

The application displays standardised metadata across multiple studies including data availability by categories (such as demographics, medical history, imaging data and genomic data) to allow high-level comparison. It enables users to explore and run preliminary analysis from participants that match certain criteria. In addition, it provides features to export reports and aggregated results for data access application purposes. 

This demo application was created using simulated health-related data for demonstration purposes. It can be modified and utilized by other data repositories by adopting the discipline-specific metadata schema and common variables.

To simplify the deployment process of the shiny application, the source code was converted to an R package under the [{golem}](https://github.com/ThinkR-open/golem) framework.

-   Repository: <https://github.com/RoryChenXY/DataRepExp_public/>
-   Package Source Code: [{datarepexp}](/datarepexp/)
-   Web Application: <https://rorychenxy.shinyapps.io/DataRepExp/>
-   Contact: [xinyue.chen1\@unsw.edu.au](mailto:%20xinyue.chen1@unsw.edu.au) / [rory.chen.xy\@gmail.com](mailto:%20rory.chen.xy@gmail.com)
-   Paper: [paper.md](/paper/paper.md)

## Deployment

To run the demo app locally, please use the following syntax:

```

devtools::install_github("RoryChenXY/DataRepExp_public", subdir="datarepexp")

library(datarepexp)

datarepexp::repexp_app()

```

## How to navigate the application
The side menu allows you to switch between tabs, and the menu icon on the top allows you to collapse and expand the menu.

![Side Menu](/www/sidemenu.png)

The Summary Tables Tab includes metadata of studies, listed in three tables, and provides a high-level comparison. All tables allow you to search, sort, and filter, and the "CLEAR" button resets the table to its original status.

![Summary Tables Tab](/www/Summary.png)

The Filters Tab includes filters at both the study level and participant level, so that you can adjust and apply filters to identify studies and participants that match the selected criteria. 
The "Clear" buttons reset the filters. The Filters Tab also allows you to review and download the filters you have applied, and the study/studies you have identified in the Filters Report page.

![Filters Tab1](/www/Filter_study.png)
![Filters Tab2](/www/FilterReport.png)

The Visualisation Tab generates results based on the filters you have applied. All plots are organised into sub-tabs by domain.

![Visualisation Tab](/www/VisTab.png)

The Preliminary Analysis Tab generates results based on the filters you have applied. The variable options are separated by categorical and quantitative variables.

![Preliminary Analysi Tab](/www/PA.png)

All plots can be downloaded. They have interactive features such as zoom, select, adjust axis, hover for information, reset, etc.

## Deployment Notes

To make modifications to the applications for your purposes, R and Shiny programming skills are required, as well as an understanding of shiny modules.

1. The application uses both study-level metadata, and particicipant-level data, and a data dictionary. Detail Notes and scripts used to generate data are included in the repository: [Data Preparation Notes](/notes/1_dataprep.md). 
2. DataRepExp was built in Shiny modules. Modularity makes the app easy to test, maintain, and deploy. The features can be easily further expanded with loose coupling module design: [Application Development Notes](/notes/2_app_dev_notes.md).
3. The Data Repository Explorer, DataRepExp, is hosted through easy-to-use [shinyapps.io](https://www.shinyapps.io/),  while the DPAU version is hosted on AWS environment using Shiny Server for high availability, scalability, security, and compliance.  The detailed deployment instructions can be found [here](https://shiny.posit.co/r/deploy.html)
4. I have created a copy of this application that was modified to add two more variables just as a demonstration to set up your own variables: [How to add new variables](/notes/3_add_new_var.md).
5. Considering some repositories may hold highly sensitive data, or individual-level data may not be not available, a metadata-only version DataRepExp has also been developed, and relevant code is included [here](/archive/meta_demo).
6. 

## Acknowledgements
This application was inspired by the visualization tool developed by Dementias Platform UK([DPUK](https://www.dementiasplatform.uk/)) using PowerBI, then developed for the Dementias Platform Australia ([DPAU](https://www.dementiasplatform.com.au/)) in R-Shiny. We acknowledge the generous sharing of best practices and knowledge from DPUK.

## Funding
This work is supported by grants from the National Institute on Aging/ National Institute of Health (NIA/NIH) [1RF1AG057531-01] and the Medical Research Council [MRC/T0333771]. 

## Availability and Community Guidelines
The application and associated documentation are open source (MIT License), but we ask that you kindly acknowledge our work. 
Users and contributors are welcome to contribute, request features, and report bugs through the GitHub repository.



