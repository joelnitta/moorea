# BLAST script 2015-12-08

#############
### NOTES ###
#############

# for import FASTA, unknown bases must be "N", not "?"
# output fields: query id, subject id, % identity, alignment length, mismatches, gap opens, q. start, q. end, s. start, s. end, evalue, bit score
# rbcL_id (or trnHpsbA_id) is trimmed library without synonyms for id of gametos
# rbcL_test (or trnHpsbA_test) is raw data with multiple accessions/species to test barcode library for interspecific, intraspecific distances

#######################
#### make blast db ####
#######################

# rbcL
makeblastdb -in ~/R/moorea/bin/2015-12-08/rbcL_clean_sporos.fasta -out rbcL_id.db -dbtype nucl -hash_index
# trnHpsbA
makeblastdb -in ~/R/moorea/bin/2015-12-08/trnHpsbA_clean_sporos.fasta -out trnHpsbA_id.db -dbtype nucl -hash_index

#########################################################
#### testing the barcode: query library against self ####
#########################################################

blastn -query ~/R/moorea/bin/2015-12-08/rbcL_clean_sporos.fasta -db rbcL_id.db -out rbcL_test.xls -outfmt 6 -max_target_seqs 2
blastn -query ~/R/moorea/bin/2015-12-08/trnHpsbA_clean_sporos.fasta -db trnHpsbA_id.db -out trnHpsbA_test.xls -outfmt 6 -max_target_seqs 2

#######################################################################
#### gameto id: query each unknown fasta sequence against database ####
#######################################################################

# output format is tab separated text
##### save top 5 hits

# rbcL
blastn -query ~/R/moorea/data/rbcL_clean_gametos_2015-12-08.fasta -db rbcl_id.db -out blast_out_rbcL_id.txt -outfmt 6 -max_target_seqs 5
# trnHpsbA
blastn -query ~/R/moorea/data/trnHpsbA_clean_gametos_2015-12-08.fasta -db trnHpsbA_id.db -out blast_out_trnHpsbA_id.txt -outfmt 6 -max_target_seqs 5

# to add header row to blast output
# $' \t ' indicates tab
# echo $'query_id\tsubject_id\t%_identity\talignment_length\tmismatches\tgap_opens\tq._start\tq._end\ts._start\ts._end\tevalue\tbit_score' | cat - blast_out_trnHpsbA_id_08-31-15.txt > blast_out_trnHpsbA_id_08-31-15_head.txt

###########################################
### blast seqs with no fern match to nr ###
###########################################

# see what my "no fern match" sequences blast to on Genbank
# customize output format to include taxonomic information for match
# see http://www.metagenomics.wiki/tools/blast/blastn-output-format-6
# wanted to include taxonomic data (using these headers: staxids sscinames sblastnames sskingdoms) but only get N/A
# so instead look up taxonomy with R script

# blastn -query ~/R/moorea/bin/2015-10-04/rbcL.no_match.fasta -out blast_out_no_fern_match_rbcL.txt -db nr -remote -max_target_seqs 1         -outfmt "6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore staxids stitle"
# blastn -query ~/R/moorea/bin/2015-10-04/trnHpsbA.no_match.fasta -out blast_out_no_fern_match_trnHpsbA.txt -db nr -remote -max_target_seqs 1 -outfmt "6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore staxids stitle"

blastn -query ~/R/moorea/bin/2015-12-08/trnHpsbA.no_match.fasta -out blast_out_no_fern_match_trnHpsbA.txt -db nr -remote -max_target_seqs 1 -outfmt 6
blastn -query ~/R/moorea/bin/2015-12-08/rbcL.no_match.fasta -out blast_out_no_fern_match_rbcL.txt -db nr -remote -max_target_seqs 1 -outfmt 6