#!/bin/bash



############## Bash shell for producing a list of patients in sample ###########


# Need a list of patient IDs from BMX_D.csv with body measurement documentation

BMX_DIR='../data/original'

# take the list of patient IDs from BMX_D.csv and put them in a separate file
cut -f2 -d',' ${BMX_DIR}/BMX_D.csv | sort > ../data/derived/BMX_ID.csv


# Need a list of patient IDs from the names of accel files with PAM doc

# produce list of accel-___.txt names
ls ../data/original/accel > ../data/derived/accel_list.csv

# then substitute (remove) the accel- and the .txt
sed -i 's/accel-//' ../data/derived/accel_list.csv
sed -i 's/.txt//' ../data/derived/accel_list.csv




# Moving to script in R to do the formatting!!

# to put a 1 if both BM and PAM documenation is present, 0 if not

# Need the union of the two lists

