# start interactive session (note, increase mem requested to 4gb)
srun --pty -p interact --mem 4000 -n 1 -N 1 -t 0-06:00 /bin/bash

# working in examl folder
cd examl

# DON'T RUN - how to find module
# module avail 2>&1 | grep -i examl

# load ExaML
module load centos6/ExaML-3.0.1

# Step 1: parse .phy alignment into binary file
parse-examl -s rbcL_broad.phy -m DNA -n rbcL_broad_binary

# load RAxML
module load centos6/RAxML-8.1.15_openmpi-1.6.4_gcc-4.8.0

# Step 2: generate randomized stepwise addition parsimony tree with RAxML
raxmlHPC-AVX -y -m GTRCAT -p 12345 -s rbcL_broad.phy -n StartingTree

# Step 3: run examl using 1 processor
examl-AVX -t RAxML_parsimonyTree.StartingTree -m GAMMA -s rbcL_broad_binary.binary -n T1