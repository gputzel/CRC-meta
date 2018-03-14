sample.df <- read.table('sample_data/merged_sample_data.tsv',sep='\t',header=TRUE,stringsAsFactors=FALSE)

subset.df <- sample.df[sample.df$Diagnosis != 3,] #Diagnosis 3 means adenoma, not carcinoma
subset.df <- subset.df[subset.df$env_material == 'stool',]

write.table(subset.df,file='sample_data/merged_sample_data_subset.tsv',sep='\t',quote=FALSE,row.names = FALSE)
