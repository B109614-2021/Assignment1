### convert to bam file

echo "Converting from sam to bam format and creating index"

sam_files=$(find temp -name "*.sam")

# add basic samtool commands for processing 1 sample
# need paths to sam files
# need outputs to be returned in same folder. 

for sam in $sam_files
do
# get the sample name ie C2-3-521 and path to the file
 
file_name=$(echo "$sam" | awk -F [".","/"] '{print $(NF-1);}')
path=$(echo "$sam" | awk -F "/" '{OFS="/"; {$NF=""; print $0;}}')

# use samtools to convert into bam format, sort into order for alignment to bedfile and create an index 

samtools view -b "$sam" > "$path$file_name".bam
samtools sort "$path$file_name".bam -o "$path$file_name".bam
samtools index "$path$file_name".bam
done


# There should be one bam file for each sample pair in the set file format
