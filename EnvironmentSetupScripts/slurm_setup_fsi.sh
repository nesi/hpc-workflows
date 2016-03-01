#!/usr/bin/env bash
# This script will create the User Environment to run ANSYS Fluid-Structure
# Interaction (FSI) workflow under Slurm 
# Created by Jordi Blasco <jordi.blasco@nesi.org.nz>

export MPI_IC_ORDER="udapl:ibv:tcp"
export FS_IC_VARIANT="mellanox"
export FLUENT_HOSTFILE=$PWD/fluent_hostfile.dat
if [ "$SLURM_PROCID" == "0" ]; then
   srun hostname -f > $FLUENT_HOSTFILE
fi

DIR=$PWD
export ANSYS_LOCK=OFF
# ANSYSv15 Workbench install folder
ANSYSDIR=$EBROOTANSYS
# Fluent Launcher Bin
FLUENT=$EBROOTANSYS/fluent/bin/fluent
# MAPDL Launcher Bin
ANSYS=$EBROOTANSYS/ansys/bin/ansys150 

cat $SERVERFILE
(

read hostport 
read count
read ansys_sol  # may have to reverse ansys_sol and fluent_sol depending on the order of the coupling
read tmp1
read fluent_sol # may have to reverse ansys_sol and fluent_sol depending on the order of the coupling
read tmp2

set `echo $hostport | sed 's/@/ /'`
echo $1 > out.port
echo $2 > out.host
echo $ansys_sol > out.ansys
echo $fluent_sol > out.fluent

) < $SERVERFILE

read host < out.host
read port < out.port
read ansys_sol < out.ansys
read fluent_sol < out.fluent
rm -f out.*

# Check if coupling running
lsof -i :${port}
