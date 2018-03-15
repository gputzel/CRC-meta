#!/bin/bash

for file in $(ls FASTQ)
do
    echo $file
    f=${file/_pass_/_1_L001_R}
    f2=${f/\.fastq/_001.fastq}
    echo $f2
    ln -s ../FASTQ/$file FASTQ_renamed/$f2
    echo "****"
done
