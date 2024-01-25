setwd(dirname(rstudioapi::getActiveDocumentContext()$path)) #Set work directory
#LIBRARY########################################################################
library(dplyr) #data manipulation
library(tidyverse) #data manipulation
library(simstudy) #Generate simulated data
library(data.table) #Data manipulation

#SEED###########################################################################
set.seed(951823) #Set seed for randomization

#IMPORT FILES###################################################################
load('temp/simmeta.RData')

ppt_dist <- setDT(read.csv('source/ppt_Dist.csv', header = TRUE, fileEncoding='UTF-8-BOM'))#Self defined variable distribution
ppt_Mdist <- setDT(read.csv('source/ppt_MissDist.csv', header = TRUE, fileEncoding='UTF-8-BOM')) #defines the parameters of missing

#FUNCTION#######################################################################
#Assuming studies from same continent will follow similar distribution
#I generate data for each continent first
#Then use the function below to get data for each studies
#Also added some validation - to make sure consistency between metadata and participant level data for each study
Obs_Generator <- function(meta, Obsbank){
  temp <- Obsbank[sample(.N, meta$STUDYSIZE)] #Grab n (Study sample size) from the databank
  temp <- as.data.frame(temp)
  minage <- meta$MINAGE
  newage <- meta$MINAGE + round(abs(rnorm(meta$STUDYSIZE, mean = 0, sd=5))) #min age at recruitment + new age
  
  temp <- temp %>% 
    mutate(YOD = na_if(YOD, DECEASED == 0)) %>% #if not dead, Year of death should be NA
    mutate(YOD = case_when(DECEASED == 1 ~ YODtemp)) %>%
    mutate(STUDY = meta$STUDY, #STUDY name
           ID = paste(meta$STUDY, sprintf("%04d", 1:meta$STUDYSIZE), sep="")) %>%    #Set ID
    mutate(AGEATASS = case_when(min(AGEATASS) <  minage ~ newage, #Make sure Age at assessment >= Study min age at recruitment
                                min(AGEATASS) >= minage ~ AGEATASS)) %>% 
    mutate(SCALE4 = 0.3*AGEATASS + 0.2*ALCSTAT*AGEATASS + 5*abs(SCALE4e)) %>%
    mutate(SCALE4 = case_when(SCALE4 <  100 ~ SCALE4, #Make sure Age at assessment >= Study min age at recruitment
                              SCALE4 >= 100 ~ 100)) %>% 
    mutate(AGEATASS = round(AGEATASS), #Age round
           SCALE1 = round(SCALE1), #Round -scales
           SCALE2 = round(SCALE2),
           SCALE3 = round(SCALE3),
           SCALE4 = round(SCALE4)) %>%
    relocate(c(STUDY,ID), .before = id) %>%
    select(-c(id, YODtemp, SCALE1temp, SCALE4e))
  
  if(meta$cat03 == 0){ #if no medical history data
    temp$DIA1 <- NA
    temp$DIA2 <- NA
    temp$DIA3 <- NA
    temp$DIA4 <- NA
  }
  if(meta$cat04 == 0){ #if no family disease history data
    temp$FAMDIA1 <- NA
    temp$FAMDIA2 <- NA
    temp$FAMDIA3 <- NA
  }
  if(meta$cat05 == 0){ #if no service utilization data
    temp$HOSOUP <- NA
    temp$HOSINP <- NA
    temp$GP <- NA
  }
  if(meta$cat09 == 0){ #if no imaging data
    temp$MRICOLL <- 0
    temp$IMGCOLL1 <- 0
    temp$IMGCOLL2 <- 0
  }
  if(meta$cat10 == 0){ #if no genomic data
    temp$GENO1 <- NA
    temp$GENO2 <- NA
  }
  return(temp)
}

#DATA GENERATION################################################################
#Generate data for each continent first by:
# (1) identify the studies from meta data
# (2) update the variable distribution 
# (3) add some random effect for the distribution
# (4) generate 'data bank' for each continent that follows the same distribution
# (5) using the function defined previously to get data for each studies
##Africa Study##################################################################
Africa_Study <- simmeta %>% 
  filter(CONTINENT == 'Africa') #a list of Africa Studies
sum(Africa_Study$STUDYSIZE) #total sample size

#Update ppt variable distribution manually and with some randomness
Africa_Dist <- ppt_dist
Africa_Dist <- updateDef(Africa_Dist, changevar = 'ETHNICBACK', newformula = '0.01;0.01;0.9;0.07;0.005;0.005')  
Africa_Dist <- updateDef(Africa_Dist, changevar = 'SEX', newformula = '0.56; 0.42; 0.02')
Africa_Dist <- updateDef(Africa_Dist, changevar = 'SMOKESTAT', newformula = '0.2;0.3;0.5')  
Africa_Dist <- updateDef(Africa_Dist, changevar = 'ALCSTAT',   newformula = '0.3;0.1;0.6')
Africa_Dist <- updateDef(Africa_Dist, changevar = 'EDUHIGHS', newformula = '0.3', newvariance = '0.21')
Africa_Dist <- updateDef(Africa_Dist, changevar = 'MARISTAT', newformula = '0.6', newvariance = '0.24')  
Africa_Dist <- updateDef(Africa_Dist, changevar = 'GENO1', newformula = '0.1; 0.1; 0.5; 0.3')
Africa_Dist <- updateDef(Africa_Dist, changevar = 'GENO2', newformula = '0.4; 0.05; 0.01; 0.01;0.01;0.01;0.01; 0.2; 0.3')

AF_randomeffect1 <- runif(11, min=0.9, max=1.1)
AF_formula_old1 <- as.numeric(Africa_Dist$formula[21:31])
AF_formula_new1 <- AF_formula_old1 * AF_randomeffect1
AF_variance_new1 <- AF_formula_new1*(1-AF_formula_new1)
Africa_Dist$formula[21:31] <- AF_formula_new1
Africa_Dist$variance[21:31] <- AF_variance_new1

#Update missing distribution with some randomness
Africa_MDist <- ppt_Mdist
AF_randomeffect2 <- runif(31, min=0.23, max=1.85)
AF_formula_old2 <- as.numeric(Africa_MDist$formula)
AF_formula_new2 <- AF_formula_old2 * AF_randomeffect2
Africa_MDist$formula <- AF_formula_new2

#Generating the Africa data pool
Africa_gen  <- genData(20000, Africa_Dist) 
Africa_MissMat <- genMiss(Africa_gen, Africa_MDist, idvars = "id")
Africa_Obs <- genObs(Africa_gen, Africa_MissMat, idvars = "id") 

#Get data for each Africa Study
Africa_Obs_all <- data.frame() 
a <- 1
for (i in 1:nrow(Africa_Study)) {
  x <- Africa_Study[i,]
  N <- x$STUDYSIZE
  b <- a+N+1000
  y <- Obs_Generator(x, Africa_Obs[a:b,] )
  a <- b+1
  
  Africa_Obs_all <- rbind(Africa_Obs_all, y)
}


##Asia Study####################################################################
Asia_Study <- simmeta %>% 
  filter(CONTINENT == 'Asia') #a list of Asia Studies
sum(Asia_Study$STUDYSIZE) #total sample size

#Update ppt variable distribution manually and with some randomness
Asia_Dist <- ppt_dist
Asia_Dist <- updateDef(Asia_Dist, changevar = 'ETHNICBACK', newformula = '0.01;0.9;0.01;0.07;0.005;0.005')  
Asia_Dist <- updateDef(Asia_Dist, changevar = 'SEX', newformula = '0.59; 0.4; 0.01')
Asia_Dist <- updateDef(Asia_Dist, changevar = 'SMOKESTAT', newformula = '0.1;0.3;0.6')  
Asia_Dist <- updateDef(Asia_Dist, changevar = 'ALCSTAT',   newformula = '0.2;0.1;0.7')
Asia_Dist <- updateDef(Asia_Dist, changevar = 'EDUHIGHS', newformula = '0.4', newvariance = '0.24')
Asia_Dist <- updateDef(Asia_Dist, changevar = 'MARISTAT', newformula = '0.7', newvariance = '0.21')  
Asia_Dist <- updateDef(Asia_Dist, changevar = 'GENO1', newformula = '0.4; 0.1; 0.2; 0.3')
Asia_Dist <- updateDef(Asia_Dist, changevar = 'GENO2', newformula = '0.05; 0.01; 0.01;0.01;0.01;0.01; 0.4;0.3;0.2')

Asia_randomeffect1 <- runif(11, min=0.85, max=1.05)
Asia_formula_old1 <- as.numeric(Asia_Dist$formula[21:31])
Asia_formula_new1 <- Asia_formula_old1 * Asia_randomeffect1
Asia_variance_new1 <- Asia_formula_new1*(1-Asia_formula_new1)
Asia_Dist$formula[21:31] <- Asia_formula_new1
Asia_Dist$variance[21:31] <- Asia_variance_new1

#Update missing distribution with some randomness
Asia_MDist <- ppt_Mdist
Asia_randomeffect2 <- runif(31, min=0.8, max=1.3)
Asia_formula_old2 <- as.numeric(Asia_MDist$formula)
Asia_formula_new2 <- Asia_formula_old2 * Asia_randomeffect2
Asia_MDist$formula <- Asia_formula_new2

#Generating the Asia data pool
Asia_gen  <- genData(20000, Asia_Dist) 
Asia_MissMat <- genMiss(Asia_gen, Asia_MDist, idvars = "id")
Asia_Obs <- genObs(Asia_gen, Asia_MissMat, idvars = "id") 

#Get data for each Asia Study
Asia_Obs_all <- data.frame() 
a <- 1
for (i in 1:nrow(Asia_Study)) {
  x <- Asia_Study[i,]
  N <- x$STUDYSIZE
  b <- a+N+1000
  y <- Obs_Generator(x, Asia_Obs[a:b,] )
  a <- b+1
  Asia_Obs_all <- rbind(Asia_Obs_all, y)
}

##Caucasian Study####################################################################
Cau_Study <- simmeta %>% 
  filter(CONTINENT %in% c('Europe', 'North America', 'Oceania')) 
sum(Cau_Study$STUDYSIZE) #total sample size
Cau_Dist <- ppt_dist
Cau_MDist <- ppt_Mdist
#Generating the Caucasian data pool
Cau_gen  <- genData(65000, Cau_Dist) 
Cau_MissMat <- genMiss(Cau_gen, Cau_MDist, idvars = "id")
Cau_Obs <- genObs(Cau_gen, Cau_MissMat, idvars = "id") 

#Get data for each Cau Study
Cau_Obs_all <- data.frame() 
a <- 1
for (i in 1:nrow(Cau_Study)) {
  x <- Cau_Study[i,]
  N <- x$STUDYSIZE
  b <- a+N+1000
  y <- Obs_Generator(x, Cau_Obs[a:b,] )
  a <- b+1
  
  Cau_Obs_all <- rbind(Cau_Obs_all, y)
}

##South America Study####################################################################
SouthA_Study <- simmeta %>% 
  filter(CONTINENT == 'South America') #a list of South America Studies
sum(SouthA_Study$STUDYSIZE) #total sample size

#Update ppt variable distribution manually and with some randomness
SouthA_Dist <- ppt_dist
SouthA_Dist <- updateDef(SouthA_Dist, changevar = 'ETHNICBACK', newformula = '0.03;0.01;0.05;0.9;0.005;0.005')  
SouthA_Dist <- updateDef(SouthA_Dist, changevar = 'SEX', newformula = '0.42; 0.56; 0.02')
SouthA_Dist <- updateDef(SouthA_Dist, changevar = 'SMOKESTAT', newformula = '0.1;0.2;0.7')  
SouthA_Dist <- updateDef(SouthA_Dist, changevar = 'ALCSTAT',   newformula = '0.2;0.1;0.7')
SouthA_Dist <- updateDef(SouthA_Dist, changevar = 'EDUHIGHS', newformula = '0.4', newvariance = '0.24')
SouthA_Dist <- updateDef(SouthA_Dist, changevar = 'MARISTAT', newformula = '0.4', newvariance = '0.24')  
SouthA_Dist <- updateDef(SouthA_Dist, changevar = 'GENO1', newformula = '0.5; 0.1; 0.1; 0.3')
SouthA_Dist <- updateDef(SouthA_Dist, changevar = 'GENO2', newformula = '0.05; 0.01; 0.01;0.4;0.2; 0.3;0.01;0.01;0.01')

SouthA_randomeffect1 <- runif(11, min=0.85, max=1.05)
SouthA_formula_old1 <- as.numeric(SouthA_Dist$formula[21:31])
SouthA_formula_new1 <- SouthA_formula_old1 * SouthA_randomeffect1
SouthA_variance_new1 <- SouthA_formula_new1*(1-SouthA_formula_new1)
SouthA_Dist$formula[21:31] <- SouthA_formula_new1
SouthA_Dist$variance[21:31] <- SouthA_variance_new1

#Update missing distribution with some randomness
SouthA_MDist <- ppt_Mdist
SouthA_randomeffect2 <- runif(31, min=0.5, max=1.5)
SouthA_formula_old2 <- as.numeric(SouthA_MDist$formula)
SouthA_formula_new2 <- SouthA_formula_old2 * SouthA_randomeffect2
SouthA_MDist$formula <- SouthA_formula_new2

#Generating the SouthA data pool
SouthA_gen  <- genData(20000, SouthA_Dist) 
SouthA_MissMat <- genMiss(SouthA_gen, SouthA_MDist, idvars = "id")
SouthA_Obs <- genObs(SouthA_gen, SouthA_MissMat, idvars = "id") 

#Get data for each SouthA Study
SouthA_Obs_all <- data.frame() 
a <- 1
for (i in 1:nrow(SouthA_Study)) {
  x <- SouthA_Study[i,]
  N <- x$STUDYSIZE
  b <- a+N+1000
  y <- Obs_Generator(x, SouthA_Obs[a:b,] )
  a <- b+1
  
  SouthA_Obs_all <- rbind(SouthA_Obs_all, y)
}

#All ppt data#################################################################################################
ppt_all <- rbind(Africa_Obs_all, Asia_Obs_all, Cau_Obs_all, SouthA_Obs_all) %>%
  arrange(STUDY)

col_order <- c("STUDY", "ID", 
               "ETHNICBACK", "SEX", "EDUHIGHS", "MARISTAT",
               "AGEATASS", "DECEASED", "YOD", 
               "SMOKESTAT", "ALCSTAT", "BMI",
               "SCALE1", "SCALE2", "SCALE3", "SCALE4",
               "DIA1", "DIA2", "DIA3", "DIA4",
               "HOSOUP", "HOSINP", "GP",
               "FAMDIA1", "FAMDIA2", "FAMDIA3",
               "MRICOLL", "IMGCOLL1", "IMGCOLL2", 
               "GENO1", "GENO2")    
ppt_all <- ppt_all[, col_order]
summary(ppt_all)

#SAVE DATA######################################################################
save(simmeta, ppt_all, file = 'temp/simdatatemp.RData')
#load('temp/simdatatemp.RData')


