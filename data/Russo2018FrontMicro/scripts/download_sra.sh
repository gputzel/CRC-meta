#!/bin/bash

tail -n+2 sample_data/merged_sample_data_subset.tsv | cut -f1 | while read SRR
do
    echo "Downloading sample $SRR"
    fastq-dump --outdir FASTQ --gzip --skip-technical --readids --read-filter pass --dumpbase --split-3 --clip "$SRR"    
done
