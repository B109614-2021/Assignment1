#while read ID Sample Replicate Time Treatment End1 End2
#do
#       for name in $sample_names
#       do
#       if [[ $name == $End1 || $name == $End2 ]]; then
#               FilePath="$samples$name"
#               echo $FilePath
#               fastqc -o fastqc_output -f fastq --extract $FilePath
#               fi
#       # filter for samples to be processed
#       # fastcq
#       # save results in a tmp_file
#       # basic statistics can be found in the produced zip file in summary.txt and fastqc_data.txt
#       # --extract unzips output file, want to extract the relevant info, save in new document then delete unzipped files
#       # need correct field of file name to do this
#       done
#done < $details
