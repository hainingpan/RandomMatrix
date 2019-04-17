#!/bin/bash
. ~/.profile
for i in  `seq 0.1 0.1 1`
do
#	if [ ! -d "$i" ]; then
#		mkdir $i
#	fi
	pcd /lustre/hnpan/RandomMatrix/M40/Gn$i/cond.dat ./M40/Gn$i
done

