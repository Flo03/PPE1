#!/usr/bin/env bash

#=======================================================================
# script pour tokeniser les dumps et les contextes du japonais
# doit être exécuté depuis la racine du projet
# cela lui permet de récupérer les fichiers dans les bons dossiers
#
# Se lancera donc comme ça : ./scripts/tokenisation-jp.sh <dossier>
#=======================================================================

if [[ $# -ne 1 ]]
then
	echo "Un argument attendu: <dossier_de_fichiers_a_tokeniser>"
	exit
fi

folder=$1 # dumps-text/jp/ OU contextes/jp/ 
path="$folder*"

for subpath in $path
do
	if [[ $subpath =~ .*tok.* ]]
	then
		rm $subpath
		continue
	fi
	python3 scripts/tokenize_japanese.py $subpath
done
