### read in files

echo -n 'Please enter the path to the folder containing the samples:'
read samples
sample_names=$(ls $samples)

echo $sample_names

unset count

for name in $sample_names

	# filter for samples to be processed
	# fastcq 
	# save results as a tmp_file 

do 
count=$((count+1))
echo $count 
done 

# echo test_files

### quality control 


### convert to HISAT2 useable format


### alignment using HISAT


### convert to bam file


### generate counts_per_gene.tsv using bedtools


### calculate mean


### calculate fold change 
