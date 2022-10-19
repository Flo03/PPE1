#!/usr/bin/bash

N=0
#for ELEMENT in $(ls)
#do
	#if [[ $ELEMENT =~ ^boucle ]]
	#then
		#N=$(expr $N + 1)
		#echo "le $N ieme élément est $ELEMENT"
	#fi
#done

# ou 

for ELEMENT in $(ls boucle*)
do
	N=$(expr $N + 1)
	echo "le $N ieme élément est $ELEMENT"
done
