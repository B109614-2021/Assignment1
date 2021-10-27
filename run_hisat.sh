
#### To do: make this run for the paired ends

# Hisat2 -q for fastq (needs to be unzipped) --no-spliced-alignment to assume there are no splice sites, --qc-filter  remove bad reads

fq_files=$(ls temp/100*)

echo "Creating sam file"

echo $fq_files

# potentially a problem with having . in file name
# need to sort by condition and type prior to this, then create a sam for each condition and clone
# loop over file names with hisat, and rename for samfile (work on rename bit)

hisat2 -x hisat_index/index -q $fq_files -S output.sam



# hisat2 [options]* -x <ht2-idx> {-1 <m1> -2 <m2> | -U <r>} [-S <sam>]
#
 # <ht2-idx>  Index filename prefix (minus trailing .X.ht2).
  #<m1>       Files with #1 mates, paired with files in <m2>.
 #            Could be gzip'ed (extension: .gz) or bzip2'ed (extension: .bz2).
 # <m2>       Files with #2 mates, paired with files in <m1>.
#             Could be gzip'ed (extension: .gz) or bzip2'ed (extension: .bz2).
#  <r>        Files with unpaired reads.
#             Could be gzip'ed (extension: .gz) or bzip2'ed (extension: .bz2).
#  <sam>      File for SAM output (default: stdout)
#
#  <m1>, <m2>, <r> can be comma-separated lists (no whitespace) and can be
#  specified many times.  E.g. '-U file1.fq,file2.fq -U file3.fq'.

