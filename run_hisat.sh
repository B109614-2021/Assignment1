#!/usr/bin/bash
#### To do: make this run for the paired ends

# need to bring in sample paths, then run hisat for each pair.

# find the files in temp that have been unzipped
fq_files=$(find temp -name "*.fq")

echo "Creating sam file by aligning with HISAT2"

# loop over file names with hisat, and rename for samfile (work on rename bit)
# for each file, remove the "_1.fq" and "_2.fq". These can be specified during the Hisat alignment so the correct pairs are aligned together
# also get the path to the correct folder for each sample, so sam file can be saved in the correct place 

for file in $fq_files
do
file_name=$(echo "$file" | awk -F ["_","/"] '{print $(NF-1);}')
path=$(echo "$file" | awk -F "/" '{OFS="/"; {$NF=""; print $0;}}') 
	for sample in $file_name
	do
	hisat2 -x temp/hisat_index/index -q -1 "$path$sample"*1* -2 "$path$sample"*2* -S "$path$sample".sam --quiet
	done
done 

# each folder should contain a sam file for each pair in that folder

