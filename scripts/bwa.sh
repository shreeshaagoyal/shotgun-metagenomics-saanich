#!/bin/bash

DEPTH=10

DATA=/projects/micb405/resources/project_2/2019/SaanichInlet_${DEPTH}m
READS=${DATA}/MetaT_reads/*.fastq.gz
OUTPUT=/projects/micb405/project1/Team8/Project2/out

bwa index combined_highq_mags.ffn
bwa mem -t 8 -p combined_highq_mags.ffn $READS > combined_metat_prokka_10m.sam

/projects/micb405/resources/project_2/2019/rpkm \
-c combined_highq_mags.ffn \
-a combined_metat_prokka_10m.sam \
-o SI072_SaanichInlet_10m_MAG_ORFs_RPKM.csv
