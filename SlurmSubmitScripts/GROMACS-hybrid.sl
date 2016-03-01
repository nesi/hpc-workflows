#!/bin/bash
# Gromacs MPI SubmitScript
##########################################################################
#SBATCH -J GROMACS_JOB
#SBATCH -A nesi99999
#SBATCH --time=00:10:00     # Walltime
#SBATCH --mem-per-cpu=4G  # memory/cpu 
##SBATCH --ntasks=4          # number of tasks
#SBATCH --ntasks-per-node=1 # number of tasks per node
##SBATCH --cpus-per-task=16   # 4 OpenMP Threads
##SBATCH -N 2
##########################################################################
###  Load the Enviroment Modules for Gromacs 4.5.4
ml GROMACS/4.6.5-intel-2015a-hybrid
##########################################################################
###  Transfering the data to the local disk  ($SCRATCH_DIR)
cd $SCRATCH_DIR
cp /share/test/GROMACS/NeSI.GROMACS_Davoud_Zare/input/* .
##########################################################################
###  Run the Parallel Program
srun grompp_mpi -f md_gpu.mdp -c BSAm_md1.gro -t BSAm_md1.cpt -p decane_3272.top -o BSAm_md2
export MKL_NUM_THREADS=$OMP_NUM_THREADS
export MALLOC_TRIM_THRESHOLD_=-1
export MALLOC_MMAP_MAX_=0
export KMP_AFFINITY=scatter,verbose
srun mdrun_mpi -ntomp $OMP_NUM_THREADS -nsteps 1000 -noconfout -deffnm BSAm_md2 &> mdrun-scatter1.out
srun mdrun_mpi -nsteps 1000 -noconfout -deffnm BSAm_md2 &> mdrun-scatter2.out
export KMP_AFFINITY=compact,verbose
srun mdrun_mpi -ntomp $OMP_NUM_THREADS -nsteps 1000 -noconfout -deffnm BSAm_md2 &> mdrun-compact1.out
srun mdrun_mpi -nsteps 1000 -noconfout -deffnm BSAm_md2 &> mdrun-compact2.out
##########################################################################
###  Transfering the results to the home directory ($HOME)
cp -pr $SCRATCH_DIR /share/test/GROMACS/NeSI.GROMACS_Davoud_Zare/results/
tail mdrun-*.out | grep Performance | gawk -v C=$SLURM_NTASKS '{print C"  "$2}' >> /share/test/GROMACS/NeSI.GROMACS_Davoud_Zare-4.6.5-intel-2015a-hybrid.dat 
