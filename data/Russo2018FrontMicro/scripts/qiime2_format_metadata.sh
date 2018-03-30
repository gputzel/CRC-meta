#!/bin/bash

head -n 1 sample_data/merged_sample_data_subset.tsv | sed 's/SRR/sample_name/g' > qiime2/metadata.tsv
tail -n +2 sample_data/merged_sample_data_subset.tsv >> qiime2/metadata.tsv
