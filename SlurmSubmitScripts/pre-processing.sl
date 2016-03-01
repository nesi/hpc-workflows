#!/bin/bash
#SBATCH -J Pre-ProcessingJob
#SBATCH -A uoa99999         # Project Account
#SBATCH --time=01:00:00     # Walltime
#SBATCH --mem-per-cpu=8G  # memory/cpu 
source /etc/profile
srun echo "Pre-Processing done. Run the job dependencies"
