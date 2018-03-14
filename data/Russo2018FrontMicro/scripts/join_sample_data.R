library(tidyverse)

sample.info.df <- read.table('sample_data/sample_info.csv',sep=',',header=TRUE,stringsAsFactors=FALSE)
sample.info.df <- sample.info.df[,c('SRR','host_subject_id','env_feature','env_material')]

table1.df <- read.table('sample_data/table1.tsv',sep='\t',header=TRUE,stringsAsFactors=FALSE)

df <- merge(sample.info.df,table1.df,by.x='host_subject_id',by.y='subject')
df <- df[,c('SRR','host_subject_id','Group','env_feature',
            'env_material','Diagnosis','Tumor.site',
            'BMI','Age.range')]

rownames(df) <- df$SRR

write.table(df,file='sample_data/merged_sample_data.tsv',sep='\t',quote=FALSE,row.names = FALSE)