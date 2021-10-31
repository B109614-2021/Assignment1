#!/user/bin/bash

## run all of the commands from this file

### read in files

rm -fr output
rm -fr temp
rm -fr hisat_index
rm -fr fastqc_output

mkdir output

echo -n 'Please enter the path to the folder containing the samples:'
read samples

echo -n 'Please enter the path to the file containing sample details:'
read details

echo -n 'Please enter path to reference genome:'
read genome

echo -n 'Please enter path to reference bedfile:'
read bedfile

### copy existing samples into the standard folder structure of <sample>/<treatment>/<time>

echo "Saving sample files in standard folder format"

source make_folders.sh $samples $details

# find the paths to all of the samples saved in the temp folder

file_path=$(find temp -name "*.fq.gz")

### run fastq_analysis

echo "performing FASTQC analysis"

source fastq_analysis.sh "$file_path"

### unzip files and build hisat index 

source prep_for_hisat.sh "$file_path" $genome

### run hisat alignment 

source run_hisat.sh  

### run sam to bam 

source convert_to_bam.sh

### align to bed fille

source align_to_bed_file.sh $bedfile

### calculate mean read numbers

source calculate_summary_statistics.sh

echo "Done"
