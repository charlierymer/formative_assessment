#!/bin/bash 


############## Bash script to process the accel data ###########

# move to the accel directory containing each of the accel files
# cd /mnt/c/Users/charl/Dropbox/PC/Documents/"Bristol Uni"/AHDS/"Week 3"/formative_assessment/data/original/short_accel
cd ../data/original/accel


# print number of accel files 
numFiles=`ls | wc -l`
echo "Number of accel files: $numFiles"


# inspect an accel file
echo "Top 10 lines from example file:"
head accel-31128.txt


# list of some files included:
echo "Top 10 files in directory:"
ls | head


# check number of columns in top file:
# look at whole text file, search for any line NOT containing
# the character '<' (ie. the header) 
# then use awk with the field separator -F, with the delimeter tab '\t'
# then the option print NF prints the number of fields in the current record
echo "print number of columns in each line for 10 lines:"
cat accel-31128.txt | grep -v '<' | awk -F '\t' '{print NF}' | head

### Check all others have 8 fields ###
# look at each text file, filter out the top line, print the number of fields, IF the 
# number of fields is NOT EQUAL to 8
echo "print the number of columns if not 8:"
cat *.txt | grep -v '<' | awk -F'\t' '{print NF}' | grep -v 8 


### Print all files without 8 columns (apart from line 1)
# print each file, without the first line, where there isn't 9 columns, and print the line
echo "files without 8 columns:"
cat *.txt | grep -v '<' | awk -F'\t' '(NF!=8){print $0}' 

### see which files contain NA lines
# search each file for lines without the header, then search for lines with NA NA NA
echo "files containing NA lines:"
grep -vH '<' *.txt | grep "NA\tNA\tNA"










######## Fixing any syntax #####################

# current dir: formative_assessment/data/original/short_accel

## Removing the ID line, so that the first line is the header
# "PAXSTAT"	"PAXCAL"	"PAXDAY"	"PAXN"	"PAXHOUR"	"PAXMINUT"	"PAXINTEN"	"PAXSTEP"

echo "Removing the ID line, leaving the header as the first line"

# Make new directory with derived data
# mkdir ../../derived/accel

# copy the data into it
cp ./accel*.txt ../../derived/accel

# remove the first line ('1d' says delete line 1)
sed -i '1d' ../../derived/accel/accel*.txt














### see which files contain NA lines
# search each file for lines without the header, then search for lines with NA NA NA
#echo "files containing NA lines:"
#grep -vH '<' *.txt | grep "NA\tNA\tNA" 



# search for the header line in each accel file


# list of all accel files
# grep accel-*****.txt 

# find . -type f -name "*.txt"


# for loop to run through files
# print out the number of lines in each file:
#wc -l *.txt | head
