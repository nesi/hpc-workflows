#!/bin/bash
#SBATCH -J JobArray
#SBATCH --time=01:00:00     # Walltime
#SBATCH -A nesi99999         # Project Account
#SBATCH --ntasks=2          # number of tasks
#SBATCH --mem-per-cpu=8G  # memory/cpu 
#SBATCH --cpus-per-task=2   # 4 OpenMP Threads
#SBATCH --array=20-180      # Array definition
srun sleep $SLURM_ARRAY_TASK_ID
srun echo running on $(hostname)
#srun stress --cpu 1 --vm-bytes 128M --timeout 10s
module load intel/ics-2013
srun /share/training/slurm/bin/pi_mpi
