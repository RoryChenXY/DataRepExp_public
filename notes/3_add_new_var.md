# How to add new variables

I have created a copy of this application that was modified to add two more variables.
The relevant syntax can be found [here](/archive/addvar).
All changes made in the R files compared to the original version were commented with ‘#!UPDATES#’.


1.	Update the data. [Syntax](/archive/addvar/data/dataprep_newvar.R)

  	Added a categorical variable ‘OtherF’ to the study-level metadata.

  	Added a numeric variable ‘MMSE’ to the participant-level data

  	Update relevant Variable Information in the 'VAR_info_new' data frame.
  	

2.	Tab 1 – No changes
3.	Tab 2 – Update the output file to include the new variables. [Syntax](/archive/addvar/R/tab2_output_new.R)
4.	Tab 3 – Add new filters. [Syntax](/archive/addvar/R/tab3_filters_module_new.R)
5.	Tab 4 - No changes
6.	Tab 5 – Add new variables to the list. [Syntax](/archive/addvar/R/tab5_pac_module_new) and [Syntax](/archive/addvar/R/tab5_paq_module_new)



