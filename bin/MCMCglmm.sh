#!/bin/bash
#
#SBATCH -n 1                     # Number of cores
#SBATCH -N 1                      # Ensure that all cores are on one machine
#SBATCH -p davis                  # Partition to submit to
#SBATCH --mem=5000               # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH -o MCMCglmm_%j.out              # File to which STDOUT will be written
#SBATCH -e MCMCglmm_%j.err              # File to which STDERR will be written
#SBATCH -t 10-0:00                # run for max 10 days
#SBATCH --mail-type=ALL           # Type of email notification
#SBATCH --mail-user=jnitta@fas.harvard.edu

source new-modules.sh
module load R
R CMD BATCH --quiet --no-restore --no-save ~/Analysis/moorea/bin/MCMCglmm_habit.R MCMCglmm_habit_R.out
