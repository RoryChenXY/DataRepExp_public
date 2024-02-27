#FUNCTIONS####################################################################################
##Pie Chart###################################################################################
PieChart <- function(Data, VAR){#Create a pie chart for one categorical variable in a data frame 
  # Capture the variable name as a quosure for use in dplyr functions
  VAR <- enquo(VAR) 
  
  # Create a new data frame with counts for each level and a new column for the variable name
  tempdata <- Data %>%
    count(!!(VAR))%>%
    mutate(Level = !!(VAR)) # A new column name 'Level'
  
  # Create a colour palette based on the number of levels of the variable
  cpalette <- hcl.colors(nrow(tempdata), palette = "Pastel1")
  
  # Create a pie chart using plotly
  fig <- plot_ly(tempdata, labels = ~Level, values = ~n, type = 'pie',
                 sort = FALSE,
                 textinfo = 'label+percent', # Display the label and percentage for each slice
                 textposition = 'inside',
                 insidetextfont = list(color = '#FFFFFF'),
                 hoverinfo = 'text', # Display the text string on hover
                 text = ~paste('Count:', n),# Set the hover text
                 marker = list(colors = cpalette, # Assign colors to each slice
                               line = list(color = '#FFFFFF', width = 1)),
                 showlegend = TRUE) %>% layout(legend = list(orientation = 'h')) # Set the legend to horizontal
  return(fig) 
}

##Count Factor Levels ########################################################################
countFactor <- function(Data, VAR, VARLEABEL){
  
  VAR <- enquo(VAR)
  
  tempdata <- Data %>%
    count(!!(VAR), name = 'Counts', .drop=FALSE) %>% # .drop=FALSE include counts for empty groups
    mutate(Level = !!(VAR))%>%
    mutate(Attribute = VARLEABEL)%>% 
    select(Attribute, Level, Counts) %>% ## Attribute(Variable), Variable Levels, and Count for each variable
    mutate(Percent = percent(Counts / sum(Counts)))  # Calculate percentage of counts and format as percentage using the percent() function
  
  return(tempdata)
}
##Combined Bar Charts for Multiple Factors ###################################################
CombBar <- function(Data){
  #Used with the countFactor Function to produce combined bar charts for multiple factors
  df <- Data
  
  p <-  ggplot(df, 
               aes(x = Attribute, y = Counts, fill = Level, 
                   text = paste("Count: ", Counts, "<br>Percent: ", Percent))) + # Set the text for tooltip
    geom_bar(stat = 'identity', position = 'dodge', width = 0.5) +
    geom_text(aes(x = Attribute, y = Counts, label= Counts, group = Level),  # Add text labels above the bars (fixed)
              size=3, vjust = -2,
              position = position_dodge(width = .5),
              inherit.aes = TRUE) +
    coord_flip() + # Flip the x and y axis
    scale_fill_brewer(palette="Pastel1") +
    theme(axis.title.x = element_blank(),
          axis.title.y = element_blank()) # Remove x-axis and y-axis label
  fig <- ggplotly(p, tooltip = c("text")) %>% 
    layout(legend = list(title='', orientation = 'h')) # Remove the legend title and set the legend to horizontal
  
  return(fig)
}

## Histogram with group - stack#############################################################################################
HisGroup <- function(Data, VAR, GroupVar){
  VAR <- enquo(VAR)
  GroupVar <- enquo(GroupVar)
  
  p <- Data %>%
    ggplot(aes(x=!!(VAR), fill = !!(GroupVar))) +
    geom_histogram(position = 'stack')+
    scale_fill_brewer(palette = "Pastel1")+ 
    theme(axis.title.x = element_blank(),
          axis.title.y = element_blank())
  
  fig <- ggplotly(p, tooltip = c("Count:", GroupVar)) %>% 
    layout(legend = list(title = list(text = ""), orientation = 'h'))
  return(fig)
}

##Histogram with position option##############################################################
HisOption <- function(Data, VAR, GroupVar, hposition){
  #Inputs: Data - data frame, VAR for x-axis, GroupVar for Group Variables, hposition - position of histogram
  
  # Capture variable names as quosures using the enquo() function from dplyr
  VAR <- enquo(VAR)
  GroupVar <- enquo(GroupVar)
  
  p <- Data %>%
    ggplot(aes(x=!!(VAR), fill = !!(GroupVar))) +
    geom_histogram(position = hposition)+
    scale_fill_brewer(palette = "Pastel1")+ # Use a colour palette from RColorBrewer package
    theme(axis.title.x = element_blank(),
          axis.title.y = element_blank()) # Remove x-axis and y-axis label
  
  ## Convert ggplot object to plotly object
  fig <- ggplotly(p, tooltip = c("Count:", GroupVar)) %>% #Set the tooltip for plotly object
    layout(legend = list(title = list(text = ""), orientation = 'h')) # Remove the legend title and set the legend to horizontal
  return(fig)
}
