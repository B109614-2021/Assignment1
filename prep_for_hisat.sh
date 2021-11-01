#!/bin/bash
### convert to HISAT2 useable format

sample_path=$1
genome=$2

# make a directory to hold annotation files 

mkdir temp/annotation 
 
# copy genome into annotation folder
cp $genome temp/annotation/genome.fasta.gz

# unzip genome

gunzip -q temp/annotation/genome.fasta.gz temp/annotation/genome.fasta

# need to use hisat2-build to create indexes for sequences to align to

echo "Creating index for HISAT"

mkdir temp/hisat_index

hisat2-build -q temp/annotation/genome.fasta temp/hisat_index/index

### alignment using HISAT

echo "unzipping sample files"

# need to unzip and save samples in their relevant folder with the same name


for FilePath in $sample_path
do
gunzip $FilePath --name
done


