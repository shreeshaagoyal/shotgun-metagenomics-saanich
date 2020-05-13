#!/bin/bash

for f in Saanich*.faa
do
	prokka_id=$(head -1 $f | awk -F_ '{print $1}' | sed 's/^>//g')
	mag_id=$(echo $(basename $f) | sed 's/.faa//g')
	echo $prokka_id,$mag_id
done > Prokka_MAG_map.csv

