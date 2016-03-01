#!/bin/bash
# This script will create the User Environment to run ANSYS CFX under Slurm 
# Created by Jordi Blasco <jordi.blasco@nesi.org.nz>, Bart Verleye
CFX_HOSTLIST_TMP=`srun hostname -s | sort `
CFX_HOSTLIST_TMP=`echo $CFX_HOSTLIST_TMP | sed -e 's/ /,/g'`
export CFX_HOSTLIST=$CFX_HOSTLIST_TMP
