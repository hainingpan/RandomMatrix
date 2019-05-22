#!/bin/bash
. ~/.profile
for i in  `seq 0.1 0.1 1`
do
#	if [ ! -d "$i" ]; then
#		mkdir "M80/N4/Gn$i"
#	fi
	pcd /lustre/hnpan/RandomMatrix/M80/N4/Gn$i/*.dat ./M80/N4/Gn$i
done

