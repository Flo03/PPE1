#!/usr/bin/bash

N=0
for ELEMENT in $(ls)
do
	N=$(expr $N + 1)
	echo "le $N ieme élément est $ELEMENT"
done