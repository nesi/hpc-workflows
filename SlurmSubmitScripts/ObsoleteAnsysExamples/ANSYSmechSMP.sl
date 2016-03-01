#!/bin/bash
#### ANSYS Mechanical workflow MPI
########################################
#SBATCH -J ANSYS_MECH_TEST
#SBATCH -A uoa00363         # Project Account
#SBATCH --time=0:05:00     # Walltime
#SBATCH --ntasks=8         # number of tasks
#SBATCH --mem-per-cpu=7G    # memory/cpu
#SBATCH -N 1 ## added this to request one node
#SBATCH -D /projects/uoa00363 #try making the working directory my project folder
##############################################
###  Load the Environment
module load ANSYS/15.0
defname=cantilever.dat
### The input files will be transferred to local FS
cp input/$defname $TMP_DIR
cd $TMP_DIR

###  Run the ANSYS program
source /share/SubmitScripts/slurm/slurm_setup_mech.sh
$ANSYS -p AA_R -np 8 -b -usessh -i cantilever.dat -o output.out
###  Transferring the results to the project directory
mkdir -p /projects/uoa00363/output_cantilever
cp -pr $TMP_DIR /projects/uoa00363/output_cantilever/
### this is run version 5

