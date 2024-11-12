## Extract cases and controls based on second round of matching

plink \
--noweb \
--bfile [file_name_merged_ffa_round1ctrls] \
--keep match_it_file2.txt \
--make-bed \
--out output_file2


## Run GxE test in PLINK v1.9
##  [covar_file] includes 4x columns for PC1-4 and 1x column for OCP status
##  [snp_file] lists the SNP rs1800440

plink \
--allow-no-sex \
--bfile output_file2 \
--logistic \
--interaction \
--parameters 1,2,3,4,5,6,11 \
--reference-allele ref_allele.txt \
--ci 0.95 \
--covar [covar_file] \
--extract [snp_file] \
--out [outputfile]
