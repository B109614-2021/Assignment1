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

# Hisat2 -q for fastq (needs to be unzipped) --no-spliced-alignment to assume there are no splice sites, --qc-filter  remove bad reads 


 hisat2 [options]* -x <ht2-idx> {-1 <m1> -2 <m2> | -U <r>} [-S <sam>]

  <ht2-idx>  Index filename prefix (minus trailing .X.ht2).
  <m1>       Files with #1 mates, paired with files in <m2>.
             Could be gzip'ed (extension: .gz) or bzip2'ed (extension: .bz2).
  <m2>       Files with #2 mates, paired with files in <m1>.
             Could be gzip'ed (extension: .gz) or bzip2'ed (extension: .bz2).
  <r>        Files with unpaired reads.
             Could be gzip'ed (extension: .gz) or bzip2'ed (extension: .bz2).
  <sam>      File for SAM output (default: stdout)

  <m1>, <m2>, <r> can be comma-separated lists (no whitespace) and can be
  specified many times.  E.g. '-U file1.fq,file2.fq -U file3.fq'.

### convert to bam file


### generate counts_per_gene.tsv using bedtools


### calculate mean


### calculate fold change 
