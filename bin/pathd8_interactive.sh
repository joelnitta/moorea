# start interactive session (note, increase mem requested to 4gb)
srun --pty -p interact --mem 4000 -n 1 -N 1 -t 0-06:00 /bin/bash

# start new module system
source new-modules.sh

# load PATHd8
module load PATHd8

# note: when saving infile, MUST specify
# line breaks = Windows
# encoding = UTF-8
# or will get this error: There is a format error occuring at "﻿Sequenc...

# run pathd8
PATHd8 pathd8_broad_2015-10-02.txt pathd8_broad_2015-10-02.out
