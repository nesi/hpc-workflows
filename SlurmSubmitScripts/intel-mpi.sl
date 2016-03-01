#!/bin/bash
#SBATCH -J MPI_JOB
#SBATCH -A uoa99999         # Project Account
#SBATCH --time=10:00:00     # Walltime
#SBATCH --ntasks=16         # number of tasks
#SBATCH --mem-per-cpu=1G  # memory/cpu 
module load intel/ics-2013
srun hostname
srun /share/training/slurm/bin/pi_mpi
