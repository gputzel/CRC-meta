library(phyloseq)
library(biomformat)
#library(tidyverse)

biom.file <- biomformat::read_biom(snakemake@input[['biom']])
ps <- import_biom(biom.file)
mytree <- read_tree(snakemake@input[['tree']])
phy_tree(ps) <- mytree

ps

sample.df <- read.table('sample_data/SraRunTable.txt',sep='\t',header=TRUE)
rownames(sample.df) <- sample.df[,'Run']

sample.df <- sample.df[,c('Library_Name','Sample_Name')]

sample.df.reordered <- sample.df[sample_names(ps),]

sample.df.reordered$Sample_Name <- as.character(sample.df.reordered$Sample_Name)

#Some of the sample names have underscores, others not
sample.names <- gsub('_','',sample.df.reordered$Sample_Name)
types <- ifelse(grepl('T$',sample.names),'T','Other')
types[grepl('N$',sample.names)] <- 'N'
types[grepl('C$',sample.names)] <- 'C'
sample.df.reordered$type <- types
sample.df.reordered$subject <- gsub('T','',gsub('C','',gsub('N','',sample.names)))

#I'm assuming that "C" and "T" mean the same thing. Will confirm with the authors
sample.df.reordered$type <- gsub('C','T',sample.df.reordered$type)

sample_data(ps) <- sample_data(sample.df.reordered)

colnames(tax_table(ps)) <- c('Kingdom','Phylum','Class','Order','Family','Genus','Species')

saveRDS(ps,'qiime1/ps_qiime1.rds')
