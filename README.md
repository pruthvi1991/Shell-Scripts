# Shell-Scripts
A repository for the shell scripts written for automation, parsing data and workarounds for pesty memory allocation bugs.

The ForcesGrabber.sh is a work around for the memory allocation error in the execFlowFunctionObjects. This bug has been resolved by commit 5179e8ea3bcb24cdb6ad0ac96764c0d562a55945. 

If you dont have the latest version of OpenFOAM you can use this script to extract your force data.

The merge log files is a simple script to concatenate all the force.dat files generated by ForcesGrabber.sh
