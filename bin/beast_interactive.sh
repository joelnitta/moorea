# start interactive session (note, increase mem requested to 4gb)
srun --pty -p interact --mem 4000 -n 2 -N 1 -t 0-12:00 /bin/bash

source new-modules.sh

module load BEAST

module load beagle

# give beast more memory
java -Xms1024m -Xmx1024m -jar lib\beast.jar

# run BEAST
beast -beagle_instances 2 -threads 2 rbcL_broad_2015-09-29_v3.xml