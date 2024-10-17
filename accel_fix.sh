#!/bin/bash

# set directory of original accel data
cd /mnt/c/Users/charl/Dropbox/PC/Documents/"Bristol Uni"/AHDS/"Week 3"/formative_assessment/data/original/accel
                                                                                                                                                                              ######## Fixing any syntax #####################                                                                                                                              # current dir: formative_assessment/data/original/short_accel                                                                                                                 ## Removing the ID line, so that the first line is the header                          # "PAXSTAT"     "PAXCAL"        "PAXDAY"        "PAXN"  "PAXHOUR"       "PAXMINUT"    >
##### Bash shell fixing syntax errors in accel text files


echo "Removing the ID line, leaving the header as the first line"

# Make new directory with derived data
#mkdir ../../derived/accel

# copy the data into it
#cp ./accel*.txt ../../derived/accel

# remove the first line ('1d' says delete line 1)
#sed -i '1d' ../../derived/accel/accel*.txt


# Check 1st line of all accel is as expected
#header='"PAXSTAT"\t"PAXCAL"\t"PAXDAY"\t"PAXN"\t"PAXHOUR"\t"PAXMINUT"\t"PAXINTEN"\t"PAXSTEP"'
header='"PAXSTAT"\t"PAXCAL"\t"PAXDAY"\t"PAXN"\t"PAXHOUR"\t"PAXMINUT"\t"PAXINTEN"\t"PAXSTEP"'
echo "header: $header"
# Count number of files with this header:

# take the first line of the dataset, and search for the header, count the number of times
numFile=`ls ../../derived/accel | wc -l`
echo "Number of files: $numFile"

#echo "Number of files with correct header"
#head -n1 ../../derived/accel/accel*.txt | grep $header



## Remove any lines with 3 columns of NA values:
echo "Removing any lines with NA\tNA\tNA\n"

#sed -i '/NA\tNA\tNA/d' ../../derived/accel/accel*.txt

# check if all lines have 8 cols
echo "Checking for all 8 cols"
#awk -F'\t' '(NF!=8) {print $0}' ../../derived/accel/accel*.txt


# print the datasets which don't have 10081 records:
#wc -l accel-*.txt | grep -v 10082
