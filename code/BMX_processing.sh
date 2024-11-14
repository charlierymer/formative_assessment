
## Bash script to process the BMX data ###


# move to the directory containing BMX_D.csv:
# cd /mnt/c/Users/charl/Dropbox/PC/Documents/"Bristol Uni"/AHDS/"Week 3"/formative_assessment/data/original

# cd to data location:
cd ../data/original

# look at the first 10 rows
head BMX_D.csv

# check how many lines in dataset
wc -l BMX_D.csv

# check how many fields are in the first 10 lines
awk -F, '{print NF}' BMX_D.csv | head


# check the same number of lines all down the file (ie. print any that are not 28)
awk -F, '{print NF}' BMX_D.csv | grep -v 28

echo -e '/n/n'
