#!/bin/bash
#
#SBATCH -n 16                    # Number of cores
#SBATCH -N 1                    # Ensure that all cores are on one machine
#SBATCH -p davis       # Partition to submit to
#SBATCH --mem=32000               # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH -o raxml.out         # File to which STDOUT will be written
#SBATCH -e raxml.err         # File to which STDERR will be written
#SBATCH -t 4-0:00             # run for max 4 days
#SBATCH --mail-type=ALL         # Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=jnitta@fas.harvard.edu # Email to which notifications will be sent

# Use RAxML to search for 20 ML trees, save the best one, then run 100 bootstrap replicates and write the bootstrap values to the best scoring tree
# see tutorial at http://sco.h-its.org/exelixis/web/software/raxml/hands_on.html, esp. Step 3 and 4

# to get started, first try as interactive session
# srun --pty -p interact --mem 5000 -n 2 -N 1 -t 0-06:00 /bin/bash

# load RAxML
module load centos6/RAxML-8.1.15_openmpi-1.6.4_gcc-4.8.0

# compute 20 ML trees, save the best one
raxmlHPC-PTHREADS -T 16 -m GTRGAMMA -p 12345 -# 20 -s ~/Analysis/moorea/bin/2015-12-23/examl/all_broad.aln.phy -n all_broad_20ML

# run 100 bootstraps
# raxmlHPC-PTHREADS -T 16 -m GTRGAMMA -p 12345 -b 12345 -# 100 -s ~/Analysis/moorea/bin/2015-12-02/examl/all_broad.phy -n all_broad_100boot

# write bootstrap values to best scoring tree
# note that GTRGAMMA becomes GTRCAT. not sure why but that's what it says to do in the tutorial
# raxmlHPC-PTHREADS -T 16 -m GTRCAT -p 12345 -f b -t RAxML_bestTree.all_broad_20ML -z RAxML_bootstrap.all_broad_100boot -n all_broad_MLboot 

# the important output file (with branch lengths and bootstrap values) to keep is RAxML_bipartitions.rbcL_moorea_MLboot
# remove extra files

# rm *RUN*