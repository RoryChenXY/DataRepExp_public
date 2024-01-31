# Application Development NOTES

## Basic App

1. Create the file 'app.R' that includes the basic structure of the DataRepExp app (5 tabs)
2. Create a copy in '\archive\basicapp' folder for future testing purposes (no data contained)

## Tab 1 Overview
1. Create '.\R\tab1_contents.R' for Tab 1 - Overview Statement Contents
2. Update 'app.R' to source the tab1_contents

## Tab 2 Summary Tables 
1. Create '.\R\tab2_layout.R' for Tab 2 Summary Tables Tab UI/layout
2. Create '.\R\tab2_output.R' for Tab 2 Summary Tables Tab output
3. Update 'app.R' to source tab2 contents
    - Load data
    - Load Libraries
    - First, just include the summary text (Number of studies and participants)
    - Add first summary table - study metadata
    - Add DT options to improve the look of the table
    - Add second summary table - data availability
    - Add third summary table - harmonised variable availability
    - Add formatting and notes
    

## Tab 3 Filters

1. Create '.\R\tab3_filters_module.R' with a basic module structure, one testing filter, and one string to display the filtered results.
2. Update 'app.R' to utilise the simple module
3. Update '.\R\tab3_filters_module.R' for study metadata filters
    - Create a self-defined function for inputs with only No/Yes options: my_yn_inputs
    - Update module UI for the metadata filter inputs
    - Apply the metadata filters:
      - Self-defined function: my_factor_filter; 
      - purrr::reduce2 to iterate over each filter;
      - Apply other filters
    - Add a reset button for study metadata filters with shinyjs
    
4. Update '.\R\tab3_filters_module.R' for Participant filters   
    - Update the module UI - tabPanel for Participant Filters tab
    - Create a self-defined function for inputs with only No/Yes/Missing options: my_ynm_inputs
    - Add the actual Participant Filters
    - Apply the Participant filters

5. Add a button to clear all filters
6. Apply filters from both tabs. 
7. Update for Filter Report tab
    > Update the module UI - tabPanel for Filters Report tab
    > Filtered Study metadata table
      > Based on the filtered results, display the study metadata of filtered results
      > List all filters selected (compare inputs with default values)


## Tab 4 Visualisation

1. Update '.\R\tab3_filters_module.R' to return the reactive filtered results
2. Update 'app.R' to pass the filtered results to the tab 4 module
3. Create '.\R\tab4_visual_module.R' with a basic module structure and UI layout with different sub-tabs.
4. Create '.\R\vis_functions.R' for self-defined visualisations
5. Create plots for each harmonised variable of interests 

## Tab 5 Preliminary Analysis Tab

1. Update 'app.R' to set two sub-tabs for Quantitative and categorical Outcomes.
2. Create '.\R\tab5_paq_module.R':
    - Create a basic module structure and UI layout with different sub-tabs.
    - Inputs - allow the user to select variables
    - Validation - check filtered results and selected variable
    - Set Layout and generate content for each tab
    
3. Similarly, Create '.\R\tab5_pac_module.R'

    


