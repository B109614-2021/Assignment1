### read in files

echo -n 'Please enter the path to the folder containing the samples:'
read samples
ls $samples

mkdir tmp
cp $samples tmp
ls tmp/
rm -r tmp
 
# test_files=$(grep -v 100k.fqfiles < ls $samples)

# echo test_files

### quality control 


### convert to HISAT2 useable format


### alignment using HISAT


### convert to bam file


### generate counts_per_gene.tsv using bedtools


### calculate mean


### calculate fold change 
