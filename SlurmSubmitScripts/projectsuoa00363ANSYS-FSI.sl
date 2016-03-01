#!/bin/bash
# ANSYS Fluid- Structure Interaction (FSI) workflow
######################################################
#SBATCH -J ANSYS_FSI
#SBATCH -A nesi99999        # Project Account
#SBATCH --time=01:00:00     # Walltime
#SBATCH --ntasks=16         # number of tasks
#SBATCH --mem-per-cpu=4G    # memory/cpu 
#SBATCH -N 1
#SBATCH -D /project/nesi99999/ansys/fsi/case-001
######################################################
###  Load the Environment
module load ANSYS/15.0

### Input files
export coupling=System_coupling.sci
export fluent_journal=FluentInput.jou
export structural=structural.dat
export SERVERFILE=scServer.scs

### Output files
export structural_restart=ANSYSRestart1.out
export fluent_restart=FLUENTRestart1.out
export scrresult=scResult_01_000500.scr

### Start coupling program
CMD="$EBROOTANSYS/aisol/.workbench -cmd ansys.services.systemcoupling.exe -inputFile $coupling"
echo "Running command: $CMD"
($CMD) &

### Wait till $SERVERFILE is created
while true ; do
	if [ -f $SERVERFILE ]; then
		break
	fi
	sleep 5
done

### Parse the data in $SERVERFILE
### This assumes that the first system is Ansys and the Second System is Fluent
source /share/SubmitScripts/slurm/slurm_setup_fsi.sh

### Run Fluent
FLUENT_CMD="$FLUENT 3ddp -g -cnf=$FLUENT_HOSTFILE -t 8 -schost=$host -scport=$port -scname=$fluent_sol -mpi=pcmpi -pib -ssh -i $fluent_journal"
echo "Fluent command: (cd Fluent; $FLUENT_CMD )"
cd $DIR/Fluent 
$FLUENT_CMD > $fluent_restart &

### Run Ansys
ANSYS_CMD="$ANSYS -p AA_R -np 8 -b -usessh -schost=$host -scport=$port -scname=$ansys_sol -i $structural -o $structural_restart"
echo "Ansys command: (cd Ansys; $ANSYS_CMD )"
cd $DIR/Ansys
$ANSYS_CMD

