#### to do:: all of this

# need to extract gene and gene description from the given bed file, then extract the value column from the relevant folders and include for each gene

# want the format:
# gene	gene_description	C1_Un_0		C1_un_24	C1_un_48	C1_in_24	C1_in_48	C2_Un_0 	C2_un_24        C2_un_48        C2_in_24        C2_in_48	WT_Un_0 	WT_un_24        WT_un_48        WT_in_24        WT_in_48

bedfile=$1

# get gene and gene description from bedfile file  

echo -e "Gene\tDescription" > output/mean_read_counts.tsv

awk '{FS="\t"; OFS="\t"; {print $4, $5;}}' $bedfile >> output/mean_read_counts.tsv

# Find paths to output files. All have consistent name, aligned.txt

aligned_files=$(find temp -name "aligned.txt") 

# as the bedfile is used to make both the aligned outputs and this final output, the list of genes will be in the same order
# create a file with a heading relevant to the sample, then add the read counts. The ">" means this file will be overwritten for each loop

# To Do: divide number by number of replicates (currently all replicates of a condition are aligned to the same bed file) 

for output_file in $aligned_files
do
	# use file path to make a header
	echo "$output_file" | awk -F"/" '{OFS="_"; {print $2,$3,$4;}}' > temp/number.tsv

	# get the number of bamfiles
	folder=$(echo "$output_file" | awk -F"/" '{OFS="/"; {print $1,$2,$3,$4;}}')
	N_bam_files=$(find $folder -name "*.bam" |wc -w)
	
	# get the read counts, and divide by the number of bed files (which indicate the replicates)
	awk -F"\t" '{ OFS="\t"; {print $NF;}}' $output_file | while read i; do echo "scale = 2; $i/$N_bam_files" | bc; done >> temp/number.tsv

	# cannot paste directly into output/output.tsv, so make an intermediate file 
	paste output/mean_read_counts.tsv temp/number.tsv > temp/growing_output.tsv

	cat temp/growing_output.tsv > output/mean_read_counts.tsv
	# paste into output.tsv. each cycle another column will be added, and output.tsv remade with the extra column
done 


