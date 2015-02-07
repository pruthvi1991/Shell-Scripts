#!/bin/bash

cat merged.dat | awk '{print$1,$2,$5}' | sed 's/(//g' >> Fx_gnu.dat
cat merged.dat | awk '{print$1,$3,$6}' | sed 's/(//g' >> Fy_gnu.dat
