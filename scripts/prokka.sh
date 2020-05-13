#!/bin/bash

DEPTH=10

DATA=/projects/micb405/resources/project_2/2019/SaanichInlet_${DEPTH}m
READS=${DATA}/MetaT_reads
MAGS=${DATA}/MetaBAT2_SaanichInlet_${DEPTH}m/MedQPlus_MAGs

CHECKM_FILE=${DATA}/MetaBAT2_SaanichInlet_${DEPTH}m/MetaBAT2_SaanichInlet_${DEPTH}m_min1500_checkM_stdout.tsv

HQ_MAGS=($(awk '{if (($13 > 90) && ($14 < 5)) print $1}' $CHECKM_FILE))

OUTPUT=/projects/micb405/project1/Team8/Project2/out

sed 's,../,,g' $DATA/SaanichInlet_${DEPTH}m_binned.rpkm.csv | sed 's/_MAG_RPKM.csv//g' | tail -n+3 | \
	awk -F "," 'BEGIN {OFS=","; print "Sample,Sequence,RPKM"}; {print $1,$2,$4}' > \
	$OUTPUT/SaanichInlet_${DEPTH}m_binned_cleaned.rpkm.csv

for i in ${HQ_MAGS[@]}; do
	PREFIX=$(basename ${i%%.fa})
	KINGDOM=$(grep -w $PREFIX$(echo -e '\t') ./classification_pplacer.tsv | sed 's/d__/\t/g' | sed 's/;p__/\t/g' | awk '{print $2}')
	echo "$(prokka \
		--outdir $OUTPUT \
		--prefix $PREFIX \
		--kingdom $KINGDOM \
		--force \
		--cpus 8 \
		$MAGS/${i}.fa)"
done

HIGH_MAGS_FFN=($(find *.ffn))
HIGH_MAGS_FAA=($(find *.faa))

cat ${HIGH_MAGS_FNN[@]} > combined_highq_mags.ffn
cat ${HIGH_MAGS_FAA[@]} > combined_highq_mags.faa

