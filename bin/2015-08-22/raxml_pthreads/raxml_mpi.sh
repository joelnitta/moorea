#!/bin/bash
#
#SBATCH -n 10                    # Number of cores
#SBATCH -N 1                    # Ensure that all cores are on one machine
#SBATCH -p general       # Partition to submit to
#SBATCH --mem=10000               # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH -o raxml.out         # File to which STDOUT will be written
#SBATCH -e raxml.err         # File to which STDERR will be written
#SBATCH -t 1-0:00
#SBATCH --mail-type=ALL         # Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=jnitta@fas.harvard.edu # Email to which notifications will be sent

# Use RAxML to search for 20 ML trees, save the best one, then run 100 bootstrap replicates and write the bootstrap values to the best scoring tree
# see tutorial at http://sco.h-its.org/exelixis/web/software/raxml/hands_on.html, esp. Step 3 and 4
# this version runs using 10 cores

# load openmpi
module load centos6/openmpi-1.7.2_intel-13.0.079

# load raxml
module load centos6/RAxML-8.0.16_openmpi-1.7.2_intel-13.0.079

# compute 20 ML trees, save the best one 

# (haven't figured out mpirun command for this yet)

# run 100 bootstraps
mpirun -np 10 raxmlHPC-PTHREADS -T 10 -m GTRGAMMA -p 12345 -b 12345 -# 100 -s rbcL_moorea_tahiti_8-14-15.phy -n rbcL_moorea_100boot > output.txt 2> errors.txt

# write bootstrap values to best scoring tree

# (haven't figured out mpirun command for this yet)
