#!/usr/bin/env bash
# This script will create the User Environment to run ANSYS mehcanical
# Slurm 
# Created by Yi Chung based on Jordi Blasco <jordi.blasco@nesi.org.nz>
export MPI_IC_ORDER="udapl:ibv:tcp"
export FS_IC_VARIANT="mellanox"
DIR=$PWD
export ANSYS_LOCK=OFF
# ANSYSv15 Workbench install folder
ANSYSDIR=$EBROOTANSYS
# ANSYSv15 Workbench install folder
# MAPDL Launcher Bin
ANSYS=$EBROOTANSYS/ansys/bin/ansys150