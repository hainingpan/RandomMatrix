#!/bin/bash
. ~/.profile
for i in  `seq 0.1 0.1 1`
do
	if [ ! -d "$i" ]; then
		mkdir "M40/N4/Gn$i"
	fi
#	pcd /lustre/hnpan/RandomMatrix/M40/N4/Gn$i/probalpha.dat ./M40/Gn$i
done

