#!/bin/bash
fullname=$(basename $1)
filename1=${fullname%_R*.fastq.gz}
filename=${fullname%%_*}
echo ${fullname}
echo ${filename1}
echo ${filename}

bbmerge.sh in1=${filename1}_R1.fastq.gz in2=${filename1}_R2.fastq.gz outa=adapters.fa # ID adapter sequences

bbduk.sh in1=${filename1}_R1.fastq.gz in2=${filename1}_R2.fastq.gz out1=${filename1}_R1_clean.fq.gz out2=${filename1}_R2_clean.fq.gz outs=${filename1}_singletons.fq.gz ref=adapters.fa ktrim=r k=21 mink=11 hdist=1 tpe tbo # QC and adapter trimming

# spades assembly 
spades.py --pe1-1 ${filename1}_R1_clean.fq.gz \
--pe1-2 ${filename1}_R2_clean.fq.gz \
--pe1-s ${filename1}_singletons.fq.gz \
-t 72 --careful \
-k 21,23,25,27,29,31,33,35,37,39,41,43,45,47,49,51,53,55,57,59,61,63,65,67,69,71,73,75,77,79,81,83,85,87,89,91,93,95,97,99,101,103,105,107,109,111,113,115,117,119,121,123,125,127 \
-o Spades_assemblies

exit 0
