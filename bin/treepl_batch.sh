#!/bin/bash
#
#SBATCH -n 10               			        # Number of cores
#SBATCH -N 1                			    # Ensure that all cores are on one machine
#SBATCH -p davis						    # Partition to submit to
#SBATCH --mem=6000        			        # Memory pool for all cores. Request 6GB
#SBATCH -o treepl.out     			    # File to which STDOUT will be written
#SBATCH -e treepl.err       			    # File to which STDERR will be written
#SBATCH -t 4-0:00							# Request 4 days of processing time
#SBATCH --mail-type=ALL         			# Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=jnitta@fas.harvard.edu  # Email to which notifications will be sent

# load new modules
source new-modules.sh

# load gcc and treepl
module load gcc/4.8.2-fasrc01 treePL/1.0-fasrc01

# run treepl
treePL configfile
