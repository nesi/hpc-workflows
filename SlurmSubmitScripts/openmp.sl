#!/bin/bash
#SBATCH -J OpenMP_JOB
#SBATCH -A uoa99999         # Project Account
#SBATCH --time=01:00:00     # Walltime
#SBATCH --mem-per-cpu=1G    # memory/cpu 
#SBATCH --cpus-per-task=8   # 8 OpenMP Threads
srun openmp_binary
