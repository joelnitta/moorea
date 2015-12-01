#!/bin/bash
#
#SBATCH -n 1               			        # Number of cores
#SBATCH -N 1                			    # Ensure that all cores are on one machine
#SBATCH -p davis						    # Partition to submit to
#SBATCH --mem=12000        			        # Memory pool for all cores. Request 12GB
#SBATCH -o fasttree.out     			    # File to which STDOUT will be written
#SBATCH -e fasttree.err       			    # File to which STDERR will be written
#SBATCH -t 4-0:00							# Request 4 days of processing time
#SBATCH --mail-type=ALL         			# Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=jnitta@fas.harvard.edu  # Email to which notifications will be sent

# start interactive session
# srun --pty -p interact --mem 4000 -n 1 -N 1 -t 0-01:00 /bin/bash

# load new modules
source new-modules.sh

# load fasttree
module load fasttree

# run fasttree on alignment
FastTree -gtr -nt all_broad.aln.fasta > all_broad.tre
