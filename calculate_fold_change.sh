#!/bin/bash

# want to split output file into samples ie Clone1, Clone2, WT, create a file for each with gene, gene desciption and uninduced/uninduced read counts for all time points
# Then divide by time point 0
# if heading sample name matches headed, extract

unset count

# make a fold change for each sample

for sample in $unique_samples
do
awk '{FS="\t"; OFS="\t"; {print $1, $2;}}' output/output.tsv > temp/fold_change_"$sample".tsv
done

# use a counter to get the correct index

count=1

for head in $headers
do
head_sample=$(echo $head | awk -F "_" '{print $1;}')

# if the first field of the header matches the sample name then extract
	for sample in $unique_samples
	do
		if [[ "$sample" == "$head_sample" ]]
		then
		awk -v count="$count" '{FS="\t"; {print $count;}}' output/output.tsv > temp/number_"$sample".tsv
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
echo $fold_changes
	for head in $(head -n 1 $fold_changes)
	do
	echo $head
		if [[ "$head" == *"Uninduced_0"* ]]
		then
		echo "match" 
		cut -f$counter $fold_changes > temp/"$sample"_time_0.tsv 
		fi
	counter=$((counter+1))
	done 
# find column with specific header, rm and save as seperate file 

done 
