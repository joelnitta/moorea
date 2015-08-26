# ran out of time to finish during interactive session. start from one of the checkpoints
# submit as batch this time, not interactive

#!/bin/bash
#
#SBATCH -n 1                    # Number of cores
#SBATCH -N 1                    # Ensure that all cores are on one machine
#SBATCH -p serial_requeue	# Partition to submit to
#SBATCH --mem=4000               # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH -o examl.out         # File to which STDOUT will be written
#SBATCH -e examl.err         # File to which STDERR will be written
#SBATCH -t 1-0:00
#SBATCH --mail-type=ALL         # Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=jnitta@fas.harvard.edu # Email to which notifications will be sent

module load centos6/ExaML-3.0.1

examl-AVX -s rbcL_broad_binary.binary -R ExaML_binaryCheckpoint.T1_2 -m GAMMA -n T1_RESTART