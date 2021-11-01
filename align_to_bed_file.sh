#!/bin/bash

### generate counts_per_gene.tsv using bedtools

# create a bed file alignment

# get bedfile from parent script

bed_file=$1

echo 'aligning to bed file'

# want to align all replicates of a sample at the same time, so get the folder path 
# find all Bam files 

bam_files=$(find temp -name "*.bam")

for bam in $bam_files
do
path=$(echo "$bam" | awk -F "/" '{OFS="/"; {$NF=""; print $0;}}')
	for folder in $path
	do
	bedtools intersect -F 0.90 -c -a $bed_file -b $folder*.bam > $folder/aligned.txt
	# count the number of overlaps between the reads and the genes, requiring 90% of the read to be overlapped for it to be counted
	done
done
