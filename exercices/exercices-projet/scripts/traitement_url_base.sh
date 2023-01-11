#!/usr/bin/env bash

#=======================================================================
#
#
#=======================================================================

fichier_urls=$1 # le fichier d'URL en entrée
fichier_tableau=$2 # le fichier HTML en sortie


if [[ $# -ne 2 ]]
then
	echo "Deux arguments attendus: <fichier_URL> <fichier_HTML>"
	exit
fi

# modifier la ligne suivante pour créer effectivement du HTML
echo "Je dois devenir du code HTML à partir de la question 3" > $fichier_tableau

lineno=1;

while read -r line;
do
	if [[ $line =~ http ]]
	then 
		echo "ligne $lineno: $line";
		lineno=$((lineno+1));
		#header=$(curl -sLI $line | egrep "HTTP/.* 200");
		header=$(curl -sLI $line);
		#verif_http=$(egrep "HTTP/.* 200" "$header");
		#header=$(head -n 1 $header);
		#echo "$header";
		#if [[ "$header" =~ 3..\ Moved\ Permanently ]]
		#if [[ "$header" =~ HTTP.*200 ]]
		#then
			#echo "hahahahah";
		#fi
		#encodage=$(egrep "charset=" $header)
	else
		continue
	fi
done < $fichier_urls
