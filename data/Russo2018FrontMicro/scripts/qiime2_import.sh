#!/bin/bash

qiime tools import \
    --type 'SampleData[PairedEndSequencesWithQuality]' \
    --input-path FASTQ_renamed \
    --source-format CasavaOneEightLanelessPerSampleDirFmt \
    --output-path qiime2/fastq.qza
