library(phyloseq)
library(biomformat)
#library(tidyverse)

biom.file <- biomformat::read_biom(snakemake@input[['biom']])
ps <- import_biom(biom.file)
mytree <- read_tree(snakemake@input[['tree']])
phy_tree(ps) <- mytree

sample.df <- read.table('sample_data/SraRunTable.txt',sep='\t',header=TRUE)
rownames(sample.df) <- sample.df[,'Run']

sample.df <- sample.df[,c('Library_Name','Sample_Name',
                          'chem_administration','ethnicity',
                          'host_tissue_sampled','env_material')]

sample.df.reordered <- sample.df[sample_names(ps),]

sample.df.reordered$Group <- as.character(sample.df.reordered$ethnicity)
sample.df.reordered$Subject <- as.character(sample.df.reordered$chem_administration)

sample_data(ps) <- sample_data(sample.df.reordered)

colnames(tax_table(ps)) <- c('Kingdom','Phylum','Class','Order','Family','Genus','Species')

saveRDS(ps,'qiime1/ps_qiime1.rds')
