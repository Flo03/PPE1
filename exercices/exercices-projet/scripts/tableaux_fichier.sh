#!/usr/bin/env bash

#=======================================================================
# script pour créer un tableau html
# prend 3 arguments :
#	1: le nom du fichier en entrée contenant les urls 
#	2: le nom du fichier html de tableau renvoyé en sortie  
#	3: le mot dans la langue considérée
# Pour lancer le script: 
# ./script/base_tableaux_fichier.sh <fichier_url> <fichier_html> <mot>
#=======================================================================

fichier_urls=$1 # le fichier d'URL en entrée
fichier_tableau=$2 # le fichier HTML en sortie
mot=$3 # le mot dans la langue cherchée

if [[ $# -ne 3 ]]
then
	echo "Trois arguments attendus: <fichier_URL> <fichier_HTML> <mot>"
	exit
fi


echo $fichier_urls;
basename=$(basename -s .txt $fichier_urls)

echo "<html><body>" > $fichier_tableau
echo "<h2>Tableau $basename :</h2>" >> $fichier_tableau
echo "<br/>" >> $fichier_tableau
echo "<table>" >> $fichier_tableau
echo "<tr><th>ligne</th><th>code</th><th>URL</th><th>encodage</th><th>aspiration</th><th>dump-text</th><th>occurrences</th></tr>" >> $fichier_tableau

lineno=1;
nbr_occu_tot=0;
while read -r URL; do
	echo -e "\tURL : $URL";
	# la façon attendue, sans l'option -w de cURL
	code=$(curl -ILs $URL | grep -e "^HTTP/" | grep -Eo "[0-9]{3}" | tail -n 1)
	charset=$(curl -ILs $URL | grep -Eo "charset=(\w|-)+" | tail -n 1 | cut -d= -f2)
	#contenu=$(curl $URL) 

	# autre façon, avec l'option -w de cURL
	# code=$(curl -Ls -o /dev/null -w "%{http_code}" $URL)
	# charset=$(curl -ILs -o /dev/null -w "%{content_type}" $URL | grep -Eo "charset=(\w|-)+" | cut -d= -f2)
	
	
	echo -e "\tcode : $code";

	if [[ ! $charset ]]
	then
		echo -e "\tencodage non détecté, on prendra UTF-8 par défaut.";
		charset="UTF-8";
	else
		echo -e "\tencodage : $charset";
	fi

	if [[ $code -eq 200 ]]
	then
		dump=$(lynx -dump -nolist -assume_charset=$charset -display_charset=$charset $URL)
	
		
		if [[ $charset -ne "UTF-8" && -n "$dump" ]]
		then
			dump=$(echo $dump | iconv -f $charset -t UTF-8//IGNORE)
	
		fi
		curl $URL > ./aspirations/$basename-$lineno.html
		echo "$dump" > ./dumps-text/$basename-$lineno.txt
		nb_occ=$(echo "$dump" | egrep -o "$mot" | wc -w)
		nbr_occu_tot=$(($nbr_occu_tot + $nb_occ))
	else
		echo -e "\tcode différent de 200 utilisation d'un dump vide"
		dump=""
		charset=""
	fi
	
	# Met l'encodage en majuscule
	charset=$(echo ${charset^^})
	# Remplit le tableau avec les informations récupérés pour l'URL en cours de lecture
	echo "<tr><td>$lineno</td><td>$code</td><td><a href=\"$URL\">$URL</a></td><td>$charset</td><td><a href=../aspirations/$basename-$lineno.html>aspiration</a></td><td><a href=../dumps-text/$basename-$lineno.txt>dump</a></td><td>$nb_occ</td></tr>" >> $fichier_tableau
	echo -e "\t--------------------------------"
	lineno=$((lineno+1));
done < $fichier_urls
echo "</table>" >> $fichier_tableau
echo "</body></html>" >> $fichier_tableau

# donne le nombre total d'occurrences
echo "$nbr_occu_tot"
