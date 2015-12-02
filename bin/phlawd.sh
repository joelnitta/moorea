#!/bin/bash
#
#SBATCH -n 1               			        # Number of cores
#SBATCH -N 1                			    # Ensure that all cores are on one machine
#SBATCH -p davis				    		# Partition to submit to
#SBATCH --mem=2000         			        # Memory pool for all cores. Request 2GB
#SBATCH -o phlawd.out     			    # File to which STDOUT will be written
#SBATCH -e phlawd.err       			    # File to which STDERR will be written
#SBATCH -t 1-0:00							# Request 1 day of processing time
#SBATCH --mail-type=ALL         			# Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=jnitta@fas.harvard.edu  # Email to which notifications will be sent

# run from ~/Analysis/moorea/bin/ (current date)

# load legacy modules
module load legacy

# load phlawd
module load centos6/phlawd

# run phlawd on configfile
PHLAWD assemble configfile
