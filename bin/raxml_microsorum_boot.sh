#!/bin/bash
#
#SBATCH -n 64 # Number of cores
#SBATCH --nodelist=holydavis01
#SBATCH -t 10-00:00 # Runtime in D-HH:MM
#SBATCH -p davis # Partition to submit to
#SBATCH --mem-per-cpu=100 # Memory pool for each core (estimate 17mb per tree, give 100mb to be on very safe side)
#SBATCH -o raxml_%j.out # File to which STDOUT will be written
#SBATCH -e raxml_%j.err # File to which STDERR will be written
#SBATCH --mail-type=ALL # Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=jnitta@fas.harvard.edu # Email to which notifications will be sent

source new-modules.sh

module load gcc/4.8.2-fasrc01 openmpi/1.8.1-fasrc04 raxml/8.1.5-fasrc02

mpirun -np 32 raxmlHPC-HYBRID-SSE3 -T 2 -m GTRGAMMA -p 12345 -b 12345 -N 100 -s ../../data/microsorum_plastid.phy.reduced -n microsorum_100boot
