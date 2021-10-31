#!/usr/bin/bash

# script that takes the input guide file, and sets up the desired folder structure.
# want a folder for each sample, containing a folder for control and sample, containing a folder for each time point


sample_folder=$1
details=$2

# get the list of different samples eg, Clone1, Clone2 or WT and time
sample_names=$(awk '{FS="\t"; {print $2;}}' $details | uniq | grep -v 'Sample')
treatments=$(awk '{FS="\t"; {print $5;}}' /localdisk/data/BPSM/AY21/fastq/100k.fqfiles | sort | uniq | grep -v 'Treatment')
times=$(awk '{FS="\t"; {print $4;}}' $details | sort | uniq | grep -v 'Time')

# make a folder for each sample, treatment and time. uninduced at time 0 is pretretment

for sample in $sample_names
do 
	for treatment in $treatments
	do 
		for time in $times
		do
		mkdir -p  temp/$sample/$treatment/$time
		mkdir -p temp/$sample/$treatment/$time
		done
	done
done

# for each line in the sample file, copy that sample into the relevant directory
# for line in $(awk '{FS="\t"; OFS="_"; {print $2,$4,$5,$6,$7;} {grep -v 'Sample_Time_Treatment_End1_End2'}}' /localdisk/data/BPSM/AY21/fastq/100k.fqfiles)

# for each unique sample id, copy file into relevant folder
# get unique sample IDs

# creat a variable listing paths to of where to copy from and to for end 1 and end 2 of samples 

cp_end1=$(awk '{FS="\t"; {print "/" $6 " temp/" $2 "/" $5 "/" $4 "\n";}}' $details)
cp_end2=$(awk '{FS="\t"; {print "/" $7 " temp/" $2 "/" $5 "/" $4 "\n";}}' $details)

IFS=$'\n'

# copy End1 of present samples into the relevant folder, testing that the files exist

for file_path in $cp_end1
do
file=$(echo $file_path | awk '{FS=" "; {print $1;}}')
if test -f "$sample_folder$file";
	then
	echo "$sample_folder$file_path" | xargs cp 
	fi
done

# copy End2 of present samples into the relevant folder, testing that the files exist

for file_path in $cp_end2
do
file=$(echo $file_path | awk '{FS=" "; {print $1;}}')
if test -f "$sample_folder$file";
	then
	echo "$sample_folder$file_path" | xargs cp
	fi
done


# reset IFS to default

unset IFS
