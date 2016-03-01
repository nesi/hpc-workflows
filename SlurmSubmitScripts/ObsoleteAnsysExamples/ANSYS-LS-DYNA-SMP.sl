#!/bin/bash
# ANSYS LS-DYNA SubmitScript
######################################################
#SBATCH -J ANSYS_LS-DYNA
#SBATCH -A nesi99999        # Project Account
#SBATCH --time=01:00:00     # Walltime
#SBATCH --cpus-per-task=16  # Number of threads
#SBATCH --mem-per-cpu=4GB   # memory per cpu
#SBATCH -D /share/test/lsdyna/3cars
######################################################
###  Load the Environment
ml ANSYS/15.0
### The input files will be transferred to temporary local FS
cp input/* $TMP_DIR
cd $TMP_DIR
######################################################
# explore the environment variables here:
# http://www.dynasupport.com/howtos/general/environment-variables
#export LSTC_MEMORY=AUTO
#########################################################
##  Run the Parallel Program
# Memory needs to be defined in Words
memory=$(($SLURM_MEM_PER_CPU/8)) 
srun lsdyna150 i="3cars_shell2_150ms.k" memory=${memory}M ncpu=$SLURM_CPUS_PER_TASK
######################################################
###  Transferring the results to the project directory
mkdir -p /projects/nesi99999/ANSYS/OUT
cp -pr $TMP_DIR /projects/nesi99999/ANSYS/OUT/
