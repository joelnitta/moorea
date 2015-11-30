# start interactive session
srun --pty -p interact --mem 4000 -n 1 -N 1 -t 0-06:00 /bin/bash

# load fasttree
module load fasttree

# run fasttree on alignment
FastTree -gtr -nt ../2015-11-28/phlawd_atpA/atpA.FINAL.aln.rn > atpA_phlawd_fasttree.tre
