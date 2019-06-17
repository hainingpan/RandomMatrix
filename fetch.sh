#!/bin/bash
. ~/.profile
for i in  {1..5}
do
#	if [ ! -d "$i" ]; then
#		mkdir "M80/N4/Gn$i"
#	fi
	pcd /lustre/hnpan/RandomMatrix/M80/N4/Gn0.1/enmap0_rand_$i.mat ./M80/N4/Gn0.1
done

