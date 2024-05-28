#LIBRARY########################################################################
library(dplyr) #data manipulation
library(tidyverse) #data manipulation

library(stringi) #String manipulation
library(stringr) #String manipulation

library(simstudy) #Generate simulated data
library(data.table) #Data manipulation

#SEED###########################################################################
set.seed(951823) #Set seed for randomization
#IMPORT FILES###################################################################
Ctry_Cont <- read.csv("data-raw/source/Countries_Continents.csv", header = TRUE) #Countries and Continent
Ctry_income <- read.csv("data-raw/source/income_groups.csv", header = TRUE) #Countries and income groups
#Set the distribution
Ava_dist <- setDT(read.csv("data-raw/source/AvailabilityDist.csv", header = TRUE, fileEncoding="UTF-8-BOM")) #Self defined metadata distribution
#METADATA GENERATOR#############################################################

##Generate Study name###########################################################
###DO NOT RERUN START###########################################################
#stri_rand_lipsum CANNOT guarantee the same results even with set seed
#Save the result and DO NOT re-run this section
# lit <- stri_rand_lipsum(2) %>%  #Generates (pseudo)random lorem ipsum text
#   stri_split_regex( "\\p{Punct}", omit_empty=TRUE) #Separate string by punctuation
# studyname <- paste(lit[[1]], lit[[2]]) %>%
#   trimws("l") %>% #remove leading spaces
#   str_to_title() #convert first letter to uppercase
# studyname <- studyname[str_detect(studyname, " ")] #Remove study name with only one word
# ##Generate Study Acronyms
# studyacr <- abbreviate(studyname, minlength = 3, use.classes = TRUE,
#                        dot = FALSE, strict = FALSE,
#                        method = c("left.kept", "both.sides"), named = TRUE)
# metatemp <- data.frame(STUDY = 1:30)
# metatemp$STUDY <- studyacr
# metatemp$FULLNAME <- studyname
# save(metatemp, file = "source/metatemp.RData")
###DO NOT RERUN END#############################################################

###Load the generated study name################################################
#load("source/metatemp.RData")

##CONTINENT, COUNTRY, INCOMEGROUP###############################################
Ctry_Cont_Inc <- merge(Ctry_Cont, Ctry_income, by="Country", ) #word bank data
Ctry_sample <- Ctry_Cont_Inc %>%
  group_by(Continent) %>%
  sample_n(size = 5)

simmeta <- cbind(metatemp, Ctry_sample[, c("Continent", "Country", "IncomeGroup")])

##Other metadata################################################################
simmeta$ACCESS <- rbinom(30, 1, 0.85) #Data can be accessed through Repository
simmeta$STUDYFOLLOW <- rbinom(30, 1, 0.7) #Follow up data available
simmeta$MINAGE <- sample(c(18,18,18,21,25,30,35,40,60,65,70,75,80), 30, replace=T) #Minimum data at recruitment
simmeta$STUDYSIZE <- sample(500:5000, 30, replace=T) #Sample Size

##Some formatting###############################################################
simmeta <- simmeta %>%
  rename_all(toupper) %>%
  arrange(STUDY)
col_order <- c("STUDY", "FULLNAME", "ACCESS", "STUDYFOLLOW",
               "CONTINENT", "COUNTRY", "INCOMEGROUP",
               "MINAGE", "STUDYSIZE")
simmeta <- simmeta[, col_order]
simmeta <- simmeta[, 1:9]
##Data Availability by categories###############################################
Ava <- genData(30, Ava_dist)
simmeta <- cbind(simmeta,Ava) %>% select(-id)
#SAVE DATA######################################################################
save(simmeta, file = "data-raw/temp/simmeta.RData")


