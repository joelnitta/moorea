#!/bin/bash
#
#SBATCH -n 1                    # Number of cores
#SBATCH -N 1                    # Ensure that all cores are on one machine
#SBATCH -p serial_requeue       # Partition to submit to
#SBATCH --mem=10000               # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH -o raxml.out         # File to which STDOUT will be written
#SBATCH -e raxml.err         # File to which STDERR will be written
#SBATCH -t 1-0:00
#SBATCH --mail-type=ALL         # Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=jnitta@fas.harvard.edu # Email to which notifications will be sent

# Use RAxML to search for 20 ML trees, save the best one, then run 100 bootstrap replicates and write the bootstrap values to the best scoring tree
# see tutorial at http://sco.h-its.org/exelixis/web/software/raxml/hands_on.html, esp. Step 3 and 4

# load RAxML
module load centos6/RAxML-8.1.15_openmpi-1.6.4_gcc-4.8.0

# compute 20 ML trees, save the best one 
raxmlHPC -m GTRGAMMA -p 12345 -#20 -s rbcL_moorea_tahiti_8-14-15.phy -n rbcL_moorea_20ML 

# run 100 bootstraps
raxmlHPC -m GTRGAMMA -p 12345 -b 12345 -# 100 -s rbcL_moorea_tahiti_8-14-15.phy -n rbcL_moorea_100boot

# write bootstrap values to best scoring tree
raxmlHPC -m GTRCAT -p 12345 -f b -t RAxML_bestTree.rbcL_moorea_20ML -z RAxML_bootstrap.rbcL_moorea_100boot -n rbcL_moorea_MLboot 