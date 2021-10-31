#!/bin/bash

# want to split output file into samples ie Clone1, Clone2, WT, create a file for each with gene, gene desciption and uninduced/uninduced read counts for all time points
# Then divide by time point 0
# if heading sample name matches headed, extract

headers=$(head -1 output/output.tsv)

unset counter

make a fold change for each sample

for sample in $unique_samples
do
awk '{FS="\t"; OFS="\t"; {print $4, $5;}}' TriTrypDB-46_TcongolenseIL3000_2019.bed > output/fold_change_"$sample".tsv
done


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
		paste output/fold_change_"$sample".tsv temp/number_"$sample".tsv > temp/growing_fold_change_"$sample".tsv
		cat temp/growing_fold_change_"$sample".tsv > output/fold_change_"$sample".tsv
		fi
	done 
count=$((count+1))
done




