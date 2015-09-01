# Script to run Digital RADs on Ceratopteris draft genome 2015-09-01
# see https://github.com/BU-RAD-seq/Digital_RADs

# NOTE: this will produce a whole bunch of small files in the directory where I run it.
# I DON'T want to sync all of these to my computer, so run in "~/Analysis/drad/2015-09-01" (not in "moorea", which has git repository)
# keep a copy of this script and the final output file only in "~/Analysis/moorea/bin/2015-09-01"

### only do this the first time ###
# find python3 module
# module avail 2>&1 | grep -i python
# download ceratopteris genome
# wget "http://digitalcommons.usu.edu/cgi/viewcontent.cgi?filename=4&article=1004&context=all_datasets&type=additional"

# start 8gb, 12hr interactive session
srun --pty -p interact --mem 8000 -n 1 -N 1 -t 0-12:00 /bin/bash

# load python
module load centos6/python-3.3.2

# EcorRI = GAATTC
# MseI = TTAA
# target size: 350 - 450 including adapters. 
# adapters are 76 bp total, so window without adapters is 274-374

python3 Digital_RADs.py ~/Analysis/moorea/data/ceratopteris_clc_k31.fasta ceratopteris_out 2 GAATTC TTAA 274 374
