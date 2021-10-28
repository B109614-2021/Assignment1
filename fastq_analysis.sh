#!/usr/bin/bash

# find the samples that have been placed in the temp files

sample_path=$1

# for each sample in the temp folder, perform a fastqc analysis

for FilePath in $sample_path
do
fastqc -q -f fastq --extract $FilePath

# the output is saved in the same folder as the sample with the sample name

       # filter for samples to be processed
       # fastcq
       # save results in a tmp_file
       # basic statistics can be found in the produced zip file in summary.txt and fastqc_data.txt
       # --extract unzips output file, want to extract the relevant info, save in new document then delete unzipped files
       # need correct field of file name to do this
done
