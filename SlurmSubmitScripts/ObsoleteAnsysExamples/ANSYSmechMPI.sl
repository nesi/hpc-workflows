#!/bin/bash
#### ANSYS Mechanical workflow SMP
########################################
#SBATCH -J ANSYS_MECH_TEST
#SBATCH -A uoa00363         # Project Account
#SBATCH --time=03:00:00     # Walltime
#SBATCH --ntasks=32         # number of tasks
#SBATCH --nodes=2           # number of nodes
#SBATCH --mem-per-cpu=8G    # memory/cpu
#SBATCH -D /projects/uoa00363 #try making the working directory my project folder
##############################################
###  Load the Environment
module load ANSYS/15.0
defname=typicalneotwo.dat
### The input files will be transferred to local FS
cp input/$defname $TMP_DIR
cd $TMP_DIR
###  Run the ANSYS program
source /share/SubmitScripts/slurm/slurm_setup_mech.sh
$ANSYS -p AA_R -np 32 -b -usessh -mpi pcmpi -i typicalneotwo.dat -o output.out
###  Transferring the results to the project directory
mkdir -p /projects/uoa00363/output_typicalneotwo
cp -pr $TMP_DIR /projects/uoa00363/output_typicalneotwo/
