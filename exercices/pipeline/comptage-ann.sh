#! /usr/bin/bash
# traitement pour l'année 2016, on crée on écrase le fichier sortie.txt

echo "pour l'année 2016" > sortie.txt
echo -ne "nombre de d'annotation\t" >> sortie.txt
egrep ".?" ../rangement-fichiers/fichiers-tries/ann/2016/*/* | wc -l >> sortie.txt
echo -ne "nombre de d'annotation Location\t" >> sortie.txt
egrep "Location" ../rangement-fichiers/fichiers-tries/ann/2016/*/* | wc -l >> sortie.txt

echo "pour l'année 2017" >> sortie.txt
echo -ne "nombre de d'annotation\t" >> sortie.txt
egrep ".?" ../rangement-fichiers/fichiers-tries/ann/2017/*/* | wc -l >> sortie.txt
echo -ne "nombre de d'annotation Location\t" >> sortie.txt
egrep "Location" ../rangement-fichiers/fichiers-tries/ann/2017/*/* | wc -l >> sortie.txt

echo "pour l'année 2018" >> sortie.txt
echo -ne "nombre de d'annotation\t" >> sortie.txt
egrep ".?" ../rangement-fichiers/fichiers-tries/ann/2018/*/* | wc -l >> sortie.txt
echo -ne "nombre de d'annotation Location\t" >> sortie.txt
egrep "Location" ../rangement-fichiers/fichiers-tries/ann/2018/*/* | wc -l >> sortie.txt