#!/usr/bin/env bash
# This script will create the User Environment to run ANSYS Fluent under Slurm 
# Created by Jordi Blasco <jordi.blasco@nesi.org.nz>, Bart Verleye
export MPI_IC_ORDER="udapl:ibv:tcp"
export FS_IC_VARIANT="mellanox"
export FLUENT_HOSTSFILE=$PWD/.hostlist-job$SLURM_JOB_ID
if [ "$SLURM_PROCID" == "0" ]; then
   srun hostname -f > $FLUENT_HOSTSFILE
fi
