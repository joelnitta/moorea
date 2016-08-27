#!/usr/bin/perl
use strict;
use warnings;
#base name of bootstrap replicate file names
my $i;
for($i = 0; $i < 8; $i++)
 {
 #open a queue submission file that we will populate with commands
 open (F, ">", "bootjob.$i");
 # setup the batch run
 print F "#!/bin/bash\n";
 print F "#\n";
 print F "#SBATCH -n 1\n"; 
 print F "#SBATCH -N 1\n";
 print F "#SBATCH --mem=100\n";
 print F "#SBATCH -p davis\n";
 print F "#SBATCH -o MCMCglmm.$i.bash.out\n";
 print F "#SBATCH -e MCMCglmm.$i.bash.err\n";
 print F "#SBATCH -t 1-0:00\n";
 print F "#\n";
 # load R module
 print F "source new-modules.sh\n";
 print F "module load R\n";
 # command to run each R script
 print F "R CMD BATCH --quiet --no-restore --no-save ~/Analysis/moorea/bin/MCMCglmm_habit.$i.R MCMCglmm_habit.$i.out";
 # done editing the file, now just close it
 close(F);
 # now we can automatically submit the job to the queing system
 system("sbatch bootjob.$i");
}