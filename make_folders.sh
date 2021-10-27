#!/usr/bin/bash

# script that takes the input guide file, and sets up the desired folder structure.
# want a folder for each sample, containing a folder for control and sample, containing a folder for each time point

sample_names=$(awk '{FS="\t"; {print $2;}}' /localdisk/data/BPSM/AY21/fastq/100k.fqfiles | uniq | grep -v 'Sample')
times=$(awk '{FS="\t"; {print $4;}}' /localdisk/data/BPSM/AY21/fastq/100k.fqfiles | sort | uniq | grep -v 'Time')
sample_folder=/localdisk/data/BPSM/AY21/fastq

rm -r temp

echo $sample_names
echo $times

# make a folder for each sample, treatment and time. uninduced at time 0 is pretretment

for sample in $sample_names
do 
	for time in $times
	do
	mkdir -p  temp/$sample/Induced/$time
	mkdir -p temp/$sample/Uninduced/$time
	done
done
# mkdir temp/$sample_names
# for each line in the sample file, copy that sample into the relevant directory
# for line in $(awk '{FS="\t"; OFS="_"; {print $2,$4,$5,$6,$7;} {grep -v 'Sample_Time_Treatment_End1_End2'}}' /localdisk/data/BPSM/AY21/fastq/100k.fqfiles)

# for each unique sample id, copy file into relevant folder
# get unique sample IDs

# sample_IDs=$(awk '{FS="\t"; {print $1;}}' /localdisk/data/BPSM/AY21/fastq/100k.fqfiles)

cp_end1=$(awk '{FS="\t"; {print "/" $6 " temp/" $2 "/" $5 "/" $4 "\n";}}' /localdisk/data/BPSM/AY21/fastq/100k.fqfiles)
cp_end2=$(awk '{FS="\t"; {print "/" $7 " temp/" $2 "/" $5 "/" $4 "\n";}}' /localdisk/data/BPSM/AY21/fastq/100k.fqfiles)

IFS=$'\n'

for file_path in $cp_end1
do
echo $file_path
echo "$sample_folder$file_path" | xargs cp 

done

for file_path in $cp_end2
do
echo $file_path
echo "$sample_folder$file_path" | xargs cp

done

# cp $sample_folder,$cp_end1
#	if  [ "$treatment" = "Uninduced" ]
#	then
#	cp $sample_folder/$end_1_file temp/$sample_type/uninduced/$file_time
#	cp $sample_folder/$end_2_file temp/$sample_type/uninduced/$file_time 
#	fi

