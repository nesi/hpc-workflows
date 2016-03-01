#!/bin/bash
# ANSYS_FLUENT SubmitScript
# Optimized for run parallel job 
######################################################
#SBATCH -J CFX_CASE4
#SBATCH -A nesi99999        # Project Account
#SBATCH --time=01:00:00     # Walltime
#SBATCH --cpus-per-task=24  # Number of threads
#SBATCH --mem-per-cpu=4GB   # memory per cpu
#SBATCH -C ib               # Ivy Bridge architecture
#SBATCH -D /share/test/ansys/cfx/case5/input
######################################################
###  Load the Environment
module load ANSYS/15.0
# Transferring input data
cp * $TMP_DIR/
cd $TMP_DIR
# Executable and input file.
defname=25Aug_Al2O3_SS_h5e8_V200T700K_NoSlip_60.def
# Run the job
time cfx5solve -batch -single -def $defname -par -par-local -partition $SLURM_CPUS_PER_TASK
# Transferring results
cp -pr $TMP_DIR /share/test/ansys/cfx/case5/output/
