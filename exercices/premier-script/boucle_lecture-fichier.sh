#!/usr/bin/bash

FICHIER=$1
N=0
while read LINE
do
	N=$(expr $N + 1)
	echo "$N je lis: $LINE"
done < $FICHIER
echo "fin"
