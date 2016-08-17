#!/bin/bash
#
#SBATCH -n 2                     # Number of cores
#SBATCH -N 1                      # Ensure that all cores are on one machine
#SBATCH -p davis                  # Partition to submit to
#SBATCH --mem=2000               # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH -o raxml_%j.out              # File to which STDOUT will be written
#SBATCH -e raxml_%j.err              # File to which STDERR will be written
#SBATCH -t 10-0:00                # run for max 10 days
#SBATCH --mail-type=ALL           # Type of email notification
#SBATCH --mail-user=jnitta@fas.harvard.edu

# rbcL has 590 alignment patterns, rbcL_trnLF_both has 1100
# Alexis recommends 1 core per 500 patterns. So use two for all analyses
# His calculator says I only need 10 MB! Go with 2000 MB 
# could try running MPI for faster bootstraps, but let's try this.

# load RAxML
module load centos6/RAxML-8.1.15_openmpi-1.6.4_gcc-4.8.0

# compute best ML tree (out of 20?) using reduced alignment with 16 cores, save the best one with bootstrap
raxmlHPC-PTHREADS -T 2 -f a -m GTRGAMMA -p 12345 -x 12345 -# 1000 -s ~/Analysis/moorea/data/microsorum_rbcL.phy -n microsorum_rbcL