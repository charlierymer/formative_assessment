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
        "data/derived/body_measurements.csv"
        "data/derived/sample_IDs.csv"
        "logs/1.log"
        "logs/2.log"
        "logs/3.log"
        "logs/4.log"

rule check_BMX:
    input: 
        "data/original/BMX_D.csv"
    output:
        "logs/1.log"
    shell: """
    cd code
    bash BMX_processing.sh > logs/1.log
    """

rule check_accel:
    input:
        "logs/1.log"
    output:
        "logs/2.log"
    shell: """
    cd code
    bash code_processing.sh > logs/2.log     
    """



# sample_data: producing a sample indicator flag
rule sample_data:
    input:
        "logs/2.log"
    output:
        "data/derived/sample_IDs.csv"
    shell: """
    cd code
    Rscript sample_data.R > logs/3.log
    """


# week5_formative_script.R : export body_measurements.csv data
rule output_data:
    input:
        "data/original/BMX_D.csv"
        "data/original/DEMO_D.XPT"
        "data/derived/sample_IDs.csv"
    output:
        "data/derived/body_measurements.csv"
    shell: """
    cd code
    Rscript week5_formative_script.R > logs/4.log
    """

# make this rule remove any outputs:
# rule clean: 
