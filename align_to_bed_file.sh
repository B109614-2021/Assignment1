### generate counts_per_gene.tsv using bedtools

# create a bed file allignment

bed_file=$1

echo 'aligning to bed file'

# want to align all replicates of a sample at the same time 
# find all Bam files 

bam_files=$(find temp -name "*.bam")

for bam in $bam_files
do
path=$(echo "$bam" | awk -F "/" '{OFS="/"; {$NF=""; print $0;}}')
	for folder in $path
	do
	bedtools intersect -F 0.90 -c -a $bed_file -b $folder*.bam > $folder/aligned.txt
	done
done
# count the number of overlaps between the reads and the genes, requiring 90% of the read to be overlapped for it to be counted

