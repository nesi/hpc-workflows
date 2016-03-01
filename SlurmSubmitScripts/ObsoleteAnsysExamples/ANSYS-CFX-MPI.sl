#!/bin/bash
# ANSYS_CFX SubmitScript
# Optimized for run parallel job 
######################################################
#SBATCH -J ANSYS_CFX_TEST
#SBATCH -A uoa99999         # Project Account
#SBATCH --time=01:00:00     # Walltime
#SBATCH --ntasks=32         # number of tasks
#SBATCH --mem-per-cpu=7G    # memory/cpu 
#SBATCH -p nonsusp          # Mandatory partition for distributed CFX analysis
#SBATCH -D /share/test/ansys/cfx/case4
######################################################
###  Load the Environment
module load ANSYS/15.0
######################################################
### The input files will be transferred to temporary ClusterFS
defname=TransPressureBC_VariableSurfTemp_IdealGases_Mask.def
cp input/$defname $SCRATCH_DIR
cd $SCRATCH_DIR
######################################################
###  Run the Parallel Program
source /share/SubmitScripts/slurm/slurm_setup_cfx-env2.sh
cfx5solve -batch -single -def $defname -par -par-dist $CFX_HOSTLIST
######################################################
###  Transferring the results to the project directory
mkdir -p /projects/nesi99999/ANSYS/OUT
cp -pr $SCRATCH_DIR /projects/nesi99999/ANSYS/OUT/
