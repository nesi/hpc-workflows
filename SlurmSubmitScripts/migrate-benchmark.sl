#!/bin/bash
# MIGRATE Benchmark SubmitScript
# Optimized for run parallel job of Cores at NeSI 
# for j in {2..4} ; do sbatch --ntasks=$((16*$j)) --ntasks-per-node=16 --array=1-100 /share/SubmitScripts/slurm/migrate-benchmark.sl ; done
######################################################
#SBATCH -J MIGRATE_TEST
#SBATCH -A nesi99999
#SBATCH --time=08:00:00
##SBATCH --ntasks-per-node=24
#SBATCH --mem-per-cpu=2048
##SBATCH -C ib
#SBATCH -x compute-bigmem-[001,003-004],compute-chem-001
######################################################
######################################################
###  The files will be allocated in the shared FS 
cp -pr /share/test/migrate/parmfile* $SCRATCH_DIR/
cp -pr /share/test/migrate/infile $SCRATCH_DIR/
######################################################
###  Run the Parallel Program
for i in 3.4.4-ictce-5.4.0 3.6.6-ictce-5.4.0 3.4.4-goolf-1.4.10 3.6.6-goolf-1.4.10 3.4.4-goolf-1.5.14 3.6.6-goolf-1.5.14
#for i in 3.4.4-goolf-1.4.10 3.6.6-goolf-1.4.10
#for i in 3.4.4-goolf-1.5.14 3.6.6-goolf-1.5.14
#export I_MPI_FABRICS=shm:dapl
#export I_MPI_ADJUST_COLLECTIVES = bcast:0;reduce:2
#export I_MPI_DAPL_SCALABLE_PROGRESS=1
#export I_MPI_PIN_PROCESSOR_LIST='grain=cache2,shift=sock'
#for i in 3.4.4-ictce-5.4.0 
do
    echo "version $i"
    ml MIGRATE/$i
    cd $SCRATCH_DIR 
    mkdir $i
    cp parmfile* $i/
    cp infile $i/
    cd $i
    echo "version $i"
    /usr/bin/time -f "real %e" -a -o /home/jbla572/OUT/migrate/benchmark-10r-$LMOD_SYSTEM_NAME-$i-$SLURM_NTASKS.dat srun migrate-n-mpi parmfile.short -nomenu 
    ml purge
done
######################################################
###  Transferring the results to the home directory ($HOME)
#mkdir -p $HOME/OUT/migrate
#cp -pr $SCRATCH_DIR $HOME/OUT/migrate
