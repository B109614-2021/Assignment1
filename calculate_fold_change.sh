#!/bin/bash

# want to split output file into samples ie Clone1, Clone2, WT, create a file for each with gene, gene desciption and uninduced/uninduced read counts for all time points
# Then divide by time point 0
# if heading sample name matches header, extract

# get details file from parent

details=$1

# running the script if the temp versions already exist, so remove if running the sample individually these need to be removed
rm -f temp/growing_fold*
rm -f temp/fold_change*
 
unset count

# get the names of the different samples 

unique_samples=$(awk '{FS="\t"; {print $2;}}' $details | uniq | grep -v 'Sample')

# get the headers from mean_read_counts.tsv

headers=$(head -n 1 output/mean_read_counts.tsv)

# make a fold change temp file for each sample, including the gene and gene name

for sample in $unique_samples
do
awk '{FS="\t"; OFS="\t"; {print $1, $2;}}' output/mean_read_counts.tsv > temp/fold_change_"$sample".tsv
done

# use a counter to get the correct index

count=1

for head in $headers
do
head_sample=$(echo $head | awk -F "_" '{print $1;}')
# if the first field of the header matches the sample name then extract column into a temp file then add to sample fold change file
	for sample in $unique_samples
	do
		if [[ "$sample" == "$head_sample" ]]
		then
		awk -v count="$count" '{FS="\t"; {print $count;}}' output/mean_read_counts.tsv > temp/number_"$sample".tsv
		paste temp/fold_change_"$sample".tsv temp/number_"$sample".tsv > temp/growing_fold_change_"$sample".tsv
		cat temp/growing_fold_change_"$sample".tsv > temp/fold_change_"$sample".tsv
		fi
	done 
count=$((count+1))
done

# find fold change samples
# for each one, remove time 0 column and divide other columns by time 0

for sample in $unique_samples
do
counter=1
fold_changes=$(find temp -name "fold_change*$sample*")
	for head in $(head -n 1 $fold_changes)
	do
	# find column with specific header, rm and save as seperate file
		if [[ "$head" == *"Uninduced_0"* ]]
		then
		# get uninduced_0, get everything apart from the header, and add 1 to remove any zeros. removing headers so dividing is easier later
		cut -f$counter $fold_changes | tail -n +2 |while read i; do echo "scale = 2; $i + 1" | bc; done > temp/"$sample"_time_0.tsv 
		cut -f$counter --complement $fold_changes > temp/"$sample"_no_time_0.tsv
		fi
	counter=$((counter+1))
	done 
done 

# take the temp/"$sample"_no_time_0 and divide columns (bar 1 and 2) by temp/"$sample"_time_0.tsv

unset counter_2

for sample in $unique_samples
do
awk '{FS="\t"; OFS="\t"; {print $1, $2;}}' output/mean_read_counts.tsv > temp/fold_change_"$sample"_2.tsv
counter_2=1
fold_changes_2=$(find temp -name "$sample"_no_time_0*)
        for head in $(head -n 1 $fold_changes_2)
	do
		# make sure to not use columns with strings
                if [[ "$head" == *"nduced"* ]]
		then

		# add a header to temp file 
		echo $head > temp/fold_change_value_"$sample".tsv

		# get the header index, removing header so only values are taken
		cut -f$counter_2 temp/"$sample"_no_time_0.tsv | tail -n +2 > temp/division.tsv

		# divide by value at time 0 
		paste temp/"$sample"_time_0.tsv temp/division.tsv | while read time_0 test; do echo "scale = 2; $test/$time_0" | bc; done >> temp/fold_change_value_"$sample".tsv 

		# save in output file
		paste temp/fold_change_"$sample"_2.tsv temp/fold_change_value_"$sample".tsv > temp/growing_fold_change_"$sample"_2.tsv
		cat temp/growing_fold_change_"$sample"_2.tsv > temp/fold_change_"$sample"_2.tsv
		fi
	counter_2=$((counter_2+1))
        done
head -n 1 temp/fold_change_"$sample"_2.tsv > output/fold_change_"$sample".tsv

# sort by values in column 4 (induced 48h)
tail -n +2 temp/fold_change_"$sample"_2.tsv | sort -t$'\t' -k4 -nr >> output/fold_change_"$sample".tsv

done

# there should now be a fold_change file, sorted by max value at induced 48h, for each sample



