#!/usr/bin/perl
use strict;
use warnings;
#base name of bootstrap replicate file names
my $bsname = "all_broad.phy.reduced.BS";
#parsimony random number seed range
my $range = 1000000000;
# loop over 100 bootstrap replicates
my $i;
my $random_number;
my $command;
for($i = 0; $i < 10; $i++)
 {
 # generate a random number seed for the randomized stepwise addition parsimony tree building process
 $random_number = int(rand($range));
 # build the command line string
 $command = "raxmlHPC-AVX -y -s ".$bsname.$i." -m GTRCAT -n T".$i." -p ".$random_number." \n";
 # execute the command
 system($command);
 }
