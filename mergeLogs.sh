#!/bin/bash

#filenames=$(ls | grep 'forces')
#sed -i 's/[()]//g' forces*
mkdir bins
binNames=$(ls | grep bins)
mv $binNames bins/
filenames=$(ls | grep 'forces' | sed 's/[forces_]//g' | sort -n | sed 's/^/forces_/' | sed 's/forces_.dat/forces.dat/g')
cat $filenames >> merged.dat
