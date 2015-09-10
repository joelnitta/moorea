# digitalrads BLAST script 2015-09-09

#############
### NOTES ###
#############

# for import FASTA, unknown bases must be "N", not "?"
# output fields: query id, subject id, % identity, alignment length, mismatches, gap opens, q. start, q. end, s. start, s. end, evalue, bit score

#######################
#### make blast db ####
#######################

makeblastdb -in ~/Analysis/moorea/data/ceratopteris_reformat.fasta -out ~/Analysis/moorea/data/ceratopteris_db/ceratopteris.db -dbtype nucl -hash_index

#######################
#### query radtags against blast db ####
#######################

# save top 2 hits
# output format is tab separated text

blastn -query ceratoperis_out.fasta -db ~/Analysis/moorea/data/ceratopteris_db/ceratopteris.db -out ceratopteris_radblast_results.txt -outfmt 6 -max_target_seqs 4