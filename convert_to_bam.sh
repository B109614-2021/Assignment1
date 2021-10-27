### convert to bam file

echo "Converting from sam to bam format and creating index"

# add basic samtool commands for processing 1 sample

samtools view output.sam > output.bam
samtools sort output.bam -o output.bam
samtools index output.bam


