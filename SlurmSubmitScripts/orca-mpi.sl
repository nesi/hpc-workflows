#!/bin/bash
#SBATCH -J ORCA
#SBATCH -A uoa99999
#SBATCH --time=00:3330:00       # Walltime
#SBATCH --mem-per-cpu=4G        # memory/cpu 
#SBATCH --nodes=4               # number of nodes
#SBATCH --ntasks-per-node=16    # number of processors per node
#SBATCH -p nonsusp              # Mandatory partition for ORCA
#SBATCH -C sb                   # CPU Architecture

# Load the user environment
ml ORCA/3_0_2-linux_x86-64
export P4_RSHCOMMAND=ssh
export OMP_NUM_THREADS=1
###  The files will be allocated in the shared FS
cd $SCRATCH_DIR
cp /share/test/Orca/NeSI_Muhammad_Hashmi/* .
# --------------> WARNING   <-------------------
# The number of CPUs needs to be specified in
# the input file : % pal nprocs $SLURM_NTASKS
mv XRQTC.Orca_localCCSD.inp XRQTC.Orca_localCCSD.inp.1
echo "% pal nprocs $SLURM_NTASKS
    end" > XRQTC.Orca_localCCSD.inp.0  
cat XRQTC.Orca_localCCSD.inp.0 XRQTC.Orca_localCCSD.inp.1 > XRQTC.Orca_localCCSD.inp
rm XRQTC.Orca_localCCSD.inp.*
########################################## 
# Run the job 
########################################## 
/share/easybuild/RHEL6.3/sandybridge/software/ORCA/3_0_2-linux_x86-64/orca c60-c180.inp > c60-c180.out
########################################## 
# Copy the results to our home directory
########################################## 
mkdir -p /share/test/Orca/NeSI_Muhammad_Hashmi/out
cp -r $SCRATCH_DIR /share/test/Orca/NeSI_Muhammad_Hashmi/out
##########################################
# Temps dels resultats              
##########################################
TEMPS=$(cat methane.out | grep "Time:" | awk '{print $3}')
echo "$SLURM_NTASKS   $TEMPS" >> /share/test/Orca/benchmark-NeSI_Muhammad_Hashmi.dat
