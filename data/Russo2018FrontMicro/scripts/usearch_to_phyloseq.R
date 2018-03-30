library(phyloseq)
library(RDPutils)

otu.table.file <- snakemake@input[['otu_table']]
taxonomy.file <- snakemake@input[['taxonomy']]
tree.file <- snakemake@input[['tree']]
sample.data.file <- snakemake@input[['sample_data']]

output.file <- snakemake@output[['ps_file']]

otu.df <- read.table(otu.table.file,sep='\t',row.names = 1,
                     header=TRUE,
                     comment.char = '')

tax.df <- RDPutils::import_sintax_file(taxonomy.file,confidence=0.8)

tree <- phyloseq::read_tree(tree.file)

sample.df <- read.table(sample.data.file,sep='\t',header=TRUE,row.names=1)

sample.df.reordered <- sample.df[colnames(otu.df),]

ps <- phyloseq(
               sample_data(sample.df.reordered),
               otu_table(otu.df,taxa_are_rows = TRUE),
               tax.df,
               tree
               )

saveRDS(ps,file=output.file)
