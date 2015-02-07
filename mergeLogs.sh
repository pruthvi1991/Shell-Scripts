#!/bin/bash

#filenames=$(ls | grep 'forces')
#sed -i 's/[()]//g' forces*
filenames=$(ls | grep 'forces' | sed 's/[forces_]//g' | sort -n | sed 's/^/forces_/' | sed 's/forces_.dat/forces.dat/g')
cat $filenames >> merged.dat
