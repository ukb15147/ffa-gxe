## Using PLINK1.9

## Extract round 1 matching controls from UKB genotype data
plink \
--noweb \
--bfile [file_name] \
--keep match_it_file.txt \
--make-bed \
--out selected_ukb_controls_round1_file

## Merge the UKB genotype data (controls) and FFA genotype data (cases)
## ** Note that prior to this step, both sets of PLINK files have had variant ID
##    set to chr:pos:a1:a2 to facilitate merging. Also note that palindromic
##    (A/T or C/G) variants were removed during FFA case data QC

plink \
--noweb \
--allow-no-sex \
--bfile ffa_cases_file \
--bmerge selected_ukb_controls_round1_file \
--make-bed \
--out ffa_ukb

## Identify a set of LD independent SNPs to use for PCA

## First identify common variants outside of known FFA loci (defined in Tziotzios et al, Nat Commun 2019)
plink \
--noweb \
--allow-no-sex \
--bfile ffa_ukb \
--exclude FFAloc.regions \
--range \
--maf 0.1 \
--make-bed \
--out ffa_ukb_noFFAreg

## ... and identify pairwise genotype LD correlations...
plink \
--noweb \
--allow-no-sex \
--bfile ffa_ukb_noFFAreg \
--indep-pairwise 1500 150 0.2 \
--out ffa_ukb_noFFAreg_indep

## ... and remove SNPs that are in LD...
plink \
--noweb \
--allow-no-sex \
--bfile ffa_ukb_noFFAreg \
--exclude ffa_ukb_gxe_noFFAreg_indep.prune.out \
--extract ffa_ukb_gxe_noFFAreg_indep.prune.in \
--make-bed \
--out ffa_ukb_noFFAreg_pruned

## At this point the merged data (ffa_ukb.bim/bed/fam) has also undergoes some basic post-merging
## QC steps, namely removing variants with differential missingness p-value <0.05 (using PLINK's
## --test-missing flag), checking there are no duplicate variants or degree 2 related samples or closer

## Run PCA to generate PC1-PC10 after merging with cases
plink \
--bfile ffa_ukb_unrelated_maf_pruned_miss_uniq \
--pca 10 \
--out pca_ffa_ukb
