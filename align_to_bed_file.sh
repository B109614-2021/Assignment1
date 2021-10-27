### generate counts_per_gene.tsv using bedtools

# create a bed file allignment

echo 'aligning to bed file'

# count the number of overlaps between the reads and the genes, requiring 90% of the read to be overlapped for it to be counted

bedtools intersect -F 0.90 -c -a TriTrypDB-46_TcongolenseIL3000_2019.bed -b output.bam > output.txt

