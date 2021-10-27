#!/usr/bin/bash

# script that takes the input guide file, and sets up the desired folder structure.
# want a folder for each sample, containing a folder for control and sample, containing a folder for each time point


while read ID sample replicate time treatment End1 End2
do
	for sample_name in $sample
	do
	mkdir temp/$sample_name
	done
done < /localdisk/data/BPSM/AY21/fastq/100k.fqfiles

