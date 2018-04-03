library(phyloseq)
library(biomformat)
#library(tidyverse)

biom.file <- biomformat::read_biom(snakemake@input[['biom']])
ps <- import_biom(biom.file)
mytree <- read_tree(snakemake@input[['tree']])
phy_tree(ps) <- mytree

sample.df <- data.frame(
    row.names = sample_names(ps),
    Group = rep("Other",times=length(sample_names(ps)))
)

sample.df$Group <- as.character(sample.df$Group)

sample.df$Group[grep("^mock",sample_names(ps))] <- "Mock"
sample.df$Group[grep("^Healthy",sample_names(ps))] <- "Healthy"
sample.df$Group[grep("^Cancer",sample_names(ps))] <- "CRC"
sample.df$Group[grep("^Aden",sample_names(ps))] <- "Adenoma"

sample.df$Group <- factor(sample.df$Group,levels=c('Healthy','CRC','Adenoma','Mock'))

sample_data(ps) <- sample_data(sample.df)

saveRDS(ps,'qiime1/ps_qiime1.rds')