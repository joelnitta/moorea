# start interactive session (note, increase mem requested to 4gb)
srun --pty -p interact --mem 4000 -n 1 -N 1 -t 0-10:00 /bin/bash

# load r8s

module load hpc/r8s-1.71

r8s -f rbcL_broad_rates_reroot_v3.nex -b