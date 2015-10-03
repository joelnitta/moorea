# BLAST script 2015-09-03

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
makeblastdb -in ~/Analysis/moorea/data/rbcL_2015-09-03.fasta -out rbcL_id.db -dbtype nucl -hash_index

# trnHpsbA
# makeblastdb -in ~/Analysis/moorea/data/trnHpsbA_2015-08-30.fasta -out trnHpsbA_id.db -dbtype nucl -hash_index

#########################################################
#### testing the barcode: query library against self ####
#########################################################

# blastn -query rbcL.fasta -db rbcl_test.db -out rbcL_test.xls -outfmt 6 -max_target_seqs 2
# blastn -query trnHpsbA_all.fasta -db trnHpsbA_all.db -out trnHpsbA_all_test.xls -outfmt 6 -max_target_seqs 2

#######################################################################
#### gameto id: query each unknown fasta sequence against database ####
#######################################################################

# save top 2 hits
# output format is tab separated text

blastn -query ~/Analysis/moorea/data/rbcL_clean_gametos_2015-09-03.fasta -db rbcl_id.db -out blast_out_rbcL_id_2015-09-03.txt -outfmt 6 -max_target_seqs 2

# try this for short queries that don't show up in match above
# blastn -query gameto_2-4-15.fasta -db rbcl_id.db -out blast_out_gameto_short_2-4-15.txt -outfmt 6 -max_target_seqs 2 -task "blastn-short"

# trnHpsbA (check top 2 hits)
# blastn -query ~/Analysis/moorea/data/trnHpsbA_clean_gametos_2015-08-31.fasta -db trnHpsbA_id.db -out blast_out_trnHpsbA_id_08-31-15.txt -outfmt 6 -max_target_seqs 2

# to add header row to blast output
# $' \t ' indicates tab
# echo $'query_id\tsubject_id\t%_identity\talignment_length\tmismatches\tgap_opens\tq._start\tq._end\ts._start\ts._end\tevalue\tbit_score' | cat - blast_out_trnHpsbA_id_08-31-15.txt > blast_out_trnHpsbA_id_08-31-15_head.txt

###########################################
### blast seqs with no fern match to nr ###
###########################################

# see what my "no fern match" sequences blast to on Genbank
# customize output format to include taxonomic information for match
# see http://www.metagenomics.wiki/tools/blast/blastn-output-format-6

blastn -query ~/Analysis/moorea/data/rbcL.no_match.fasta -out blast_out_no_fern_match_rbcL.txt -db nr -remote -max_target_seqs 1         -outfmt "6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore staxids sscinames sblastnames sskingdoms stitle"
blastn -query ~/Analysis/moorea/data/trnHpsbA.no_match.fasta -out blast_out_no_fern_match_trnHpsbA.txt -db nr -remote -max_target_seqs 1 -outfmt "6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore staxids sscinames sblastnames sskingdoms stitle"