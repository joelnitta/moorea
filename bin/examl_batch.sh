#!/bin/bash
#
#SBATCH -n 1                    # Number of cores
#SBATCH -N 1                    # Ensure that all cores are on one machine
#SBATCH -p davis			    # Partition to submit to
#SBATCH --mem=4000             # Memory pool for all cores. Request 4GB
#SBATCH -o examl.out            # File to which STDOUT will be written
#SBATCH -e examl.err            # File to which STDERR will be written
#SBATCH -t 2-0:00				# Request 2 days of processing time
#SBATCH --mail-type=ALL         # Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=jnitta@fas.harvard.edu # Email to which notifications will be sent

# run from bin/examl/(date)

# load ExaML
module load centos6/ExaML-3.0.1

# load RAxML
module load centos6/RAxML-8.1.15_openmpi-1.6.4_gcc-4.8.0

# Step 1: parse .phy alignment into binary file
# parse-examl -s rbcL_phlawd_outgroup.phy -m DNA -n rbcL_phlawd_outgroup

# Step 2: generate randomized stepwise addition parsimony tree with RAxML
# raxmlHPC-AVX -y -m GTRCAT -p 12345 -s rbcL_phlawd_outgroup.phy -n StartingTree

# Step 3: run examl using 1 processor
examl-AVX -t RAxML_parsimonyTree.StartingTree -m GAMMA -s rbcL_phlawd_outgroup.binary -n rbcL_phlawd_examl
