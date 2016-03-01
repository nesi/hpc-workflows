#!/bin/bash
#SBATCH -J MPITUNE
#SBATCH -A uoa99999         # Project Account
#SBATCH --time=1:00:00     # Walltime
##SBATCH --ntasks=48          # number of tasks
#SBATCH --mem-per-cpu=2048   # memory/cpu (in MB)
##SBATCH -C ib

ml VTune/2015_update2
ml supermagic/20130104-intel-2015a
ml itac/9.0.3.051
source itacvars.sh impi5
unset I_MPI_PMI_LIBRARY #required
export I_MPI_FABRICS=shm:dapl
#export LANG=C
#export LC_ALL=C
#export LC_CTYPE=C

mpitune -a \"mpiexec.hydra -n 16 supermagic -a -m 2M -w $SCRATCH_DIR/ -n 10 \" -of tune.conf
