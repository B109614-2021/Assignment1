### read in files

echo -n 'Please enter the path to the folder containing the samples:'
read samples
sample_names=$(ls $samples)

echo $sample_names

mkdir temp

unset count

while read ID Sample Replicate Time Treatment End1 End2
do	
	for name in $sample_names
	do 
	echo $name 	
	if [[ $name == $End1 || $name == $End2 ]]; then
		  	
		echo "matches" 
		fi
	# filter for samples to be processed
	# fastcq 
	# save results as a tmp_file  
	done 
done < /localdisk/data/BPSM/AY21/fastq/100k.fqfiles

# echo test_files

### quality control 


### convert to HISAT2 useable format


### alignment using HISAT


### convert to bam file


### generate counts_per_gene.tsv using bedtools


### calculate mean


### calculate fold change 
