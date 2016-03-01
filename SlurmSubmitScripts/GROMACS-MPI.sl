#!/bin/bash
# Gromacs MPI SubmitScript
##########################################################################
#SBATCH -J GROMACS_JOB
#SBATCH --time=01:00:00     # Walltime
#SBATCH -A nesi99999        # Project Account
#SBATCH --mem-per-cpu=7G    # memory/cpu 
#SBATCH --ntasks=192        # number of tasks
##########################################################################
###  Load the Enviroment Modules for Gromacs 4.5.4
ml GROMACS/4.6.5-intel-2015a-hybrid
##########################################################################
###  Transfering the data to the local disk  ($SCRATCH_DIR)
cd $SCRATCH_DIR
cp /share/test/GROMACS/NeSI.GROMACS_Davoud_Zare/input/* .
##########################################################################
###  Run the Parallel Program
srun mdrun_mpi -nsteps 1000 -pin on -noconfout -deffnm BSAm_md1 
##########################################################################
###  Transfering the results to the home directory ($HOME)
cp -pr $SCRATCH_DIR /share/test/GROMACS/NeSI.GROMACS_Davoud_Zare/results/
PERF=$(tail mdrun.out | grep Performance | gawk '{print $2}')
echo "$SLURM_NTASKS $PERF" >> /share/test/GROMACS/NeSI.GROMACS_Davoud_Zare-4.6.5-intel-2015a-hybrid.dat 
