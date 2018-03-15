#!/bin/bash

for path in $(ls FASTQ/*.fastq.gz)
do
    file=${path##*/}
    f=${file/_pass_/_1_L001_R}
    f2=${f/\.fastq/_001.fastq}
    ln -s ../FASTQ/$file FASTQ_renamed/$f2
done
