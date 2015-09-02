# Stacks Script 
# based on A. plantagineum Run 2 6-19-15

################
### Ustacks  ### 
################

# The unique stacks program will take as input a set of short-read sequences and align them into exactly-matching stacks
# Comparing the stacks it will form a set of loci and detect SNPs at each locus using a maximum likelihood framework

# run separately for each individual, change -f (input fastq file) AND -i (run SQL id number). 
# need to assign a new SQL id (have to use digits only) for each sample
# SQL id scheme for Ustacks:
# ABBCC
# A = 1 = ustacks
# BB = 01 = A plantagineum
# CC = 01 = individual
# so, -i 10101, -i 10102, -i 10103, etc
# individual codes in excel file (Joel ddigestion samples with barcodes.xlsx)

# settings notes
# m — Minimum depth of coverage required to create a stack (default 2).
# M — Maximum distance (in nucleotides) allowed between stacks (default 2).
# r — enable the Removal algorithm, to drop highly-repetitive stacks (and nearby errors) from the algorithm.
# d — enable the Deleveraging algorithm, used for resolving over merged tags.
# --max_locus_stacks [num] — maximum number of stacks at a single de novo locus (default 3).
# --model_type [type] — either 'snp' (default), 'bounded', or 'fixed'
# --bound_high [num] — upper bound for epsilon, the error rate, between 0 and 1.0 (default 1).

# note: maybe set M to 0 for haploid (because this is within an individual)
# also set max_locus_stacks to 1

ustacks -t fastq -f ./JNG3117_1.fq -o ./A_pla_run2 -i 10101 -p 15 -r -d -m 3 -M 2 --max_locus_stacks 3 --model_type bounded --bound_high 0.05
ustacks -t fastq -f ./JNG3117_2.fq -o ./A_pla_run2 -i 10102 -p 15 -r -d -m 3 -M 2 --max_locus_stacks 3 --model_type bounded --bound_high 0.05
ustacks -t fastq -f ./JNG3127_2.fq -o ./A_pla_run2 -i 10103 -p 15 -r -d -m 3 -M 2 --max_locus_stacks 3 --model_type bounded --bound_high 0.05
ustacks -t fastq -f ./JNG3093.fq -o ./A_pla_run2 -i 10104 -p 15 -r -d -m 3 -M 2 --max_locus_stacks 3 --model_type bounded --bound_high 0.05
ustacks -t fastq -f ./JNG3125.fq -o ./A_pla_run2 -i 10105 -p 15 -r -d -m 3 -M 2 --max_locus_stacks 3 --model_type bounded --bound_high 0.05
ustacks -t fastq -f ./JNG3126.fq -o ./A_pla_run2 -i 10106 -p 15 -r -d -m 3 -M 2 --max_locus_stacks 3 --model_type bounded --bound_high 0.05

################
### Cstacks ####
################

# A catalog can be built from any set of samples processed by the ustacks or pstacks programs. 
# It will create a set of consensus loci, merging alleles together.

# use ca. 6-8 individuals per species at a time <- no need for this, just run all together
# run all on a single line of code

# SQL id scheme for cstacks:
# ABBCC
# A = 2 = cstacks
# BB = 01 = A plantagineum
# CC = 02 = second run
# so, -b 20102 = catalog batch

# s — TSV file from which to load radtags
# n — number of mismatches allowed between sample tags when generating the catalog
# p — enable parallel execution with num_threads threads

cstacks -b 20102 -s ./A_pla_run2/JNG3093 / -s ./A_pla_run2/JNG3117_1 -s ./A_pla_run2/JNG3117_2 -s ./A_pla_run2/JNG3125 -s ./A_pla_run2/JNG3126 -s ./A_pla_run2/JNG3127_2 -o ./A_pla_run2 -n 3 -p 15

################
### Sstacks  ###
################

# Sets of stacks constructed by the ustacks or pstacks programs can be searched against a catalog produced by cstacks
# Use to determine the haplotypes at all loci for each individual.

# SQL id scheme for sstacks:
# ABBCC
# A = 3 = sstacks
# BB = 01 = A plantagineum
# CC = 02 = run
# so, -b 30102

sstacks -b 30102 -c ./A_pla_run2/batch_20102 -s ./A_pla_run2/JNG3093 -s ./A_pla_run2/JNG3117_1 -s ./A_pla_run2/JNG3117_2  -s ./A_pla_run2/JNG3125 -s ./A_pla_run2/JNG3126 -s ./A_pla_run2/JNG3127_2 -o ./A_pla_run2

###################
### Populations ###
###################

# The populations program will analyze a population of individual samples computing a number of population genetics statistics as well as exporting a variety of standard output formats. 
# A map specifying which individuals belong to which population is submitted to the program and the program will then calculate population genetics statistics such as expected/observed heterozygosity, π, and FIS at each nucleotide position.

# b — Batch ID to examine when exporting from the catalog
# P — path to the Stacks output files
# M — path to the population map, a tab separated file describing which individuals belong in which population
# r — minimum percentage of individuals in a population required to process a locus for that population
# p — minimum number of populations a locus must be present in to process a locus
# m — specify a minimum stack depth required for individuals at a locus

# first populations run (store in ./A_pla_run2/populations output 1)
# restrict to only loci that occur in all individuals (-r 1), min depth 7

# maybe relax r to 0.75, increase p (sharing across populations)

populations -b 20102 -P ./A_pla_run2/ -M ./popmap_A_pla.txt -r 1 -p 1 -m 7

# second populations run
# slightly lower min depth
populations -b 20102 -P ./A_pla_run2/ -M ./popmap_A_pla.txt -r 1 -p 1 -m 5

# third populations run
# try with output for structure
populations -b 20102 -P ./A_pla_run2/ -M ./popmap_A_pla.txt -r 1 -p 1 -m 5 --structure

# 4th populations run
# try changing r parameter so that only require 1 individual per pop, 2 individuals per pop… etc up to 6 individuals per pop. Look at sumstats_summary.tsv to try and find weird individual.

populations -b 20102 -P ./A_pla_run2/ -M ./popmap_A_pla2.txt -r .15 -p 1 -m 7

# NOTE: in order to get into correct format for structure, had to edit output file (batch_20102.structure.tsv).
# Seemed to include extra column of 1's after individual name, so deleted those
# Also deleted first comment line
# Also needed to count number of alleles

