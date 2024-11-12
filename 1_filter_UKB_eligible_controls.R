## Extract all possible controls from UKB (female, UK born, OCP data available, no diagnosis of scarring hair loss)

library(tidyverse)
load("ukb41625_var_choose_FOR_TUNTAS_20220805_full.Rda")  ## Starting data frame with selected UKB variables

df_subset <- as_tibble(df_subset)

target_countries <- c("England", "Scotland", "Wales", "Northern Ireland")
df_control_contraceptive <- df_subset %>% 
  filter(
    sex_f31_0_0 == "Female",
    country_of_birth_ukelsewhere_f1647_0_0 %in% target_countries,
    ever_taken_oral_contraceptive_pill_f2784_0_0 == "Yes",
    ever_taken_oral_contraceptive_pill_f2784_1_0 == "Yes" | is.na(ever_taken_oral_contraceptive_pill_f2784_1_0),
    ever_taken_oral_contraceptive_pill_f2784_2_0 == "Yes" | is.na(ever_taken_oral_contraceptive_pill_f2784_2_0),
    ever_taken_oral_contraceptive_pill_f2784_3_0 == "Yes" | is.na(ever_taken_oral_contraceptive_pill_f2784_3_0),
    is.na(date_l66_first_reported_cicatricial_alopecia_scarring_hair_loss_f131784_0_0)
  )

target_countries <- c("England", "Scotland", "Wales", "Northern Ireland")
df_control_non_contraceptive <- df_subset %>% 
  filter(
    sex_f31_0_0 == "Female",
    country_of_birth_ukelsewhere_f1647_0_0 %in% target_countries,
    ever_taken_oral_contraceptive_pill_f2784_0_0 == "No",
    ever_taken_oral_contraceptive_pill_f2784_1_0   == "No" | is.na(ever_taken_oral_contraceptive_pill_f2784_1_0),
    ever_taken_oral_contraceptive_pill_f2784_2_0   == "No" | is.na(ever_taken_oral_contraceptive_pill_f2784_2_0),
    ever_taken_oral_contraceptive_pill_f2784_3_0   == "No" | is.na(ever_taken_oral_contraceptive_pill_f2784_3_0),
    is.na(date_l66_first_reported_cicatricial_alopecia_scarring_hair_loss_f131784_0_0)
  )

ukb_non_ocp <- df_control_non_contraceptive[, c("eid", "year_of_birth_f34_0_0")]
write.table(ukb_non_ocp, file = "ukb_non_ocp.txt", sep = "\t", quote = FALSE,
            row.names = FALSE, col.names = FALSE)

ukb_ocp <- df_control_contraceptive[, c("eid", "year_of_birth_f34_0_0")]
write.table(ukb_ocp, file = "ukb_ocp.txt", sep = "\t", quote = FALSE,
            row.names = FALSE, col.names = FALSE)

