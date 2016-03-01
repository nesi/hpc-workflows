#!/bin/bash
# ANSYS_FLUENT SubmitScript
# Optimized for run parallel job 
######################################################
#SBATCH -J ANSYS_FLUENT_TEST
#SBATCH -A uoa99999         # Project Account
#SBATCH --time=01:03:00     # Walltime
#SBATCH --ntasks=24         # number of tasks
#SBATCH --mem-per-cpu=4G    # memory/cpu 
#SBATCH -p nonsusp          # Mandatory partition for distributed CFX analysis
#SBATCH -D /share/test/ansys/fluent/case1
######################################################
###  Load the Environment
module load ANSYS/15.0
######################################################
### The input files will be transferred to temporary ClusterFS
cp input/* $SCRATCH_DIR
cd $SCRATCH_DIR
######################################################
# Run the Parallel Program
# the following is a generic command. In order to get this command working
# please decide if you want to run the 2d or 2ddp OR 3d OR 3ddp solver and
# please use ONLY one of the options in the <> shown below
# fluent <2d|2ddp|3d|3ddp> -g -t2
source /share/SubmitScripts/slurm/slurm_setup_fluent.sh 
fluent -v3ddp -g -t$SLURM_NTASKS -mpi=pcmpi -cnf=$FLUENT_HOSTFILE -pib -ssh -i fluent.in
######################################################
###  Transferring the results to the project directory
mkdir -p /projects/nesi99999/ANSYS/OUT
cp -pr $SCRATCH_DIR /projects/nesi99999/ANSYS/OUT/
