#!/usr/bin/perl
use strict;
use warnings;
#base name of bootstrap replicate file names
my $i;
for($i = 0; $i < 100; $i++)
 {
 #open a queue submission file that we will populate with commands
 open (F, ">", "bootjob.$i");
 # the stuff below is cluster and installation-specific
 print F "#!/bin/bash\n";
 print F "#\n";
 print F "#SBATCH -n 1\n"; 
 print F "#SBATCH -N 1\n";
 print F "#SBATCH -p davis\n";
 print F "#SBATCH -o examl.out$i\n";
 print F "#SBATCH -e examl.err$i\n";
 print F "#SBATCH -t 7-0:00\n";
 print F "#\n";
 print F "module load centos6/ExaML-3.0.1\n";
 
 # here we assemble the command line that will execute the Pthreads version of raxmlLight on
 # shared-memory nodes with 48 cores and 48 threads
 print F "examl-AVX -t RAxML_parsimonyTree.T$i -m GAMMA -s all_broad.binary -n examl_boot.$i";
 # done editing the file, now just close it
 close(F);
 # now we can automatically submit the job to the queing system
 system("sbatch bootjob.$i");
}
