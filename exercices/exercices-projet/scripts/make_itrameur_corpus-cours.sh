#!/usr/bin/env bash

#=======================================================================
# script pour créer le corpus itrameur
# doit être exécuté depuis la racine du projet
# cela lui permet de récupérer les fichiers dans les bons dossiers
#
# Se lancera donc comme ça : ./programmes/make_itrameur_corpus.sh
#=======================================================================

if [[ $# -ne 2 ]]
then
	echo "Deux arguments attendus: <dossier> <langue>"
	exit
fi

folder=$1 # dumps-text OU contextes ex: ./dumps-text
basename=$2 # fr, jp, kr

echo "<lang=\"$basename\">" > "itrameur/$folder-$basename.txt"

for filepath in $(ls $folder/URL_$basename-*.txt)
do
	# filepath == dumps-texts/jp-1.txt
	# 	==> pagename = fr-1
	pagename=$(basename -s .txt $filepath)
	echo "<page=\"$pagename\">" >> "itrameur/$folder-$basename.txt"
	echo "<text>" >> "itrameur/$folder-$basename.txt"
	
	#on récupère les dumps/contextes
	#et on écrit à l'intérieur de la balise text
	content=$(cat $filepath) 
	
	# ordre important : & en premier
	# sinon : < => &lt; => &amp;lt;
	content=$(echo "$content" | sed 's/&/&amp/g')
	content=$(echo "$content" | sed 's/</&lt/g')
	content=$(echo "$content" | sed 's/>/&gt/g')
	
	echo "$content" >> "itrameur/$folder-$basename.txt"
	
	echo "</text>" >> "itrameur/$folder-$basename.txt"
	echo "</page> §" >> "itrameur/$folder-$basename.txt"
done

echo "</lang>" >> "itrameur/$folder-$basename.txt"
