# start interactive session (note, increase mem requested to 4gb)
srun --pty -p interact --mem 4000 -n 1 -N 1 -t 0-12:00 /bin/bash

### usually should be able to load module like this, but can't find it
# how to find module
# module avail 2>&1 | grep -i PATHd8
# load PATHd8
# module load 

### so instead, do local install of pathd8 in bin folder, run from there
# download PATHd8 uncompiled zip file from website: http://www2.math.su.se/PATHd8/compile.html
# unzip into this folder: bin/2015-09-28/PATHd8

# compile
cc PATHd8.c -O3 -lm -o PATHd8

# load formatted infile into bin/2015-09-28/PATHd8

# note: when saving infile, MUST specify
# line breaks = Windows
# encoding = UTF-8
# or will get this error: There is a format error occuring at "﻿Sequenc...

# run pathd8
./PATHd8 pathd8_broad_2015-09-28_windows_UTF-8.txt pathd8_broad_2015-09-28.out# start interactive session (note, increase mem requested to 4gb)
srun --pty -p interact --mem 4000 -n 1 -N 1 -t 0-06:00 /bin/bash

# DON'T RUN - how to find module
# module avail 2>&1 | grep -i PATHd8

# load PATHd8
# module load 

# having problems installing module, so do local install of pathd8 in bin folder, run from there
# bin/2015-09-28/PATHd8

# run pathd8
./PATHd8 pathd8_broad_2015-09-28.txt outfile pathd8_broad_2015-09-28.out
