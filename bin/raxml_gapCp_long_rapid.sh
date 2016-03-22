#!/bin/bash
#
#SBATCH -n 1                     # Number of cores
#SBATCH -N 1                      # Ensure that all cores are on one machine
#SBATCH -p davis                  # Partition to submit to
#SBATCH --mem=1000               # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH -o raxml_%j.out              # File to which STDOUT will be written
#SBATCH -e raxml_%j.err              # File to which STDERR will be written
#SBATCH -t 10-0:00                # run for max 10 days
#SBATCH --mail-type=ALL           # Type of email notification
#SBATCH --mail-user=jnitta@fas.harvard.edu

# load RAxML
module load centos6/RAxML-8.1.15_openmpi-1.6.4_gcc-4.8.0

# Step 1: generate randomized stepwise addition parsimony tree with RAxML using full alignment
# only doing this to automatically generate "reduced" alignment with identical seqs removed
# so only need to do it once
# raxmlHPC-AVX -y -m GTRCAT -p 12345 -s ~/Analysis/moorea/data/gapCp_long.phy -n FullStartingTree

# Step 2
# compute best ML tree (out of 20?) and 100 bootstraps in a single step
# using trimmed alignment
# raxmlHPC -f a -m GTRGAMMA -p 12345 -x 12345 -# 100 -s ~/Analysis/moorea/data/gapCp_long.phy.reduced -n gapCp_long 
# using full alignment
raxmlHPC -f a -m GTRGAMMA -p 12345 -x 12345 -# 100 -s ~/Analysis/moorea/data/gapCp_long.phy -n gapCp_long 
