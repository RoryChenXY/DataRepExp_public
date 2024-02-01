# Welcome to DataRepExp

Data Repository Explorer, DataRepExp is an Open-Source R Shiny app developed to improve the findability, accessibility, interoperability, and reusability (FAIR) of research data hosted on a data repository.

This application was inspired by the visualization tool developed by [Dementias Platform UK](https://www.dementiasplatform.uk/) using PowerBI. 
While it was developed for the [Dementias Platform Australia](https://www.dementiasplatform.com.au/), it can be adapted and utilised by other data repositories.


With this app, data repositories can display standardized metadata including the availability of data across multiple research studies. It provides an interactive data visualization tool for some commonly used variables in the field, allowing researchers to explore and visualize data from participants that match certain criteria, which are applied using filters at both study and participant levels. 

Simulated data are used for demonstration purposes.

The demo app can be found here: https://rorychenxy.shinyapps.io/DataRepExp/

Paper: [paper.md](/paper)

Development Notes and how to make modifications for your purposes: [Notes](/notes)

The application and associated documentation are open source (MIT License), but we ask that you kindly acknowledge our work. 


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
