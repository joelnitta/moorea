# BLAST script 2015-08-31

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
# makeblastdb -in rbcl_id.fasta -out rbcL_id.db -dbtype nucl -hash_index

# trnHpsbA
makeblastdb -in ~/Analysis/moorea/data/trnHpsbA_2015-08-30.fasta -out trnHpsbA_id.db -dbtype nucl -hash_index

#########################################################
#### testing the barcode: query library against self ####
#########################################################

blastn -query rbcL.fasta -db rbcl_test.db -out rbcL_test.xls -outfmt 6 -max_target_seqs 2
blastn -query trnHpsbA_all.fasta -db trnHpsbA_all.db -out trnHpsbA_all_test.xls -outfmt 6 -max_target_seqs 2

#######################################################################
#### gameto id: query each unknown fasta sequence against database ####
#######################################################################

# save top 2 hits
# output format is tab separated text

blastn -query plate52rbcL.fasta -db rbcl_id.db -out blast_out_plate52rbcL.txt -outfmt 6 -max_target_seqs 2

# try this for short queries that don't show up in match above
blastn -query gameto_2-4-15.fasta -db rbcl_id.db -out blast_out_gameto_short_2-4-15.txt -outfmt 6 -max_target_seqs 2 -task "blastn-short"

# trnHpsbA (check top 2 hits)
blastn -query ~/Analysis/moorea/data/trnHpsbA_clean_gametos_2015-08-31.fasta -db trnHpsbA_id.db -out blast_out_trnHpsbA_id_08-31-15.txt -outfmt 6 -max_target_seqs 2
