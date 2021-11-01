#!/usr/bin/bash

# find the samples that have been placed in the temp files
rm -rf temp/fastqc_output

sample_path=$1

# for each sample in the temp folder, perform a fastqc analysis. save output to a fastqc output folder

mkdir temp/fastqc_output

# fastqc can do multiple at the same time, and as we're saving all in the same place don't need loop

fastqc -q -f fastq $sample_path --extract --outdir temp/fastqc_output

# the output is saved in the same folder as the sample with the sample name
# take summarry.text from each unzipped folder, want output table of <file> <Total sequences> <sequnces flagged as poor> <$GC content> test:<Basic statistics> <Per base sequence quality> etc
# list the pass/fail for each test 

# need to convert columns to rows 

echo -e "FQ_file\tBasic_Statistics\tPer_base_sequence_quality\tPer_sequence_quality_scores\tPer_base_sequence_content\tPer_sequence_GC_content\tPer_base_N_content\tSequence_Length_Distribution\tSequence_Duplication_Levels\tOverrepresented_sequences\tAdapter_Content" > output/FASTQC_summary.tsv

FQC_summaries=$(find temp/fastqc_output -name "summary.txt")

for file in $FQC_summaries
do
outcomes=$(awk '{OFS="\n"; {NF--; print $1}}' $file)
file_name=$(echo $file | awk -F "/" '{print $(NF-1);}')
echo -e $file_name "\t" $outcomes >> output/FASTQC_summary.tsv

done

## get read counts and add to summary 

echo "Total sequences" > temp/fastqc_output/total_seq.tsv
echo "%GC" > temp/fastqc_output/GC.tsv
echo "Number flagged as poor" > temp/fastqc_output/quality.tsv

FQC_data=$(find temp/fastqc_output -name "fastqc_data.txt")

for file in $FQC_data
do
grep "Total Seq" $file | cut -f 2 >> temp/fastqc_output/total_seq.tsv
grep "%GC" $file | cut -f 2 >> temp/fastqc_output/GC.tsv
grep "flagged as poor" $file | echo | cut -f 2 >> temp/fastqc_output/quality.tsv 
done

paste output/FASTQC_summary.tsv temp/fastqc_output/total_seq.tsv temp/fastqc_output/GC.tsv temp/fastqc_output/quality.tsv > temp/fastqc_output/fastqc_summary.tsv
cat temp/fastqc_output/fastqc_summary.tsv > output/FASTQC_summary.tsv
