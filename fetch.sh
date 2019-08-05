#!/bin/bash
. ~/.profile
for i in  {1..1}
do
#	if [ ! -d "$i" ]; then
#		mkdir "M80/N4/Gn$i"
#	fi
	pcd /lustre/hnpan/RandomMatrix/M80/N4/Gn0.1/cond_ensemble.mat ./M80/N4/Gn0.1
done

