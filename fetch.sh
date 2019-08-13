#!/bin/bash
. ~/.profile
for i in  0.2
do
#	if [ ! -d "$i" ]; then
#		mkdir "M80/N4/Gn$i"
#	fi
	pcd /lustre/hnpan/RandomMatrix/M80/N4/Gn$i/sweepalpha2000_uncorr.mat ./M80/N4/Gn$i
done

