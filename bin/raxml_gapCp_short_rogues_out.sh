#!/bin/bash
#
#SBATCH -n 16                     # Number of cores
#SBATCH -N 1                      # Ensure that all cores are on one machine
#SBATCH -p davis                  # Partition to submit to
#SBATCH --mem=16000               # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH -o raxml_%j.out              # File to which STDOUT will be written
#SBATCH -e raxml_%j.err              # File to which STDERR will be written
#SBATCH -t 10-0:00                # run for max 10 days
#SBATCH --mail-type=ALL           # Type of email notification
#SBATCH --mail-user=jnitta@fas.harvard.edu

# load RAxML
module load centos6/RAxML-8.1.15_openmpi-1.6.4_gcc-4.8.0

# using full alignment
raxmlHPC-PTHREADS -T 16 -f a -m GTRGAMMA -p 12345 -x 12345 -# 1000 -s ~/Analysis/moorea/data/gapCp_short_rogues_out.phy -n gapCp_short_rogues_out