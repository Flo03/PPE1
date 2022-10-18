#! /usr/bin/bash
# traitement pour l'année 2016, on crée on écrase le fichier sortie.txt

echo "pour l'année 2016" > ../pipeline/sortie.txt
echo -ne "nombre de d'annotation\t" >> ../pipeline/sortie.txt
egrep ".?" ../rangement-fichiers/fichiers-tries/ann/2016/*/* | wc -l >> ../pipeline/sortie.txt
echo -ne "nombre de d'annotation Location\t" >> ../pipeline/sortie.txt
egrep "Location" ../rangement-fichiers/fichiers-tries/ann/2016/*/* | wc -l >> ../pipeline/sortie.txt

echo "pour l'année 2017" >> ../pipeline/sortie.txt
echo -ne "nombre de d'annotation\t" >> ../pipeline/sortie.txt
egrep ".?" ../rangement-fichiers/fichiers-tries/ann/2017/*/* | wc -l >> ../pipeline/sortie.txt
echo -ne "nombre de d'annotation Location\t" >> ../pipeline/sortie.txt
egrep "Location" ../rangement-fichiers/fichiers-tries/ann/2017/*/* | wc -l >> ../pipeline/sortie.txt

echo "pour l'année 2018" >> ../pipeline/sortie.txt
echo -ne "nombre de d'annotation\t" >> ../pipeline/sortie.txt
egrep ".?" ../rangement-fichiers/fichiers-tries/ann/2018/*/* | wc -l >> ../pipeline/sortie.txt
echo -ne "nombre de d'annotation Location\t" >> ../pipeline/sortie.txt
egrep "Location" ../rangement-fichiers/fichiers-tries/ann/2018/*/* | wc -l >> ../pipeline/sortie.txt
