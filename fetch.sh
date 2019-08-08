#!/bin/bash
. ~/.profile
for i in  0.01 0.05 0.1 0.2
do
#	if [ ! -d "$i" ]; then
#		mkdir "M80/N4/Gn$i"
#	fi
	pcd /lustre/hnpan/RandomMatrix/M80/N4/Gn$i/probalpha200_uncorr.dat ./M80/N4/Gn$i
done

