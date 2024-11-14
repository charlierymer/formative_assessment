#!/bin/bash

# Jobscript to run pipeline on HPC by submitting a
# single job that runs all steps


#SBATCH --job-name=test_job
#SBATCH --partition=teach_cpu
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=0:10:00
#SBATCH --mem=100M
#SBATCH --account=SSCM033324
#SBATCH --output ./slurm_logs/%j.out


# cd "${SLURM_SUBMIT_DIR}"
# change to the root directory:
# cd ../


echo 'Setting up environment'

# initialise conda
source ~/initConda.sh

# use mambda to activate the correct environment
mamba activate formative_wk4


# run all the steps in the Snakefile
snakemake -n -c1 


# make required directories
#mkdir -p ./slurm_logs/
#mkdir -p ../../results
#mkdir -p ../../data/derived/intermediate

#cd ../

#Rscript 0_get_conditions.R
