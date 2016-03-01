#!/bin/bash
# ANSYS_FLUENT SubmitScript
# Optimized for run parallel job 
######################################################
#SBATCH -J ANSYS_FLUENT_TEST
#SBATCH -A nesi99999        # Project Account
#SBATCH --time=01:00:00     # Walltime
#SBATCH --cpus-per-task=16  # Number of threads
#SBATCH --mem-per-cpu=4GB   # memory per cpu
######################################################
###  Load the Environment
module load ANSYS/15.0
######################################################
### The input files will be transferred to temporary local FS
cp input/* $TMP_DIR
cd $TMP_DIR
######################################################
# Run the Parallel Program
# the following is a generic command. In order to get this command working
# please decide if you want to run the 2d or 2ddp OR 3d OR 3ddp solver and
# please use ONLY one of the options in the <> shown below
# fluent <2d|2ddp|3d|3ddp> -g -t2
fluent -v3ddp -g -t$SLURM_CPUS_PER_TASK -i fluent.in
######################################################
###  Transferring the results to the project directory
mkdir -p /projects/nesi99999/ANSYS/OUT
cp -pr $TMP_DIR /projects/nesi99999/ANSYS/OUT/
