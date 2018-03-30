#!/bin/bash

qiime dada2 denoise-paired \
    --i-demultiplexed-seqs qiime2/fastq.qza \
    --p-trunc-len-f 300 \
    --p-trunc-len-r 250 \
    --p-trim-left-f 10 \
    --p-trim-left-r 10 \
    --p-max-ee 1.0 \
    --p-trunc-q 2 \
    --p-chimera-method consensus \
    --p-min-fold-parent-over-abundance 1.0 \
    --p-n-threads 4 \
    --p-n-reads-learn 1000000 \
    --p-hashed-feature-ids \
    --o-table qiime2/dada2/table.qza \
    --o-representative-sequences qiime2/dada2/rep_seqs.qza \
    --verbose
