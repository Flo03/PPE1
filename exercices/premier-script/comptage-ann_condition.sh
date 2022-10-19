#! /usr/bin/bash
# traitement pour l'année 2016, on crée on écrase le fichier sortie.txt

ANNEE=$1
TYPE=$2

if [ -z $ANNEE -o -z $TYPE ]
then
	echo "Donner deux arguments ANNEE et TYPE"
	exit
fi

echo "pour l'année $ANNEE" > ../pipeline/sortie.txt
echo -ne "nombre de d'annotation\t" >> ../pipeline/sortie.txt
egrep ".?" ../rangement-fichiers/fichiers-tries/$TYPE/$ANNEE/*/* | wc -l >> ../pipeline/sortie.txt
echo -ne "nombre de d'annotation Location\t" >> ../pipeline/sortie.txt
egrep "Location" ../rangement-fichiers/fichiers-tries/$TYPE/$ANNEE/*/* | wc -l >> ../pipeline/sortie.txt