#!/bin/bash
#SBATCH -J STRESS
#SBATCH -A nesi99999
#SBATCH --time=1:05:00
#SBATCH --mem-per-cpu=1G
##SBATCH --cpus-per-task=12
#srun stress --cpu 12 --vm-bytes 2GB --timeout 3600s
cd $SCRATCH_DIR
srun  stress -m 1 --vm-bytes 10G --vm-keep --timeout 3600s
