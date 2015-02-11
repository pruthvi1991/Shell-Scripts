#!/bin/bash

rm log.forces
rm -r postProcessing

endTime=$(grep -w 'endTime' ./system/controlDict | grep '[0-9]' | sed 's/;//g' | awk '{print$2}')	# Gets endTime value from controlDict
intendTime=$(grep -w 'endTime' ./system/controlDict | grep '[0-9]' | sed 's/;//g' | awk '{print$2*1000}')       # Multiplying by 1000 to convert to integer in case endTime is float
writeTime=$(grep -w 'writeInterval' ./system/controlDict | grep '[0-9]' | sed 's/;//g' | awk '{print$2}') # Gets writeInterval from controlDict
execFlowFunctionObjects >> log.forces &		# Executes the function execFlowFunctionObjects and writes output to log.forces

sleep 5

presentTime=$(tail -22 log.forces | grep Time | awk '{print$3}' | awk NR==1)	# Checks for many time steps the function ran and gets the last time value
intpresentTime=$(tail -22 log.forces | grep Time | awk '{print$3*1000}' | awk NR==1)	# Converting a possible float to integer

echo "endTime = $endTime, presentTime = $presentTime, Integer endTime = $intendTime, Integer presentTime = $intpresentTime, writeInterval = $writeTime"

echo "Entering Loop at $presentTime"

while [ $intpresentTime -lt $intendTime ];		# If the function failed to execute at some point this loop will make it start again
do
#	startTime=$(python -c print " $presentTime + $writeTime ")  # Finds time from which the function must start again
	startTime=$(echo "$presentTime+$writeTime" | bc)  # Finds time from which the function must start again
	echo "Crashed at $presentTime, re-starting from $startTime"
	execFlowFunctionObjects -time $startTime: >> log.forces &
	sleep 10	# Waits for 15 seconds before executing next command. This is necessary to ensure execFlowFunctionObjects is not re-run midway
	presentTime=$(tail -22 log.forces | grep Time | awk '{print$3}' | awk NR==1)
	intpresentTime=$(tail -22 log.forces | grep Time | awk '{print$3*1000}' | awk NR==1)
done
		
echo "Finally reached $presentTime"

