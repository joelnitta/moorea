#!/bin/bash
#
#SBATCH -n 1               			        # Number of cores
#SBATCH -N 1                			    # Ensure that all cores are on one machine
#SBATCH -p serial_requeue				    # Partition to submit to
#SBATCH --mem=12000         			        # Memory pool for all cores. Request 12GB
#SBATCH -o phlawd_db.out     			    # File to which STDOUT will be written
#SBATCH -e phlawd_db.err       			    # File to which STDERR will be written
#SBATCH -t 4-0:00							# Request 4 days of processing time
#SBATCH --mail-type=ALL         			# Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=jnitta@fas.harvard.edu  # Email to which notifications will be sent

# run from /n/regal/davis_lab/jnitta/genbank2

# load phlawd
module load centos6/phlawd

# run phlawd setupdb on setup file (all plants)
PHLAWD setupdb db.setup
