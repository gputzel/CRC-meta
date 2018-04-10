library(phyloseq)
library(biomformat)
#library(tidyverse)

biom.file <- biomformat::read_biom(snakemake@input[['biom']])
ps <- import_biom(biom.file)
mytree <- read_tree(snakemake@input[['tree']])
phy_tree(ps) <- mytree

sample.df <- read.table('sample_data/SraRunTable.txt',sep='\t',header=TRUE)
rownames(sample.df) <- sample.df[,'Run']

sample.df <- sample.df[,c('Abx','Age','BMI','Gender','description','diagnosis','env_material')]

#ps
#nrow(sample.df)
#length(intersect(sample_names(ps),rownames(sample.df)))

sample.df.reordered <- sample.df[sample_names(ps),]

sample.df.reordered$Group <- ifelse(is.na(sample.df.reordered$diagnosis),'Mock',as.character(sample.df.reordered$diagnosis))

sample.df.reordered$Group[sample.df.reordered$Group=='Cancer'] <- 'CRC'
sample.df.reordered$Group[sample.df.reordered$Group=='Normal'] <- 'Healthy'
sample.df.reordered$Group[sample.df.reordered$Group==''] <- 'Mock'

sample_data(ps) <- sample_data(sample.df.reordered)

colnames(tax_table(ps)) <- c('Kingdom','Phylum','Class','Order','Family','Genus','Species')

saveRDS(ps,'qiime1/ps_qiime1.rds')
