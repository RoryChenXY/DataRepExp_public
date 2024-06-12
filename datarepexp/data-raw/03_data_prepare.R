
# The first file generated lorem ipsum study names and simulated metadata
rstudioapi::navigateToFile("data-raw/01_meta_simulation.R")
# The second file generated individual level data
rstudioapi::navigateToFile("data-raw/02_ppt_simulation.R")

# The third file prepare the data for the application
load("data-raw/temp/simdatatemp.RData")

# Set factors levels
studymeta <- simmeta %>%
  mutate(across(c(ACCESS,STUDYFOLLOW), ~factor(.,levels = c(0,1), labels = c("No", "Yes")))) %>%
  mutate(across(cat01:cat15, ~factor(.,levels = c(0,1), labels = c("No", "Yes")))) %>%
  mutate(INCOMEGROUP = factor(INCOMEGROUP, levels = c("Low income", "Lower middle income", "Upper middle income", "High income"))) %>%
  mutate(across(c(CONTINENT, COUNTRY), as.factor)) %>%
  arrange(CONTINENT)

ppt_all_fc <- ppt_all %>%
  mutate(ETHNICBACK = factor(ETHNICBACK, levels = c(1,2,3,4,5,6,7), labels = c("Caucasian", "Asian", "African","Hispanic","Indigenous","Mixed","Other")),
         SEX        = factor(SEX, levels = c(1,2,3), labels = c("Male", "Female", "Other"))) %>%
  mutate(across(c(SMOKESTAT,ALCSTAT), ~factor(.,levels = c(1,2,3), labels = c("Never", "Ex", "Current")))) %>%
  mutate(across(c(MARISTAT, EDUHIGHS, DECEASED, DIA1:IMGCOLL2), ~factor(.,levels = c(0,1), labels = c("No", "Yes")))) %>%
  mutate(GENO1 = factor(GENO1, levels = c(1,2,3,4), labels = c("TypeA", "TypeB", "TypeC","TypeD")),
         GENO2 = factor(GENO2, levels = c(1,2,3,4,5,6,7,8,9), labels = c("G1", "G2", "G3", "G4", "G5", "G6","G7", "G8", "G9"))) %>%
  mutate(across(c(ETHNICBACK, SEX, EDUHIGHS, MARISTAT, DECEASED, SMOKESTAT,ALCSTAT, DIA1:FAMDIA3, GENO1:GENO2), ~ fct_na_value_to_level(.x, level = "Missing")))


# Create a data frame with variable name, type and variable labels
metaVAR_info <- data.frame(VARNAME = 1:24)
metaVAR_info$VARNAME <- colnames(studymeta)
metaVAR_info$LABELS  <- c("Study", "Full Name",
                          "Available through Repository", "Follow-up Data Available",
                          "Continent", "Country", "Country Income Level",
                          "Min Age at Recruitment", "Sample Size",
                          "Administration", "Demographics", "Medical History", "Family History of Diseases","Service Utilisation",
                          "Hospital Data", "Survey Data",  "Linkage Data", "Imaging","Genomic",
                          "OtherA","OtherB","OtherC","OtherD","OtherE")
metaVAR_info$PM <- "Metadata"
metaVAR_info$TYPE <- sapply(studymeta, class)
metaVAR_info$RANGE <- sapply(studymeta, levels)
metaVAR_info$RANGE[1] <- paste0(studymeta$STUDY, collapse = ", ")
metaVAR_info$MINVALUE <- NA
metaVAR_info$MAXVALUE <- NA
metaVAR_info$RANGE[c(8,9)] <- c("0-100", "500-5000")
metaVAR_info$MINVALUE[c(8,9)] <- c(0,500)
metaVAR_info$MAXVALUE[c(8,9)] <- c(100,5000)

pVAR_info <- data.frame(VARNAME = 1:31)
pVAR_info$VARNAME <- colnames(ppt_all_fc)
pVAR_info$LABELS  <- c("Study", "ID",
                       "Ethnic Background", "Sex", "High School Educated", "Married/De-facto",
                       "Age at Assessment", "Deceased", "Year of Death",
                       "Smoking Status", "Alcohol Use Status", "BMI",
                       "Scale 1", "Scale 2", "Scale 3", "Scale 4",
                       "Disease Diagnosis 1", "Disease Diagnosis 2", "Disease Diagnosis 3", "Disease Diagnosis 4",
                       "Hospital Outpatient", "Hospital Inpatient", "GP",
                       "Family History of Diagnosis 1", "Family History of Diagnosis 2", "Family History of Diagnosis 3",
                       "MRI Collected", "Imaging 1 Collected", "Imaging 2 Collected",
                       "Geno type 1", "Geno type 2")
pVAR_info$PM <- "Participants"
pVAR_info$TYPE <- sapply(ppt_all_fc, class)
pVAR_info$RANGE <- sapply(ppt_all_fc, levels)
pVAR_info <- pVAR_info[]

pVAR_Cate <- pVAR_info %>% filter(TYPE == "factor") %>% mutate(MINVALUE = NA, MAXVALUE = NA)

pVAR_Num <- pVAR_info %>% filter(TYPE %in% c("integer", "numeric")) %>% mutate(VARNAME = as.factor(VARNAME))
pVAR_Num$MINVALUE <- c(0,   1990, 10, 20, 10, 0,  1)
pVAR_Num$MAXVALUE <- c(110, 2030, 40, 40, 25, 25, 100)
pVAR_Num$RANGE <- paste(pVAR_Num$MINVALUE, pVAR_Num$MAXVALUE, sep="-")

VARMISS <- data.frame(VARNAME = 1:7) %>%
  mutate(
    VARNAME = c("AGEMISS", "YODMISS", "BMIMISS", "S1MISS", "S2MISS","S3MISS","S4MISS"),
    LABELS  = c("Age at Assessment Include Missing",
                "Year of Death Include Missing",
                "BMI Include Missing",
                "Scale 1 Include Missing",
                "Scale 2 Include Missing",
                "Scale 3 Include Missing","Scale 4 Include Missing"),
    PM = "Participants",
    TYPE = "factor",
    RANGE = TRUE,
    MINVALUE = NA,
    MAXVALUE = NA
  )

VAR_info <- rbind(metaVAR_info, pVAR_Cate, pVAR_Num, VARMISS) %>%
  arrange(match(LABELS,
                c("Study", "Full Name", "Continent", "Country",
                  "Min Age at Recruitment", "Sample Size",
                  "Available through Repository", "Follow-up Data Available", "Country Income Level",
                  "Administration", "Demographics", "Medical History", "Family History of Diseases","Service Utilization",
                  "Hospital Data", "Survey Data",  "Linkage Data", "Imaging","Genomic",
                  "OtherA","OtherB","OtherC","OtherD","OtherE",
                  "Ethnic Background", "Sex", "High School Educated", "Married/De-facto",
                  "Age at Assessment", "Age at Assessment Include Missing",
                  "Deceased", "Year of Death", "Year of Death Include Missing",
                  "Smoking Status", "Alcohol Use Status", "BMI", "BMI Include Missing",
                  "Scale 1", "Scale 1 Include Missing",
                  "Scale 2", "Scale 2 Include Missing",
                  "Scale 3", "Scale 3 Include Missing",
                  "Scale 4", "Scale 4 Include Missing",
                  "Disease Diagnosis 1", "Disease Diagnosis 2","Disease Diagnosis 3","Disease Diagnosis 4",
                  "Hospital Outpatient", "Hospital Inpatient", "GP",
                  "Family History of Diagnosis 1", "Family History of Diagnosis 2", "Family History of Diagnosis 3",
                  "MRI Collected", "Imaging 1 Collected", "Imaging 2 Collected",
                  "Geno type 1", "Geno type 2")
  ))



save(simmeta, studymeta, ppt_all, ppt_all_fc, VAR_info, file = "simdata.RData")
load("data-raw/temp/simdata.RData")


usethis::use_data(studymeta, overwrite = TRUE) # study meta data
usethis::use_data(VAR_info, overwrite = TRUE) # Variable Information
usethis::use_data(ppt_all_fc, overwrite = TRUE) # participant-level data, converted to factors
