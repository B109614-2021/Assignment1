### read in files

echo -n 'Please enter the path to the folder containing the samples:'
read samples
sample_names=$(ls $samples)

echo -n 'Please enter the path to the file containing sample details:'
read details

# create a directory to hold temporary files in

mkdir temp
# mkdir fastqc_output 
unset count

# use 100k.fqfiles to select sample files

while read ID Sample Replicate Time Treatment End1 End2
do	
	for name in $sample_names
	do  	
	if [[ $name == $End1 || $name == $End2 ]]; then
		FilePath="$samples$name"	  	
		echo $FilePath 
		fi
	# filter for samples to be processed
	# fastcq 
	# save results in a tmp_file
	# basic statistics can be found in the produced zip file in summary.txt and fastqc_data.txt  
	done 
done < $details 

# echo test_files

### quality control 


### convert to HISAT2 useable format


### alignment using HISAT


### convert to bam file


### generate counts_per_gene.tsv using bedtools


### calculate mean


### calculate fold change 
