# Snakefile

# Formative assessment Snakefile 


# Code to get a list of all the accelerometer files:
import glob
import re

accel_files = glob.glob("data/original/accel/accel-*/txt")
ACC_PID = [int(re.search(r"accel-(\d+).txt", f).group(1)) for f in accel_files]


# Default rule to check if final result is present:
rule all:
    "The default rule"
    input:
        "logs/1.log"

rule check_BMX:
    input: 
        "data/original/BMX_D.csv"
    output:
        "logs/1.log"
    shell: """
    bash BMX_processing.sh > logs/1.log
    """

rule check_accel:
    input:
        "data/original/accel"
    output:
        "logs/2.log"
    shell: """
    bash accel_fix.sh > logs/2.log     
    """


# Data formatting rule:
#rule BMX_data:
#    input: 
#        "data/original/BMX_D.csv"
#    output:
#        "data/derived/BMX_D_log.csv"
#    shell: """
#    bash BMX_processing.sh > /data/derived/BMX_D_log.txt
#    """
