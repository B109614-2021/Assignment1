#### to do:: all of this

rm -r output 

# need to extract gene and gene description from the given bed file, then extract the value column from the relevant folders and include for each gene

# want the format:
# gene	gene_description	C1_Un_0		C1_un_24	C1_un_48	C1_in_24	C1_in_48	C2_Un_0 	C2_un_24        C2_un_48        C2_in_24        C2_in_48	WT_Un_0 	WT_un_24        WT_un_48        WT_in_24        WT_in_48

mkdir output

# get gene and gene description from bedfile file  

echo -e "Gene\tDescription" > output/output.tsv

awk '{FS="\t"; OFS="\t"; {print $4, $5;}}' TriTrypDB-46_TcongolenseIL3000_2019.bed >> output/output.tsv

# Find paths to output files. All have consistent name, aligned.txt

aligned_files=$(find temp -name "aligned.txt") 

# TO DO: loop, for each output file, for each gene in output/output, add number of reads matching
# as the bedfile is used to make both the aligned outputs and this final output, the list of genes will be in the same order
# create a file with a heading relevant to the sample, then add the read counts. The ">" means this file will be overwritten for each loop

# To Do: automatically get header
# To Do: divide number by number of replicates (currently all replicates of a condition are aligned to the same bed file) 

for output_file in $aligned_files
do
# use file path to make a header
echo "$output_file" | awk -F"/" '{OFS="_"; {print $2,$3,$4;}}' > temp/number.tsv

# get the read counts
awk -F"\t" '{print $NF}' $output_file >> temp/number.tsv

paste output/output.tsv temp/number.tsv > temp/growing_output.tsv
cat temp/growing_output.tsv > output/output.tsv
# paste into output.tsv. each cycle another column will be added, and output.tsv remade with the extra column

done 
