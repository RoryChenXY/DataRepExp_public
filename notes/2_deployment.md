# Application Deployment Notes

To modify and use the non-simulated data:
1. Prepare data
   - a data frame contains study-level metadata
   - a data frame contains participant-level data
   - a data frame contains all variable information, data dictionary
   - All categorical data should be converted to factors, consider 'NA' as a level for filtering purposes

2. Modify the syntax
    -  Modularity makes the app easy to test, maintain, and deploy.
    -  Modify individual modules and run each module as a mini-app.
    -  The filter tab is 'hard-coded' for each field, will look into a better solution.
   


# Future Improvement Ideas
1. Filter builder: instead of listing all filters, users can select and add any filter of interests
2. Plots options: allow users to select different plot types
3. Analysis: introduce some basic statistics models in the Preliminary Analysis Tab
