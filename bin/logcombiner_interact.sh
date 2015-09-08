# start interactive session (note, increase mem requested to 4gb)
srun --pty -p interact --mem 4000 -n 1 -N 1 -t 0-06:00 /bin/bash

# load beast
module load centos6/BEAST-2.1.2

# run logcombiner
logcombiner -log Moorea_Tahiti_2-4-14_dates.trees -b 25 -o Moorea_Tahiti_2-4-14.comb.trees