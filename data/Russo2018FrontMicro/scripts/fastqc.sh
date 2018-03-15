#!/bin/bash

FASTQC=/Applications/FastQC.app/Contents/MacOS/fastqc
cd FASTQ
for f in $(ls *.fastq.gz)
do
    f2=${f%.fastq.gz}
    name=${f2/pass_/}
    echo $name
    gzcat $f | $FASTQC stdin; mv stdin_fastqc.html ../FASTQC/"$name"_FastQC.html
    rm stdin_fastqc.zip
done
