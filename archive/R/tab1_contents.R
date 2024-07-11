##Tab1 Overview Contents######################################################################
tab1overview <- fluidPage(
  h1('Data Visualisation Tool for Data Repositories.'),
  h2('This R-shiny app was developed to improve the findability, accessibility, interoperability and reusability (FAIR) of research data. 
      Data custodians can display the availability of data categories across multiple research studies.  
      The app enables researchers to explore and visualise data from participants that 
      match certain criteria or interests, 
      which are applied using filters at study and participant levels.  
      Simulated data are used for demonstration purposes.
      The development of this app is described in Chen et al. [citation]. 
      The scripts are open source, but we ask that you kindly acknowledge our work.'),
  h1('How to navigate the application.'),
  h3('The side menu allows you to switch between tabs, 
      and the menu icon on the top allows you to collapse and expand the menu.'),
  fluidRow(img(src="sidemenu.png", width=300)),
  br(),
  h3('The Summary Tables Tab includes metadata of studies, listed in three tables, and provides a high-level comparison. 
      All tables allow you to search, sort, and filter, and the "CLEAR" button resets the table to its original status.'),
  fluidRow(img(src="Summary.png", width=900)),
  br(),
  h3('The Filters Tab includes filters at both study level and participant level,
      so that you can adjust and apply filters to identify studies and participants that 
      match the selected criteria. The "Clear" buttons reset the filters.
      The Filters Tab also allows you to review and download the filters you have 
      applied, and the study/studies you have identified in the Filters Report page.'),
  fluidRow(img(src="Filter_study.png", width=900)),
  fluidRow(img(src="FilterReport.png", width=900)),
  h3('The Visualisation Tab generates results based on the filters you have applied.
      All plots are organised into sub-tabs by domain.'),
  fluidRow(img(src="VisTab.png", width=900)),
  h3('The Preliminary Analysis Tab generates results based on the filters you have applied. 
      The variable options are separated by categorical and quantitative variables.'),
  fluidRow(img(src="PA.png", width=900)),
  h3('All plots can be downloaded. 
      They have interactive features such as zoom, select, adjust axis, hover for information, reset, etc. ')
)
