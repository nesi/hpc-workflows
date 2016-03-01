#!/bin/bash
# STAR-CCM+ SubmitScript
# Optimized for run parallel job with Platform MPI 
######################################################
#SBATCH -J STAR-CCM+PMPI
#SBATCH -A uoa00240
#SBATCH -D /share/test/Star-CCM+/case06/input
#SBATCH --time=06:00:00 
#SBATCH --mem-per-cpu=2048
#SBATCH --nodes=10
#SBATCH -C sb
#SBATCH --ntasks=160
#SBATCH -p nonsusp
######################################################

export SIM_FILE=Test7.1-Fn-0.45-layers1.5-timestep15.sim
export BATCH_FILE=Run.java
export PATH=$PATH:/projects/uoa00240/STAR-CCM+9.04.009-R8/star/bin

cp -pr * $SCRATCH_DIR
cd $SCRATCH_DIR

echo "JOB_ID:" $SLURM_JOB_ID
echo '#!/bin/bash' >$(echo "star-connect-"$SLURM_JOB_ID)
echo "/projects/uoa00240/STAR-CCM+9.04.009-R8/star/bin/starccm+ -host" $SLURMD_NODENAME "-port 47827 &" >>$(echo "star-connect-"$SLURM_JOB_ID)
chmod +x $(echo "star-connect-"$SLURM_JOB_ID)

# Build node list
srun hostname -s | sort >slurm.hosts

# Start Star-CCM+ server in batch mode
echo "Starting Star-CCM+"
echo

starccm+ -power -collab -np $SLURM_NPROCS -licpath 1999@flex.cd-adapco.com -podkey $PODKEY -cpubind off -machinefile slurm.hosts -time -mppflags "-srun" -fabric UDAPL -batch $BATCH_FILE -rsh ssh $SIM_FILE

rm slurm.hosts
rm $(echo "star-connect-"$SLURM_JOB_ID)

mv Resistance_Data.csv $(echo $SIM_FILE".csv")

cp -pr $SCRATCH_DIR /share/test/Star-CCM+/case06/output/

