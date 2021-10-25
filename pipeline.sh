### read in files

rm -fr temp
rm -fr hisat_index
rm -fr fastqc_output

echo -n 'Please enter the path to the folder containing the samples:'
read samples
sample_names=$(ls $samples)

echo -n 'Please enter the path to the file containing sample details:'
read details

echo -n 'Please enter path to reference genome:'
read genome

echo -n 'Please enter path to referemce bedfile:'
read bedfile

# check that these files/folders exist 




# create a directory to hold temporary files in

mkdir temp
mkdir fastqc_output

echo "Analysing sample file quality" 

# use 100k.fqfiles to select sample files

#while read ID Sample Replicate Time Treatment End1 End2
#do	
#	for name in $sample_names
#	do  	
#	if [[ $name == $End1 || $name == $End2 ]]; then
#		FilePath="$samples$name"	  	
#		echo $FilePath
#		fastqc -o fastqc_output -f fastq --extract $FilePath 
#		fi
#	# filter for samples to be processed
#	# fastcq
#	# save results in a tmp_file
#	# basic statistics can be found in the produced zip file in summary.txt and fastqc_data.txt
#	# --extract unzips output file, want to extract the relevant info, save in new document then delete unzipped files
#	# need correct field of file name to do this  
#	done 
#done < $details 

# echo test_files

### quality control 


### convert to HISAT2 useable format

# need to unzip
cp $genome temp/genome.fasta.gz 

gunzip temp/genome.fasta.gz temp/genome.fasta
 
# need to use hisat2-build to create indexes for sequences to align to. comma-separated list of files with ref sequences 

echo "Creating index for HISAT"

mkdir hisat_index

hisat2-build -q temp/genome.fasta hisat_index/index 

### alignment using HISAT

echo "unzipping sample files"

# need to unzip and save into different folders depending on sample, clone and whether it is a replicate

while read ID Sample Replicate Time Treatment End1 End2
do
       for name in $sample_names
       do
       if [[ $name == $End1 || $name == $End2 ]]; then
	FilePath="$samples$name"
	cp $FilePath temp/$name
	gunzip temp/$name --name  
	fi
	done
done < $details

# Hisat2 -q for fastq (needs to be unzipped) --no-spliced-alignment to assume there are no splice sites, --qc-filter  remove bad reads 

fq_files=$(ls temp/100*)

echo "Creating sam file"

echo $fq_files

# potentially a problem with having . in file name 
# need to sort by condition and type prior to this, then create a sam for each condition and clone
# loop over file names with hisat, and rename for samfile (work on rename bit)

hisat2 -x hisat_index/index -q $fq_files -S output.sam  
  


# hisat2 [options]* -x <ht2-idx> {-1 <m1> -2 <m2> | -U <r>} [-S <sam>]
#
 # <ht2-idx>  Index filename prefix (minus trailing .X.ht2).
  #<m1>       Files with #1 mates, paired with files in <m2>.
 #            Could be gzip'ed (extension: .gz) or bzip2'ed (extension: .bz2).
 # <m2>       Files with #2 mates, paired with files in <m1>.
#             Could be gzip'ed (extension: .gz) or bzip2'ed (extension: .bz2).
#  <r>        Files with unpaired reads.
#             Could be gzip'ed (extension: .gz) or bzip2'ed (extension: .bz2).
#  <sam>      File for SAM output (default: stdout)
#
#  <m1>, <m2>, <r> can be comma-separated lists (no whitespace) and can be
#  specified many times.  E.g. '-U file1.fq,file2.fq -U file3.fq'.

### convert to bam file

echo "Converting from sam to bam format and creating index"

# add basic samtool commands for processing 1 sample

samtools view output.sam > output.bam
samtools sort output.bam -o output.bam
samtools index output.bam

### generate counts_per_gene.tsv using bedtools

# create a bed file allignment 

echo 'aligning to bed file'

bedtools intersect -c -a output.bam -b /localdisk/data/BPSM/AY21/TriTrypDB-46_TcongolenseIL3000_2019.bed -bed > output.bed

### calculate mean


### calculate fold change 
