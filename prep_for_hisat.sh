### convert to HISAT2 useable format

# need to unzip
cp $genome temp/genome.fasta.gz

gunzip temp/genome.fasta.gz temp/genome.fasta

# need to use hisat2-build to create indexes for sequences to align to. comma-separated list of files with ref sequences

echo "Creating index for HISAT"

mkdir hisat_index

hisat2-build -q temp/genome.fasta hisat_index/index

### alignment using HISAT

echo "unzipping sample files"

# need to unzip and save into different folders depending on sample, clone and whether it is a replicate

while read ID Sample Replicate Time Treatment End1 End2
do
       for name in $sample_names
       do
       if [[ $name == $End1 || $name == $End2 ]]; then
        FilePath="$samples$name"
        cp $FilePath temp/$name
        gunzip temp/$name --name
        fi
        done
done < $details


