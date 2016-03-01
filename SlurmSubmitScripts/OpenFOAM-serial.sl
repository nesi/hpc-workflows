#!/bin/bash
#SBATCH -J OpenFOAM
#SBATCH -A uoa00261		# Project account
#SBATCH -D /projects/uoa00261/planejet
#SBATCH --time=06:00:00 	# Walltime
#SBATCH --mem-per-cpu=4G	# memory/cpu 

module load OpenFOAM/2.3.1-intel-2015a
source $FOAM_BASH

srun blockMesh
srun simpleFoam

