#!/bin/bash
# Abaqus SubmitScript
# Optimized for run parallel job 
######################################################
#SBATCH -J Abaqus_SMP
#SBATCH -A nesi99999
#SBATCH --time=02:00:00   
#SBATCH --cpus-per-task=16
#SBATCH --mem-per-cpu=2G
#SBATCH -C sb
#SBATCH -D /share/test/Abaqus/case01
######################################################
###  Load the module
ml ABAQUS/6.13.2-linux-x86_64 
######################################################
### The input files will be transferred to local FS
cp input/BigCavity_FullDisk.inp $TMP_DIR
cd $TMP_DIR
######################################################
###  Run the Parallel Program
abaqus job=BigCavity_FullDisk input=BigCavity_FullDisk.inp cpus=$SLURM_CPUS_PER_TASK -verbose 1 standard_parallel=all mp_mode=threads interactive
######################################################
###  Transferring the results to the project directory
mkdir -p /projects/nesi99999/Abaqus/OUT
cp -pr $TMP_DIR /projects/nesi99999/Abaqus/OUT/
