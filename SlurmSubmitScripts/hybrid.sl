#!/bin/bash
#SBATCH -J Hybrid_JOB
#SBATCH -A uoa99999         # Project Account
#SBATCH --time=01:00:00     # Walltime
#SBATCH --ntasks=4          # number of tasks
#SBATCH --mem-per-cpu=4G  # memory/cpu 
#SBATCH --cpus-per-task=8   # 8 OpenMP Threads
source /etc/profile
module load intel/ics-2013
srun /share/training/slurm/bin/pi_hybrid
