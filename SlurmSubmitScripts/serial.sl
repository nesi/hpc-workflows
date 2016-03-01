#!/bin/bash
#SBATCH -J Serial_Job
#SBATCH -A uoa99999         # Project Account
#SBATCH --time=01:00:00     # Walltime
#SBATCH --mem-per-cpu=8G  # memory/cpu 
source /etc/profile
srun sleep 30
srun echo "My first serial Slurm job"
