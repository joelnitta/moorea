#!/bin/bash
#
#SBATCH -n 8 # Number of cores
#SBATCH -N 10 # Running MPI, with 10 machines; 8 cores each.
#SBATCH -t 7-00:00 # Runtime in D-HH:MM
#SBATCH -p davis # Partition to submit to
#SBATCH --mem-per-cpu=1000 # Memory pool for each core
#SBATCH -o raxml.out # File to which STDOUT will be written
#SBATCH -e raxml.err # File to which STDERR will be written
#SBATCH --mail-type=ALL # Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=jnitta@fas.harvard.edu # Email to which notifications will be sent

source new-modules.sh

module load gcc/4.8.2-fasrc01 openmpi/1.8.1-fasrc04 raxml/8.1.5-fasrc02

raxmlHPC-HYBRID-SSE3 -T 8 -m GTRGAMMA -p 12345 -b 12345 -# 10 -s all_broad.phy.reduced -n all_broad_10boot
