#!/user/bin/bash

## run all of the commands from this file

## read in necessary files
### read in files

rm -fr temp
rm -fr hisat_index
rm -fr fastqc_output

echo -n 'Please enter the path to the folder containing the samples:'
read samples

# had sample_names=$(ls $samples) before to get a list of all the samples potentially remove

echo -n 'Please enter the path to the file containing sample details:'
read details

echo -n 'Please enter path to reference genome:'
read genome

echo -n 'Please enter path to reference bedfile:'
read bedfile


source make_folders.sh $samples $details

# file_path=${find temp -name "*.fq.gz"}

# source fastq_analysis.sh $samples $details $genome $bedfile 


