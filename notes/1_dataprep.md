# Data Preparation
For demonstration purposes, we generate simulated data.
Code and reference documents used to generate the data can be found in [here](/dataprep/)

## Data frame
For this application, I created 5 data frames. To populate this application for your purpose, similar data frames are required.

1.	'VAR_info'

  	This is a data frame that contains all variable information used in this application. Including variable name, variable label, category (metadata or participant-level data),  variable types,  value range, the minimum and maximum value for numeric variables.
2.	‘ppt_all’ and ‘ppt_all_fc’

    ‘ppt_all’ is a file containing all participant-level data across studies, where all categorical variables were converted to numeric variables. For instance, ‘No, Yes’ was coded as ‘0, 1’.

    ‘ppt_all_fc’ is a duplicate of ‘ppt_all’, but all categorical variables were converted to factor variables.

  	The example syntax I used is:
  	```
     … %>% mutate(across(c(SMOKESTAT,ALCSTAT), ~factor(.,levels = c(1,2,3), labels = c('Never', 'Ex', 'Current'))))
    ```

    Also, note that NA values of factors were converted to NA level to control the display using the following syntax:
  	```
    … %>% mutate(across(c(ETHNICBACK, SEX, EDUHIGHS, MARISTAT, DECEASED), ~ fct_na_value_to_level(.x, level = 'Missing')))
    ```

3.	‘simmeta’ and ‘studymeta’
   
    Similarly, ‘simmeta’ is a data frame that contains all study-level data, where all categorical variables were converted to numeric variables.
  	
    And ‘studymeta’ is a duplicate of ‘simmeta’ with all categorical variables converted to factor variables.

## Data Simulation Notes

### Metadata Simulation
1. First, use `stringi::stri_rand_lipsum` to generate random lorem ipsum text, separate strings by punctuation, and get a list of study full names. (n=30)
2. Continents, countries, and country income level data source: [worldbank](https://datatopics.worldbank.org/world-development-indicators/the-world-by-income-and-region.html)
3. Take random samples from the list of countries, grouped by continent.
4. Use `simstudy::genData` to generate data based on self-defined distribution.

### Participant-Level Data Simulation
1. Assuming studies from the same continent will follow a similar distribution.
2. Define variable distribution and missing patterns for one continent first
3. For each continent, update the distribution and missing patterns both manually and with some randomness
4. For each continent, generate a data pool using the updated distribution
5. Define a function to take a random sample from the above data pool for each study, and data validation to ensure the consistency between metadata and participant-level data for each study
6. Combine data for each study into one

### Preparing the data for the explorer
1. Set the factor levels properly
2. For both metadata and participants level data, create two copies - one with factor, another remains numerical for different visualisation purposes.
3. Create a data frame with all variable information

## Resources
The `simstudy` package was used to generate the simulated data.


