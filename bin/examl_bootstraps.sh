#!/bin/bash
#
#SBATCH -n 1                    # Number of cores
#SBATCH -N 1                    # Ensure that all cores are on one machine
#SBATCH -p davis			    # Partition to submit to
#SBATCH --mem=5000             # Memory pool for all cores. Request 5GB
#SBATCH -o examl.out            # File to which STDOUT will be written
#SBATCH -e examl.err            # File to which STDERR will be written
#SBATCH -t 4-0:00				# Request 4 days of processing time
#SBATCH --mail-type=ALL         # Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=jnitta@fas.harvard.edu # Email to which notifications will be sent

# run from bin/(date)

# load ExaML
module load centos6/ExaML-3.0.1

# load RAxML
module load centos6/RAxML-8.1.15_openmpi-1.6.4_gcc-4.8.0

# Step 1: generate randomized stepwise addition parsimony tree with RAxML using full alignment
# only doing this to automatically generate "reduced" alignment with identical seqs removed
raxmlHPC-AVX -y -m GTRCAT -p 12345 -s all_broad.phy -n FullStartingTree

# Step 2: parse reduced alignment into binary file for examl
parse-examl -s all_broad.phy.reduced -m DNA -n all_broad.reduced

# Step 3: generate 10 bootstrap replicates (BS)
raxmlHPC-AVX -N 10 -b 12345 -f j -m GTRGAMMA -s all_broad.phy.reduced -n REPS

# Step 4: use perl script to generate MP starting tree from each bootstrap replicate
perl ../perl/raxml_startingtree.pl

# Step 5: use perl script to submit an examl job for each starting tree
perl ../perl/examl.pl

# run Steps 6-8 either interactively or as separate script once examl bootstrap runs are done

# Step 6: combine all resulting examl bootstrap trees into single file
# cat ExaML_result.examl_boot.* > boot_trees

# Step 7: don't need examl checkpoint files anymore, so get rid of those
# rm ExaML_binaryCheckpoint*

# Step 8: write bootstrap scores to best ML tree
# raxmlHPC -f b -m GTRGAMMA -z boot_trees -t RAxML_bestTree.MLtree -n Bootstrap_tree