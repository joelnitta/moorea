# raxml_writeboot_interactive.sh

srun --pty -p interact --mem 4000 -n 1 -N 1 -t 0-01:00 /bin/bash

# need to load legacy raxml to run raxmlHPC-AVX

module load legacy

module load centos6/RAxML-8.1.15_openmpi-1.6.4_gcc-4.8.0

raxmlHPC-AVX -m GTRGAMMA -p 12345 -f b -t ../2015-12-29/raxml/RAxML_bestTree.all_broad_20ML -z ../2016-01-27-3/RAxML_bootstrap.all_broad_100boot -n all_broad.reduced 

