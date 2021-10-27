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
	mkdir -p  temp/$sample/induced/$time
	mkdir -p temp/$sample/uninduced/$time
	done
done
# mkdir temp/$sample_names
# for each line in the sample file, copy that sample into the relevant directory 

for line in $(awk '{FS="\t"; OFS="_"; {print $2,$4,$5,$6,$7;} {grep -v 'Sample_Time_Treatment_End1_End2'}}' /localdisk/data/BPSM/AY21/fastq/100k.fqfiles)
do
echo $line
sample_type=$(awk '{FS="_"; {print $1;}}' $line)
file_time=$(awk '{FS="_"; {print $2;}}' $line)
treatment$(awk '{FS="_"; {print $3;}}' $line)
end_1_file=$(awk '{FS"_"; {print $4;}}' $line)
end_2_file=$(awk '{FS"_"; {print $5;}}' $line)
	if  [ "$treatment" = "Uninduced" ]
	then
	cp $sample_folder/"$end_1_file" temp/$sample_type/uninduced/$file_time
	cp $sample_folder/"$end_2_file" temp/$sample_type/uninduced/$file_time 
	fi
done 
