library(shinytest2)

test_that("{shinytest2} recording: datarepexp", {
  app <- AppDriver$new(variant = platform_variant(), name = "datarepexp", height = 945,
      width = 1619)
  app$set_inputs(`tab3_filter_1-study` = c("AUOECAFAOINV", "LIDSAMEVDAISNE", "PVNI",
      "SRESSBAVG", "SSEVALCCASCE", "FVNMAMTINP", "ITOVJD", "RDVCUNISPDS", "VEEIIEN",
      "VMEATST", "APDLAIA", "ENAH", "FISAGPUSLVF", "PMMERMICI", "STISHV", "ASVA",
      "MTOVFMAISV", "PNDEPPIEVEMMISEUFPLUEPNRE", "RILITARLPNELAHSHSTA", "VVSACNACVJDL",
      "DPEVMV", "INVNESN", "NAVNMCIFMNNUF", "PARNVF", "UENUFUEVE", "APTIFNID", "ASPAPLMEVDAISNE",
      "ESMEMVCOSDSSEDS", "INA", "SAASVEANANESS"))
  app$set_inputs(`tab3_filter_1-continent` = c("Africa", "Asia", "Europe", "North America",
      "Oceania", "South America"))
  app$set_inputs(`tab5_pac_1-ycate` = "Disease Diagnosis 1")
  app$set_inputs(`tab5_pac_1-cx2c` = "Alcohol Use Status")
  app$set_inputs(`tab5_paq_1-qx2c` = "Alcohol Use Status")
  app$set_inputs(`tab5_paq_1-qx3c` = "Deceased")
  app$set_inputs(`tab3_filter_1-filtertabs` = "Study Filters")
  app$set_inputs(`tab4_visual_1-visaultabs` = "Metadata")
  app$set_inputs(`tab5_pac_1-pactabs` = "Univariate")
  app$set_inputs(`tab5_paq_1-paqtabs` = "Univariate")
  app$click("tab2_meta_1-clearmeta")
  app$click("tab2_meta_1-clearava")
  app$click("tab3_filter_1-resetallf")
  app$click("tab3_filter_1-resetsf")
  app$click("tab3_filter_1-resetpf")
  app$set_inputs(`tab5_pac_1-cx1q` = "Scale 2")
  app$set_inputs(`tab5_paq_1-yquan` = "Scale 4")
  app$set_inputs(`tab5_paq_1-qx1q` = "Age at Assessment")
  app$set_inputs(`tab3_filter_1-minage` = c(0, 110))
  app$set_inputs(`tab3_filter_1-studysize` = c(500, 5000))
  app$set_inputs(`tab3_filter_1-ageatass` = c(0, 110))
  app$set_inputs(`tab3_filter_1-yod` = c(1990, 2030))
  app$set_inputs(`tab3_filter_1-bmi` = c(10, 40))
  app$set_inputs(`tab3_filter_1-scale1` = c(20, 40))
  app$set_inputs(`tab3_filter_1-scale2` = c(10, 25))
  app$set_inputs(`tab3_filter_1-scale3` = c(0, 25))
  app$set_inputs(`tab3_filter_1-scale4` = c(1, 100))
  app$set_inputs(`tab3_filter_1-access` = c("No", "Yes"))
  app$set_inputs(`tab3_filter_1-studyfollow` = c("No", "Yes"))
  app$set_inputs(`tab3_filter_1-incomegroup` = c("Low income", "Lower middle income",
      "Upper middle income", "High income"))
  app$set_inputs(`tab3_filter_1-cat01` = c("No", "Yes"))
  app$set_inputs(`tab3_filter_1-cat02` = c("No", "Yes"))
  app$set_inputs(`tab3_filter_1-cat03` = c("No", "Yes"))
  app$set_inputs(`tab3_filter_1-cat04` = c("No", "Yes"))
  app$set_inputs(`tab3_filter_1-cat05` = c("No", "Yes"))
  app$set_inputs(`tab3_filter_1-cat06` = c("No", "Yes"))
  app$set_inputs(`tab3_filter_1-cat07` = c("No", "Yes"))
  app$set_inputs(`tab3_filter_1-cat08` = c("No", "Yes"))
  app$set_inputs(`tab3_filter_1-cat09` = c("No", "Yes"))
  app$set_inputs(`tab3_filter_1-cat10` = c("No", "Yes"))
  app$set_inputs(`tab3_filter_1-cat11` = c("No", "Yes"))
  app$set_inputs(`tab3_filter_1-cat12` = c("No", "Yes"))
  app$set_inputs(`tab3_filter_1-cat13` = c("No", "Yes"))
  app$set_inputs(`tab3_filter_1-cat14` = c("No", "Yes"))
  app$set_inputs(`tab3_filter_1-cat15` = c("No", "Yes"))
  app$set_inputs(`tab3_filter_1-ethnicback` = c("Caucasian", "Asian", "African",
      "Hispanic", "Indigenous", "Mixed", "Other", "Missing"))
  app$set_inputs(`tab3_filter_1-sex` = c("Male", "Female", "Other", "Missing"))
  app$set_inputs(`tab3_filter_1-eduhighs` = c("No", "Yes", "Missing"))
  app$set_inputs(`tab3_filter_1-maristat` = c("No", "Yes", "Missing"))
  app$set_inputs(`tab3_filter_1-deceased` = c("No", "Yes", "Missing"))
  app$set_inputs(`tab3_filter_1-smokestat` = c("Never", "Ex", "Current", "Missing"))
  app$set_inputs(`tab3_filter_1-alcstat` = c("Never", "Ex", "Current", "Missing"))
  app$set_inputs(`tab3_filter_1-dia1` = c("No", "Yes", "Missing"))
  app$set_inputs(`tab3_filter_1-dia2` = c("No", "Yes", "Missing"))
  app$set_inputs(`tab3_filter_1-dia3` = c("No", "Yes", "Missing"))
  app$set_inputs(`tab3_filter_1-dia4` = c("No", "Yes", "Missing"))
  app$set_inputs(`tab3_filter_1-hosoup` = c("No", "Yes", "Missing"))
  app$set_inputs(`tab3_filter_1-hosinp` = c("No", "Yes", "Missing"))
  app$set_inputs(`tab3_filter_1-gp` = c("No", "Yes", "Missing"))
  app$set_inputs(`tab3_filter_1-famdia1` = c("No", "Yes", "Missing"))
  app$set_inputs(`tab3_filter_1-famdia2` = c("No", "Yes", "Missing"))
  app$set_inputs(`tab3_filter_1-famdia3` = c("No", "Yes", "Missing"))
  app$set_inputs(`tab3_filter_1-mricoll` = c("No", "Yes"))
  app$set_inputs(`tab3_filter_1-imgcoll1` = c("No", "Yes"))
  app$set_inputs(`tab3_filter_1-imgcoll2` = c("No", "Yes"))
  app$set_inputs(`tab3_filter_1-geno1` = c("TypeA", "TypeB", "TypeC", "TypeD", "Missing"))
  app$set_inputs(`tab3_filter_1-geno2` = c("G1", "G2", "G3", "G4", "G5", "G6", "G7",
      "G8", "G9", "Missing"))
  app$set_inputs(`tab3_filter_1-agemiss` = TRUE)
  app$set_inputs(`tab3_filter_1-yodmiss` = TRUE)
  app$set_inputs(`tab3_filter_1-bmimiss` = TRUE)
  app$set_inputs(`tab3_filter_1-s1miss` = TRUE)
  app$set_inputs(`tab3_filter_1-s2miss` = TRUE)
  app$set_inputs(`tab3_filter_1-s3miss` = TRUE)
  app$set_inputs(`tab3_filter_1-s4miss` = TRUE)
  app$set_inputs(`tab2_meta_1-studyava_rows_current` = c(1, 2, 3, 4, 5, 6, 7, 8,
      9, 10), allow_no_input_binding_ = TRUE)
  app$set_inputs(`tab2_meta_1-studyava_rows_all` = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10,
      11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29,
      30), allow_no_input_binding_ = TRUE)
  app$set_inputs(`tab2_meta_1-studyava_state` = c(1718266598818, 0, 10, "", TRUE,
      FALSE, TRUE, c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE),
      c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "",
          TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE,
          TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE),
      c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "",
          TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE,
          TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE)),
      allow_no_input_binding_ = TRUE)
  app$set_inputs(`tab2_meta_1-metatb_rows_current` = c(1, 2, 3, 4, 5, 6, 7, 8, 9,
      10), allow_no_input_binding_ = TRUE)
  app$set_inputs(`tab2_meta_1-metatb_rows_all` = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10,
      11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29,
      30), allow_no_input_binding_ = TRUE)
  app$set_inputs(`tab2_meta_1-metatb_state` = c(1718266599147, 0, 10, "", TRUE, FALSE,
      TRUE, c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE,
          "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE,
          FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE,
          TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE)),
      allow_no_input_binding_ = TRUE)
  app$set_inputs(`tab2_meta_1-metatb_rows_current` = c(26, 27, 11, 16, 1, 21, 12,
      28, 6, 13), allow_no_input_binding_ = TRUE)
  app$set_inputs(`tab2_meta_1-metatb_rows_all` = c(26, 27, 11, 16, 1, 21, 12, 28,
      6, 13, 7, 29, 22, 2, 17, 23, 14, 3, 18, 24, 8, 19, 5, 15, 4, 30, 25, 20, 9,
      10), allow_no_input_binding_ = TRUE)
  app$set_inputs(`tab2_meta_1-metatb_state` = c(1718266609178, 0, 10, c("1", "asc"),
      "", TRUE, FALSE, TRUE, c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE,
          TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE),
      c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "",
          TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE,
          TRUE)), allow_no_input_binding_ = TRUE)
  app$set_inputs(`tab2_meta_1-metatb_rows_current` = c(2, 6, 8, 17, 21, 27, 1, 3,
      4, 5), allow_no_input_binding_ = TRUE)
  app$set_inputs(`tab2_meta_1-metatb_rows_all` = c(2, 6, 8, 17, 21, 27, 1, 3, 4,
      5, 7, 9, 10, 11, 12, 13, 14, 15, 16, 18, 19, 20, 22, 23, 24, 25, 26, 28, 29,
      30), allow_no_input_binding_ = TRUE)
  app$set_inputs(`tab2_meta_1-metatb_state` = c(1718266610741, 0, 10, c("2", "asc"),
      "", TRUE, FALSE, TRUE, c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE,
          TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE),
      c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "",
          TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE,
          TRUE)), allow_no_input_binding_ = TRUE)
  app$set_inputs(`tab2_meta_1-metatb_rows_all` = c(2, 6, 8, 17, 21, 27, 1, 3, 4,
      5, 7, 9, 10, 11, 12, 13, 14, 16, 18, 19, 20, 22, 23, 24, 25, 26, 28, 29, 30),
      allow_no_input_binding_ = TRUE)
  app$set_inputs(`tab2_meta_1-metatb_state` = c(1718266613197, 0, 10, c("2", "asc"),
      "a", TRUE, FALSE, TRUE, c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE,
          TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE),
      c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "",
          TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE,
          TRUE)), allow_no_input_binding_ = TRUE)
  app$set_inputs(`tab2_meta_1-metatb_search` = "a", allow_no_input_binding_ = TRUE)
  app$set_inputs(`tab2_meta_1-metatb_rows_current` = 5, allow_no_input_binding_ = TRUE)
  app$set_inputs(`tab2_meta_1-metatb_rows_all` = 5, allow_no_input_binding_ = TRUE)
  app$set_inputs(`tab2_meta_1-metatb_state` = c(1718266614741, 0, 10, c("2", "asc"),
      "ab", TRUE, FALSE, TRUE, c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE,
          FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE,
          TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE),
      c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "",
          TRUE, FALSE, TRUE)), allow_no_input_binding_ = TRUE)
  app$set_inputs(`tab2_meta_1-metatb_search` = "ab", allow_no_input_binding_ = TRUE)
  app$click("tab2_meta_1-clearmeta")
  app$set_inputs(`tab2_meta_1-metatb_rows_current` = c(2, 6, 8, 17, 21, 27, 1, 3,
      4, 5), allow_no_input_binding_ = TRUE)
  app$set_inputs(`tab2_meta_1-metatb_rows_all` = c(2, 6, 8, 17, 21, 27, 1, 3, 4,
      5, 7, 9, 10, 11, 12, 13, 14, 15, 16, 18, 19, 20, 22, 23, 24, 25, 26, 28, 29,
      30), allow_no_input_binding_ = TRUE)
  app$set_inputs(`tab2_meta_1-metatb_state` = c(1718266616438, 0, 10, c("2", "asc"),
      "", TRUE, FALSE, TRUE, c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE,
          TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE),
      c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "",
          TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE,
          TRUE)), allow_no_input_binding_ = TRUE)
  app$set_inputs(`tab2_meta_1-metatb_search` = "", allow_no_input_binding_ = TRUE)
  app$set_inputs(`tab2_meta_1-studyava_state` = c(1718266626726, 0, 10, "", TRUE,
      FALSE, TRUE, c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE),
      c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "",
          TRUE, FALSE, TRUE), c(FALSE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE,
          FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE,
          TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE),
      c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "",
          TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE,
          TRUE)), allow_no_input_binding_ = TRUE)
  app$set_inputs(`tab2_meta_1-studyava_state` = c(1718266627183, 0, 10, "", TRUE,
      FALSE, TRUE, c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE),
      c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "",
          TRUE, FALSE, TRUE), c(FALSE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE,
          FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(FALSE, "", TRUE, FALSE,
          TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE),
      c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "",
          TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE,
          TRUE)), allow_no_input_binding_ = TRUE)
  app$set_inputs(`tab2_meta_1-studyava_state` = c(1718266627567, 0, 10, "", TRUE,
      FALSE, TRUE, c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE),
      c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "",
          TRUE, FALSE, TRUE), c(FALSE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE,
          FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(FALSE, "", TRUE, FALSE,
          TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE),
      c(FALSE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "",
          TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE,
          TRUE)), allow_no_input_binding_ = TRUE)
  app$set_inputs(`tab2_meta_1-studyava_state` = c(1718266628014, 0, 10, "", TRUE,
      FALSE, TRUE, c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE),
      c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "",
          TRUE, FALSE, TRUE), c(FALSE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE,
          FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(FALSE, "", TRUE, FALSE,
          TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE),
      c(FALSE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(FALSE, "",
          TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE,
          TRUE)), allow_no_input_binding_ = TRUE)
  app$set_inputs(`tab2_meta_1-studyava_state` = c(1718266628542, 0, 10, "", TRUE,
      FALSE, TRUE, c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE),
      c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(FALSE, "",
          TRUE, FALSE, TRUE), c(FALSE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE,
          FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(FALSE, "", TRUE, FALSE,
          TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE),
      c(FALSE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(FALSE, "",
          TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE,
          TRUE)), allow_no_input_binding_ = TRUE)
  app$set_inputs(`tab2_meta_1-studyava_state` = c(1718266629062, 0, 10, "", TRUE,
      FALSE, TRUE, c(TRUE, "", TRUE, FALSE, TRUE), c(FALSE, "", TRUE, FALSE, TRUE),
      c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(FALSE, "",
          TRUE, FALSE, TRUE), c(FALSE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE,
          FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(FALSE, "", TRUE, FALSE,
          TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE),
      c(FALSE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(FALSE, "",
          TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE,
          TRUE)), allow_no_input_binding_ = TRUE)
  app$set_inputs(`tab2_meta_1-studyava_state` = c(1718266635110, 0, 10, "", TRUE,
      FALSE, TRUE, c(TRUE, "", TRUE, FALSE, TRUE), c(FALSE, "", TRUE, FALSE, TRUE),
      c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(FALSE, "",
          TRUE, FALSE, TRUE), c(FALSE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE,
          FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(FALSE, "", TRUE, FALSE,
          TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE),
      c(FALSE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(FALSE, "",
          TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE,
          TRUE)), allow_no_input_binding_ = TRUE)
  app$set_inputs(`tab2_meta_1-studyava_state` = c(1718266635120, 0, 10, "", TRUE,
      FALSE, TRUE, c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE),
      c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(FALSE, "",
          TRUE, FALSE, TRUE), c(FALSE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE,
          FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(FALSE, "", TRUE, FALSE,
          TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE),
      c(FALSE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(FALSE, "",
          TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE,
          TRUE)), allow_no_input_binding_ = TRUE)
  app$set_inputs(`tab2_meta_1-studyava_state` = c(1718266635131, 0, 10, "", TRUE,
      FALSE, TRUE, c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE),
      c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(FALSE, "",
          TRUE, FALSE, TRUE), c(FALSE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE,
          FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(FALSE, "", TRUE, FALSE,
          TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE),
      c(FALSE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(FALSE, "",
          TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE,
          TRUE)), allow_no_input_binding_ = TRUE)
  app$set_inputs(`tab2_meta_1-studyava_state` = c(1718266635140, 0, 10, "", TRUE,
      FALSE, TRUE, c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE),
      c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(FALSE, "",
          TRUE, FALSE, TRUE), c(FALSE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE,
          FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(FALSE, "", TRUE, FALSE,
          TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE),
      c(FALSE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(FALSE, "",
          TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE,
          TRUE)), allow_no_input_binding_ = TRUE)
  app$set_inputs(`tab2_meta_1-studyava_state` = c(1718266635154, 0, 10, "", TRUE,
      FALSE, TRUE, c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE),
      c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "",
          TRUE, FALSE, TRUE), c(FALSE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE,
          FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(FALSE, "", TRUE, FALSE,
          TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE),
      c(FALSE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(FALSE, "",
          TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE,
          TRUE)), allow_no_input_binding_ = TRUE)
  app$set_inputs(`tab2_meta_1-studyava_state` = c(1718266635169, 0, 10, "", TRUE,
      FALSE, TRUE, c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE),
      c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "",
          TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE,
          TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(FALSE, "", TRUE, FALSE, TRUE),
      c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(FALSE, "",
          TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(FALSE, "", TRUE,
          FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE,
          TRUE)), allow_no_input_binding_ = TRUE)
  app$set_inputs(`tab2_meta_1-studyava_state` = c(1718266635186, 0, 10, "", TRUE,
      FALSE, TRUE, c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE),
      c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "",
          TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE,
          TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(FALSE, "", TRUE, FALSE, TRUE),
      c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(FALSE, "",
          TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(FALSE, "", TRUE,
          FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE,
          TRUE)), allow_no_input_binding_ = TRUE)
  app$set_inputs(`tab2_meta_1-studyava_state` = c(1718266635202, 0, 10, "", TRUE,
      FALSE, TRUE, c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE),
      c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "",
          TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE,
          TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(FALSE, "", TRUE, FALSE, TRUE),
      c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(FALSE, "",
          TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(FALSE, "", TRUE,
          FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE,
          TRUE)), allow_no_input_binding_ = TRUE)
  app$set_inputs(`tab2_meta_1-studyava_state` = c(1718266635212, 0, 10, "", TRUE,
      FALSE, TRUE, c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE),
      c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "",
          TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE,
          TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE),
      c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(FALSE, "",
          TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(FALSE, "", TRUE,
          FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE,
          TRUE)), allow_no_input_binding_ = TRUE)
  app$set_inputs(`tab2_meta_1-studyava_state` = c(1718266635226, 0, 10, "", TRUE,
      FALSE, TRUE, c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE),
      c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "",
          TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE,
          TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE),
      c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(FALSE, "",
          TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(FALSE, "", TRUE,
          FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE,
          TRUE)), allow_no_input_binding_ = TRUE)
  app$set_inputs(`tab2_meta_1-studyava_state` = c(1718266635237, 0, 10, "", TRUE,
      FALSE, TRUE, c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE),
      c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "",
          TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE,
          TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE),
      c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(FALSE, "",
          TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(FALSE, "", TRUE,
          FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE,
          TRUE)), allow_no_input_binding_ = TRUE)
  app$set_inputs(`tab2_meta_1-studyava_state` = c(1718266635250, 0, 10, "", TRUE,
      FALSE, TRUE, c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE),
      c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "",
          TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE,
          TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE),
      c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "",
          TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(FALSE, "", TRUE,
          FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE,
          TRUE)), allow_no_input_binding_ = TRUE)
  app$set_inputs(`tab2_meta_1-studyava_state` = c(1718266635267, 0, 10, "", TRUE,
      FALSE, TRUE, c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE),
      c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "",
          TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE,
          TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE),
      c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "",
          TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(FALSE, "", TRUE,
          FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE,
          TRUE)), allow_no_input_binding_ = TRUE)
  app$set_inputs(`tab2_meta_1-studyava_state` = c(1718266635283, 0, 10, "", TRUE,
      FALSE, TRUE, c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE),
      c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "",
          TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE,
          TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE),
      c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "",
          TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE,
          TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE)),
      allow_no_input_binding_ = TRUE)
  app$set_inputs(`tab2_meta_1-studyava_state` = c(1718266635297, 0, 10, "", TRUE,
      FALSE, TRUE, c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE),
      c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "",
          TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE,
          TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE),
      c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "",
          TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE,
          TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE)),
      allow_no_input_binding_ = TRUE)
  app$set_inputs(`tab2_meta_1-studyava_state` = c(1718266635309, 0, 10, "", TRUE,
      FALSE, TRUE, c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE),
      c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "",
          TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE,
          TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE),
      c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "",
          TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE,
          TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE)),
      allow_no_input_binding_ = TRUE)
  app$set_inputs(`tab3_filter_1-continent_open` = TRUE, allow_no_input_binding_ = TRUE)
  app$set_inputs(`tab3_filter_1-continent` = character(0))
  app$set_inputs(`tab3_filter_1-continent` = "Africa")
  app$set_inputs(`tab3_filter_1-continent_open` = FALSE, allow_no_input_binding_ = TRUE)
  app$set_inputs(`tab3_filter_1-studyfollow` = "Yes")
  app$set_inputs(`tab3_filter_1-access` = "Yes")
  app$set_inputs(`tab3_filter_1-cat10` = "Yes")
  app$set_inputs(`tab3_filter_1-filtertabs` = "Participant Filters")
  app$set_inputs(`tab3_filter_1-ethnicback` = c("Caucasian", "Asian", "African",
      "Hispanic", "Indigenous", "Mixed", "Other"))
  app$set_inputs(`tab3_filter_1-ethnicback` = c("Caucasian", "Asian", "African",
      "Hispanic", "Indigenous", "Mixed"))
  app$set_inputs(`tab3_filter_1-sex` = c("Male", "Female", "Other"))
  app$set_inputs(`tab3_filter_1-filtertabs` = "Filters Report")
  app$set_inputs(`tab3_filter_1-filtered_ava_rows_current` = 1, allow_no_input_binding_ = TRUE)
  app$set_inputs(`tab3_filter_1-filtered_ava_rows_all` = 1, allow_no_input_binding_ = TRUE)
  app$set_inputs(`tab3_filter_1-filtered_ava_state` = c(1718266658665, 0, 10, "",
      TRUE, FALSE, TRUE, c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE,
          TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE),
      c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "",
          TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE,
          TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE),
      c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "",
          TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE,
          TRUE)), allow_no_input_binding_ = TRUE)
  app$set_inputs(`tab3_filter_1-filtered_study_rows_current` = 1, allow_no_input_binding_ = TRUE)
  app$set_inputs(`tab3_filter_1-filtered_study_rows_all` = 1, allow_no_input_binding_ = TRUE)
  app$set_inputs(`tab3_filter_1-filtered_study_state` = c(1718266658692, 0, 10, "",
      TRUE, FALSE, TRUE, c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE,
          TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE),
      c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "",
          TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE,
          TRUE)), allow_no_input_binding_ = TRUE)
  app$set_inputs(`tab3_filter_1-filter_sel_rows_current` = c(1, 2, 3, 4, 5, 6), allow_no_input_binding_ = TRUE)
  app$set_inputs(`tab3_filter_1-filter_sel_rows_all` = c(1, 2, 3, 4, 5, 6), allow_no_input_binding_ = TRUE)
  app$set_inputs(`tab3_filter_1-filter_sel_state` = c(1718266659885, 0, 10, "", TRUE,
      FALSE, TRUE, c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE),
      c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE)), allow_no_input_binding_ = TRUE)
  app$set_inputs(`tab3_filter_1-filtered_ava_rows_current` = 1, allow_no_input_binding_ = TRUE)
  app$set_inputs(`tab3_filter_1-filtered_ava_rows_all` = 1, allow_no_input_binding_ = TRUE)
  app$set_inputs(`tab3_filter_1-filtered_ava_state` = c(1718266659931, 0, 10, "",
      TRUE, FALSE, TRUE, c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE,
          TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE),
      c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "",
          TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE,
          TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE),
      c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "",
          TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE,
          TRUE)), allow_no_input_binding_ = TRUE)
  app$set_inputs(`tab3_filter_1-filtered_study_rows_current` = 1, allow_no_input_binding_ = TRUE)
  app$set_inputs(`tab3_filter_1-filtered_study_rows_all` = 1, allow_no_input_binding_ = TRUE)
  app$set_inputs(`tab3_filter_1-filtered_study_state` = c(1718266659957, 0, 10, "",
      TRUE, FALSE, TRUE, c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE,
          TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE),
      c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "",
          TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE,
          TRUE)), allow_no_input_binding_ = TRUE)
  app$set_inputs(`tab3_filter_1-filter_sel_state` = c(1718266668995, 0, 10, "", TRUE,
      FALSE, TRUE, c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE),
      c(FALSE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE)), allow_no_input_binding_ = TRUE)
  app$set_inputs(`tab3_filter_1-filter_sel_state` = c(1718266672180, 0, 10, "", TRUE,
      FALSE, TRUE, c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE),
      c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE)), allow_no_input_binding_ = TRUE)
  app$set_inputs(`plotly_hover-A` = "[{\"curveNumber\":4,\"pointNumber\":0,\"x\":5,\"y\":1}]",
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-A` = character(0), allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_hover-A` = "[{\"curveNumber\":4,\"pointNumber\":0,\"x\":5,\"y\":1}]",
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-A` = character(0), allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_afterplot-A` = "\"tab4_visual_1-minagebar\"", allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_afterplot-A` = "\"tab4_visual_1-sizebar\"", allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_afterplot-A` = "\"tab4_visual_1-avapie\"", allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_afterplot-A` = "\"tab4_visual_1-fupie\"", allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_afterplot-A` = "\"tab4_visual_1-contpie\"", allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_afterplot-A` = "\"tab4_visual_1-incomepie\"", allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_afterplot-A` = "\"tab4_visual_1-avacatA\"", allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_afterplot-A` = "\"tab4_visual_1-avacatB\"", allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_afterplot-A` = "\"tab4_visual_1-avacatC\"", allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_relayout-A` = "{\"width\":611,\"height\":400}", allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_relayout-A` = "{\"width\":611,\"height\":400}", allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_relayout-A` = "{\"width\":290.5,\"height\":400}", allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_relayout-A` = "{\"width\":290.5,\"height\":400}", allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_relayout-A` = "{\"width\":290.5,\"height\":400}", allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_relayout-A` = "{\"width\":290.5,\"height\":400}", allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_relayout-A` = "{\"width\":397.328125,\"height\":400}", allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_relayout-A` = "{\"width\":397.328125,\"height\":400}", allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_relayout-A` = "{\"width\":397.328125,\"height\":400}", allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_afterplot-A` = "\"tab4_visual_1-minagebar\"", allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_afterplot-A` = "\"tab4_visual_1-sizebar\"", allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_afterplot-A` = "\"tab4_visual_1-avapie\"", allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_afterplot-A` = "\"tab4_visual_1-fupie\"", allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_afterplot-A` = "\"tab4_visual_1-contpie\"", allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_afterplot-A` = "\"tab4_visual_1-incomepie\"", allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_afterplot-A` = "\"tab4_visual_1-avacatA\"", allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_afterplot-A` = "\"tab4_visual_1-avacatB\"", allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_afterplot-A` = "\"tab4_visual_1-avacatC\"", allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_relayout-A` = "{\"width\":611,\"height\":400}", allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_relayout-A` = "{\"width\":611,\"height\":400}", allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_relayout-A` = "{\"width\":290.5,\"height\":400}", allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_relayout-A` = "{\"width\":290.5,\"height\":400}", allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_relayout-A` = "{\"width\":290.5,\"height\":400}", allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_relayout-A` = "{\"width\":290.5,\"height\":400}", allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_relayout-A` = "{\"width\":397.328125,\"height\":400}", allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_relayout-A` = "{\"width\":397.328125,\"height\":400}", allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_relayout-A` = "{\"width\":397.328125,\"height\":400}", allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_afterplot-A` = "\"tab4_visual_1-minagebar\"", allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_afterplot-A` = "\"tab4_visual_1-sizebar\"", allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_afterplot-A` = "\"tab4_visual_1-avapie\"", allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_afterplot-A` = "\"tab4_visual_1-fupie\"", allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_afterplot-A` = "\"tab4_visual_1-contpie\"", allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_afterplot-A` = "\"tab4_visual_1-incomepie\"", allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_afterplot-A` = "\"tab4_visual_1-avacatA\"", allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_afterplot-A` = "\"tab4_visual_1-avacatB\"", allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_afterplot-A` = "\"tab4_visual_1-avacatC\"", allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_relayout-A` = "{\"width\":611,\"height\":400}", allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_relayout-A` = "{\"width\":611,\"height\":400}", allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_relayout-A` = "{\"width\":290.5,\"height\":400}", allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_relayout-A` = "{\"width\":290.5,\"height\":400}", allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_relayout-A` = "{\"width\":290.5,\"height\":400}", allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_relayout-A` = "{\"width\":290.5,\"height\":400}", allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_relayout-A` = "{\"width\":397.328125,\"height\":400}", allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_relayout-A` = "{\"width\":397.328125,\"height\":400}", allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_relayout-A` = "{\"width\":397.328125,\"height\":400}", allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$expect_screenshot()
  app$set_inputs(`tab4_visual_1-visaultabs` = "Demographics")
  app$set_inputs(`tab4_visual_1-visaultabs` = "Lifestyle")
  app$set_inputs(`plotly_hover-A` = "[{\"curveNumber\":0,\"pointNumber\":0}]", allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_hover-A` = character(0), allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_hover-A` = "[{\"curveNumber\":0,\"pointNumber\":1}]", allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_hover-A` = character(0), allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_hover-A` = "[{\"curveNumber\":0,\"pointNumber\":0}]", allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_hover-A` = character(0), allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_afterplot-A` = "\"tab4_visual_1-bmihis\"", allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_relayout-A` = "{\"barmode\":\"stack\"}", allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_afterplot-A` = "\"tab4_visual_1-bmihis\"", allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_relayout-A` = "{\"barmode\":\"overlay\"}", allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_afterplot-A` = "\"tab4_visual_1-bmihis\"", allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_relayout-A` = "{\"barmode\":\"group\"}", allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`tab4_visual_1-visaultabs` = "Scales")
  app$set_inputs(`tab4_visual_1-visaultabs` = "Health and Family History")
  app$set_inputs(`tab4_visual_1-visaultabs` = "Imaging and Genomic Data")
  app$set_inputs(`plotly_hover-A` = "[{\"curveNumber\":0,\"pointNumber\":1}]", allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_hover-A` = character(0), allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_hover-A` = "[{\"curveNumber\":0,\"pointNumber\":7}]", allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_hover-A` = character(0), allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_hover-A` = "[{\"curveNumber\":0,\"pointNumber\":9}]", allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_hover-A` = character(0), allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_afterplot-A` = "\"tab4_visual_1-geno2pie\"", allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_relayout-A` = "{\"hiddenlabels\":[\"Missing\"]}", allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_hover-A` = "[{\"curveNumber\":0,\"pointNumber\":8}]", allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_hover-A` = character(0), allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_hover-A` = "[{\"curveNumber\":0,\"pointNumber\":0}]", allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_hover-A` = character(0), allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`tab5_pac_1-pactabs` = "Y~X1")
  app$set_inputs(`plotly_afterplot-A` = "\"tab5_pac_1-cyx1hist\"", allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_relayout-A` = "{\"barmode\":\"overlay\"}", allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`tab5_pac_1-pactabs` = "Y~X2")
  app$set_inputs(`tab5_pac_1-cx2c_open` = TRUE, allow_no_input_binding_ = TRUE)
  app$set_inputs(`tab5_pac_1-cx2c` = "Ethnic Background")
  app$set_inputs(`tab5_pac_1-cx2c_open` = FALSE, allow_no_input_binding_ = TRUE)
  app$set_inputs(`plotly_afterplot-A` = "\"tab5_pac_1-cyx2bar\"", allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_relayout-A` = "{\"barmode\":\"stack\"}", allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_hover-A` = "[{\"curveNumber\":2,\"pointNumber\":0,\"x\":\"No\",\"y\":2088}]",
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-A` = character(0), allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_afterplot-A` = "\"tab5_pac_1-cyx2bar\"", allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_relayout-A` = "{\"barmode\":\"group\"}", allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`tab5_pac_1-cx2c_open` = TRUE, allow_no_input_binding_ = TRUE)
  app$set_inputs(`tab5_pac_1-cx2c` = "High School Educated")
  app$set_inputs(`tab5_pac_1-cx2c_open` = FALSE, allow_no_input_binding_ = TRUE)
  app$set_inputs(`tab5_paq_1-yquan` = "BMI")
  app$set_inputs(`plotly_hover-A` = "[{\"curveNumber\":0,\"pointNumber\":0,\"x\":\"BMI\",\"y\":20.44279821187001},{\"curveNumber\":0,\"pointNumber\":0,\"x\":\"BMI\",\"y\":23.78770307283493},{\"curveNumber\":0,\"pointNumber\":0,\"x\":\"BMI\",\"y\":22.348508449433126},{\"curveNumber\":0,\"pointNumber\":0,\"x\":\"BMI\",\"y\":25.297362847490078},{\"curveNumber\":0,\"pointNumber\":0,\"x\":\"BMI\",\"y\":17.030092702143858},{\"curveNumber\":0,\"pointNumber\":0,\"x\":\"BMI\",\"y\":31.08709718724346},{\"curveNumber\":0,\"pointNumber\":0,\"x\":\"BMI\",\"y\":23.800521789801934},{\"curveNumber\":0,\"pointNumber\":0,\"x\":\"BMI\",\"y\":17.92841751231027},{\"curveNumber\":0,\"pointNumber\":0,\"x\":\"BMI\",\"y\":29.592008830183104}]",
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-A` = character(0), allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_hover-A` = "[{\"curveNumber\":0,\"pointNumber\":0,\"x\":\"BMI\",\"y\":20.44279821187001},{\"curveNumber\":0,\"pointNumber\":0,\"x\":\"BMI\",\"y\":23.78770307283493},{\"curveNumber\":0,\"pointNumber\":0,\"x\":\"BMI\",\"y\":22.348508449433126},{\"curveNumber\":0,\"pointNumber\":0,\"x\":\"BMI\",\"y\":25.297362847490078},{\"curveNumber\":0,\"pointNumber\":0,\"x\":\"BMI\",\"y\":17.030092702143858},{\"curveNumber\":0,\"pointNumber\":0,\"x\":\"BMI\",\"y\":31.08709718724346},{\"curveNumber\":0,\"pointNumber\":0,\"x\":\"BMI\",\"y\":23.800521789801934},{\"curveNumber\":0,\"pointNumber\":0,\"x\":\"BMI\",\"y\":17.92841751231027},{\"curveNumber\":0,\"pointNumber\":0,\"x\":\"BMI\",\"y\":29.592008830183104}]",
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-A` = character(0), allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_hover-A` = "[{\"curveNumber\":0,\"pointNumber\":399,\"x\":\"BMI\",\"y\":31.08709718724346}]",
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-A` = character(0), allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`tab5_paq_1-qx2c_open` = TRUE, allow_no_input_binding_ = TRUE)
  app$set_inputs(`tab5_paq_1-qx2c` = "Sex")
  app$set_inputs(`tab5_paq_1-qx2c_open` = FALSE, allow_no_input_binding_ = TRUE)
  app$set_inputs(`tab5_paq_1-paqtabs` = "Y~X1+X2")
  app$set_inputs(`plotly_hover-A` = character(0), allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_hover-A` = "[{\"curveNumber\":0,\"pointNumber\":1299,\"x\":75,\"y\":28.842627366697847}]",
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-A` = character(0), allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_hover-A` = "[{\"curveNumber\":1,\"pointNumber\":610,\"x\":77,\"y\":27.765242990884115}]",
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-A` = character(0), allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_hover-A` = "[{\"curveNumber\":0,\"pointNumber\":667,\"x\":77,\"y\":27.29278072690547}]",
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-A` = character(0), allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_hover-A` = "[{\"curveNumber\":0,\"pointNumber\":650,\"x\":77,\"y\":27.184386671131566}]",
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-A` = character(0), allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_hover-A` = "[{\"curveNumber\":0,\"pointNumber\":2619,\"x\":89,\"y\":19.550320830643663}]",
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-A` = character(0), allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_hover-A` = "[{\"curveNumber\":0,\"pointNumber\":2229,\"x\":89,\"y\":26.70689649456912}]",
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-A` = character(0), allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`tab5_paq_1-paqtabs` = "Y~X2")
  app$set_inputs(`tab5_paq_1-paqtabs` = "Y~X2+X3")
  app$set_inputs(`plotly_hover-A` = "[{\"curveNumber\":1,\"pointNumber\":428,\"x\":0.9357269514663497,\"y\":28.559413335975094}]",
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-A` = character(0), allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_hover-A` = "[{\"curveNumber\":4,\"pointNumber\":502,\"x\":1.939259154241755,\"y\":27.57559883853659}]",
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-A` = character(0), allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_hover-A` = "[{\"curveNumber\":4,\"pointNumber\":511,\"x\":1.9462510776365889,\"y\":27.742582917435858}]",
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-A` = character(0), allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_hover-A` = "[{\"curveNumber\":1,\"pointNumber\":606,\"x\":1.0695786692359832,\"y\":28.30788199233813}]",
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-A` = character(0), allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_hover-A` = "[{\"curveNumber\":1,\"pointNumber\":356,\"x\":0.8723973914108331,\"y\":26.91302635944224}]",
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-A` = character(0), allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_hover-A` = "[{\"curveNumber\":1,\"pointNumber\":317,\"x\":0.7112545728775587,\"y\":26.021233413820283}]",
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-A` = character(0), allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_hover-A` = "[{\"curveNumber\":10,\"pointNumber\":0,\"x\":1,\"y\":24.419679265569243},{\"curveNumber\":10,\"pointNumber\":0,\"x\":1,\"y\":22.99795489984662},{\"curveNumber\":10,\"pointNumber\":0,\"x\":1,\"y\":25.629826525730614},{\"curveNumber\":10,\"pointNumber\":0,\"x\":1,\"y\":18.772557419918694},{\"curveNumber\":10,\"pointNumber\":0,\"x\":1,\"y\":30.457331656144913},{\"curveNumber\":10,\"pointNumber\":0,\"x\":1,\"y\":19.63707068633648},{\"curveNumber\":10,\"pointNumber\":0,\"x\":1,\"y\":28.966140819550425}]",
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-A` = character(0), allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_hover-A` = "[{\"curveNumber\":1,\"pointNumber\":804,\"x\":1.3313720429369047,\"y\":23.780317806872787}]",
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-A` = character(0), allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_hover-A` = "[{\"curveNumber\":1,\"pointNumber\":801,\"x\":1.3367168407734966,\"y\":23.848917264228323}]",
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-A` = character(0), allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_hover-A` = "[{\"curveNumber\":1,\"pointNumber\":794,\"x\":1.348841185691523,\"y\":24.008982664724574}]",
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-A` = character(0), allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_hover-A` = "[{\"curveNumber\":1,\"pointNumber\":748,\"x\":1.3706530010018934,\"y\":25.060841010842786}]",
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-A` = character(0), allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_hover-A` = "[{\"curveNumber\":10,\"pointNumber\":0,\"x\":1,\"y\":24.419679265569243},{\"curveNumber\":10,\"pointNumber\":0,\"x\":1,\"y\":22.99795489984662},{\"curveNumber\":10,\"pointNumber\":0,\"x\":1,\"y\":25.629826525730614},{\"curveNumber\":10,\"pointNumber\":0,\"x\":1,\"y\":18.772557419918694},{\"curveNumber\":10,\"pointNumber\":0,\"x\":1,\"y\":30.457331656144913},{\"curveNumber\":10,\"pointNumber\":0,\"x\":1,\"y\":19.63707068633648},{\"curveNumber\":10,\"pointNumber\":0,\"x\":1,\"y\":28.966140819550425}]",
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-A` = character(0), allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_hover-A` = "[{\"curveNumber\":4,\"pointNumber\":511,\"x\":1.9462510776365889,\"y\":27.742582917435858}]",
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-A` = character(0), allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_hover-A` = "[{\"curveNumber\":4,\"pointNumber\":512,\"x\":2.053748922363411,\"y\":27.742582917435858}]",
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-A` = character(0), allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_hover-A` = "[{\"curveNumber\":4,\"pointNumber\":511,\"x\":1.9462510776365889,\"y\":27.742582917435858}]",
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-A` = character(0), allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_hover-A` = "[{\"curveNumber\":13,\"pointNumber\":0,\"x\":2,\"y\":22.86293734481234},{\"curveNumber\":13,\"pointNumber\":0,\"x\":2,\"y\":21.721046991969043},{\"curveNumber\":13,\"pointNumber\":0,\"x\":2,\"y\":24.479800920085694},{\"curveNumber\":13,\"pointNumber\":0,\"x\":2,\"y\":18.261597993266285},{\"curveNumber\":13,\"pointNumber\":0,\"x\":2,\"y\":27.742582917435858}]",
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-A` = character(0), allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_hover-A` = "[{\"curveNumber\":1,\"pointNumber\":749,\"x\":1.3710624690843614,\"y\":25.037974525057606}]",
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-A` = character(0), allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_hover-A` = "[{\"curveNumber\":1,\"pointNumber\":816,\"x\":1.3116181146587742,\"y\":23.505919977450645}]",
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-A` = character(0), allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_hover-A` = "[{\"curveNumber\":1,\"pointNumber\":830,\"x\":1.2946115130980294,\"y\":23.185789176458147}]",
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-A` = character(0), allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_hover-A` = "[{\"curveNumber\":10,\"pointNumber\":0,\"x\":1,\"y\":24.419679265569243},{\"curveNumber\":10,\"pointNumber\":0,\"x\":1,\"y\":22.99795489984662},{\"curveNumber\":10,\"pointNumber\":0,\"x\":1,\"y\":25.629826525730614},{\"curveNumber\":10,\"pointNumber\":0,\"x\":1,\"y\":18.772557419918694},{\"curveNumber\":10,\"pointNumber\":0,\"x\":1,\"y\":30.457331656144913},{\"curveNumber\":10,\"pointNumber\":0,\"x\":1,\"y\":19.63707068633648},{\"curveNumber\":10,\"pointNumber\":0,\"x\":1,\"y\":28.966140819550425}]",
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-A` = character(0), allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_hover-A` = "[{\"curveNumber\":1,\"pointNumber\":251,\"x\":0.6276808877679687,\"y\":24.512045351998502}]",
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-A` = character(0), allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_hover-A` = "[{\"curveNumber\":8,\"pointNumber\":511,\"x\":2.874818533496303,\"y\":25.40797675132906}]",
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-A` = character(0), allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_hover-A` = "[{\"curveNumber\":8,\"pointNumber\":790,\"x\":3.4701461681463703,\"y\":20.850145507349634}]",
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-A` = character(0), allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_hover-A` = "[{\"curveNumber\":17,\"pointNumber\":0,\"x\":3,\"y\":20.892912859400447},{\"curveNumber\":17,\"pointNumber\":0,\"x\":3,\"y\":19.807401042817148},{\"curveNumber\":17,\"pointNumber\":0,\"x\":3,\"y\":22.533504126180176},{\"curveNumber\":17,\"pointNumber\":0,\"x\":3,\"y\":17.030092702143858},{\"curveNumber\":17,\"pointNumber\":0,\"x\":3,\"y\":25.40797675132906}]",
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-A` = character(0), allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_hover-A` = "[{\"curveNumber\":8,\"pointNumber\":243,\"x\":2.5503186294900027,\"y\":21.014096271521556}]",
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-A` = character(0), allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_hover-A` = "[{\"curveNumber\":5,\"pointNumber\":852,\"x\":2.3094544420825747,\"y\":21.43205665104297}]",
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-A` = character(0), allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_hover-A` = "[{\"curveNumber\":14,\"pointNumber\":0,\"x\":2,\"y\":22.92520138501199},{\"curveNumber\":14,\"pointNumber\":0,\"x\":2,\"y\":21.697009319548663},{\"curveNumber\":14,\"pointNumber\":0,\"x\":2,\"y\":24.352521451912445},{\"curveNumber\":14,\"pointNumber\":0,\"x\":2,\"y\":17.92841751231027},{\"curveNumber\":14,\"pointNumber\":0,\"x\":2,\"y\":28.398356692967635},{\"curveNumber\":14,\"pointNumber\":0,\"x\":2,\"y\":28.27371126897288}]",
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-A` = character(0), allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_hover-A` = "[{\"curveNumber\":5,\"pointNumber\":167,\"x\":1.702561750157818,\"y\":21.3501001799615}]",
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-A` = character(0), allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_hover-A` = "[{\"curveNumber\":5,\"pointNumber\":179,\"x\":1.66334771350523,\"y\":21.5959695932059}]",
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-A` = character(0), allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_hover-A` = "[{\"curveNumber\":5,\"pointNumber\":183,\"x\":1.6483799386199434,\"y\":21.67792606428737}]",
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-A` = character(0), allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_hover-A` = "[{\"curveNumber\":5,\"pointNumber\":185,\"x\":1.6406325444730965,\"y\":21.718904299828104}]",
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-A` = character(0), allow_no_input_binding_ = TRUE,
      priority_ = "event")
  app$set_inputs(`plotly_hover-A` = "[{\"curveNumber\":5,\"pointNumber\":104,\"x\":1.820709878778788,\"y\":20.059285760428402}]",
      allow_no_input_binding_ = TRUE, priority_ = "event")
  app$set_inputs(`plotly_hover-A` = character(0), allow_no_input_binding_ = TRUE,
      priority_ = "event")
})
