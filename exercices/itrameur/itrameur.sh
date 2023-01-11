#!/usr/bin/env bash

if [[ $# -ne 2 ]]
then
	echo "Deux arguments attendus: <dossier> <langue>"
	exit
fi

folder=$1 # dumps-text OU contextes
basename=$2 # fr, jp, kr

echo "<lang=\"$basename\">"

for filepath in $(ls $folder/$basename-*.txt)
do
	# filepath == dumps-texts/jp-1.txt
	# 	==> pagename = fr-1
	pagename=$(basename -s .txt $filepath)
	echo "<page=\"$pagename\">"
	echo "<text>"
	
	#on récupère les dumps/contextes
	#et on écrit à l'intérieur de la balise text
	content=$(cat $filepath)
	# ordre important : & en premier
	# sinon : < => &lt; => &amp;lt;
	content=$(echo "$content" | sed 's/&/&amp/g')
	content=$(echo "$content" | sed 's/</&lt/g')
	content=$(echo "$content" | sed 's/>/&gt/g')
	
	
	echo "</text>"
	echo "</page> §"
done
