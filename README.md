This repository comprises code to support results derived using UK Biobank approved project 15147 that have been published in:

Rayinda _et al_, Gene-Environment Interaction Between _CYP1B1_ and Oral Contraception on Frontal Fibrosing Alopecia, _JAMA Dermatology_ (2024) 160(7):732-735; [doi:10.1001/jamadermatol.2024.1315](https://doi.org/10.1001/jamadermatol.2024.1315) 

### Study lay summary

Frontal fibrosing alopecia (FFA) is an increasingly common form of scarring hair loss that predominantly affects post-menopausal women. A previous genetic study of FFA showed that risk of FFA is altered by a DNA sequence variant that affects _CYP1B1_, a gene that is important for metabolising sex hormones such as those in the oral contraceptive pill (OCP). In this study we had genetic data for 489 female FFA cases for whom history of OCP use was known. We matched these FFA cases to female UK Biobank participants with similar age and genetic ancestry, and data on OCP usage (34,254 in total). We found that the _CYP1B1_ sequence variant was associated with FFA risk in women who had used OCP, but found no evidence for this genetic association in women who had not used OCP. This provides important evidence of a gene-environment interaction in FFA, which we formally demonstrated using a statistical interaction model.

### Data

UK Biobank data cannot be openly shared, but researchers can apply for access.

All genetic analysis is based on the UK Biobank array genotype data (field 22418) after initial QC (see repository [https://github.com/ukb15147/central-scripts](https://github.com/ukb15147/central-scripts)). Eligible participants were selected from UKB using fields: "Sex" (field 31), "Country of birth (UK/elsewhere)" (field 1647), "Ever taken oral contraceptive pill" (field 2784) and "Date L66 first reported (cicatricial alopecia)" (field 131784). Subsequent matching to FFA cases was based on age at assessment, derived from "Year of birth" (field 34), and on genetic principal components derived as detailed in the scripts below.

### Code

| Script                                                               | Description                                                                                                                                                                          |
| -------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| [1_filter_UKB_eligible_controls.R](1_filter_UKB_eligible_controls.R) | Filter UK Biobank data for females with data on OCP history, excluding those with diagnoses of scarring alopecia                                                                     |
| [2_matching_round1_age.R](2_matching_round1_age.R)                   | Identify a subset of these UK Biobank participants by matching to FFA cases on age at assessment (matching round 1)                                                                  |
| [3_plink_merge_pca.sh](3_plink_merge_pca.sh)                         | Extract array genotype data for this matched subset of UK Biobank participants, merge with FFA cases, identify an LD-independent subset of common variants, and perform PCA analysis |
| [4_matching_round2_PCs.R](4_matching_round2_PCs.R)                   | Identify a further subset of the UK Biobank participants matched to FFA cases on PC1-4 (matching round 2). These represent the final set of controls (1:66 ratio)                    |
| [5_final_plink_interaction.sh](5_final_plink_interaction.sh)         | Perform interaction test for this final set of cases and controls                                                                                                                    |
 