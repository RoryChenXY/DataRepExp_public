# This is an example of data preparation for adding a new study-level variable ##############################

#data manipulation
library(dplyr) 

# Load data######################################################################
load("data/simdata.RData")

# Update the Metadata data frame
simmeta_new <- simmeta
simmeta_new$cat16 <- rbinom(30, 1, 0.5) #New Variable

studymeta_new <- studymeta %>% 
  mutate(cat16 = factor(simmeta_new$cat16, levels = c(0,1), labels = c('No', 'Yes')))

# Update the Participant dataframe
ppt_all_new <- ppt_all

set.seed(1823)            
mmse_temp <- rpois(85506, 24)
ppt_all_new$MMSE <- mmse_temp

is.na(ppt_all_new$MMSE) <- (ppt_all_new$MMSE > 30 | ppt_all_new$MMSE < 0)

ppt_all_fc_new<- ppt_all_fc
ppt_all_fc_new$MMSE <- ppt_all_new$MMSE

# Update the Variable Information data frame
newrow1 <- VAR_info[24,] %>%
  mutate(VARNAME = 'cat16',
         LABELS = 'OtherF')

newrow2 <- VAR_info[42,] %>%
  mutate(VARNAME = 'MMSE',
         LABELS =  'MMSE', 
         RANGE = '0-30',
         MINVALUE = 0,
         MAXVALUE = 30)

newrow3 <- VAR_info[43,] %>%
  mutate(VARNAME = 'MMSEMISS',
         LABELS =  'MMSE Include Missing')

VAR_info_new <- rbind(VAR_info[1:24,], newrow1, VAR_info[-(1:24),], newrow2, newrow3)
row.names(VAR_info_new) <- NULL

# save(simmeta_new, studymeta_new, ppt_all_new, ppt_all_fc_new, VAR_info_new, file = 'simdata_new.RData')
# load('data/simdata_new.RData')