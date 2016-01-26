#!/bin/bash
#
#SBATCH -n 8                     # Number of cores
#SBATCH -N 1                      # Ensure that all cores are on one machine
#SBATCH -p davis                  # Partition to submit to
#SBATCH --mem=2000              # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH -o raxml.out              # File to which STDOUT will be written
#SBATCH -e raxml.err              # File to which STDERR will be written
#SBATCH -t 5-0:00                # run for max 5 days
#SBATCH --mail-type=ALL           # Type of email notification
#SBATCH --mail-user=jnitta@fas.harvard.edu

source new-modules.sh

module load gcc/4.8.2-fasrc01 openmpi/1.8.1-fasrc04 raxml/8.1.5-fasrc02

raxml -T 8 -m GTRGAMMA -p 12345 -b 12345 -N 2 -s all_broad.phy.reduced -n all_broad_2boot
