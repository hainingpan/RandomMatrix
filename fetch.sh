#!/bin/bash
. ~/.profile
for i in  `seq 0.3 0.1 1`
do
#	if [ ! -d "$i" ]; then
#		mkdir $i
#	fi
	pcd /lustre/hnpan/RandomMatrix/M40/Gn$i/probalpha.dat ./M40/Gn$i
done

