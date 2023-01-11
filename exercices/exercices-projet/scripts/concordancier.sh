#!/usr/bin/env bash

#=======================================================================
####### script pour créer un tableau html
# prend 3 arguments :
#	1: le nom du fichier en entrée contenant les urls 
#	2: le nom du fichier html de tableau renvoyé en sortie  
#	3: le mot dans la langue considérée
#
# Pour lancer le script en jp: 
# 
#./script/concordancier.sh /URLs/URL_jp.txt /tableaux/concordancier-jp.html フェミニズム
#
#=======================================================================

fichier_urls=$1 # le fichier d'URL en entrée
fichier_concordancier=$2 # le fichier HTML en sortie
mot=$3 # le mot dans la langue cherchée

if [[ $# -ne 3 ]]
then
	echo "Trois arguments attendus: <fichier_URL> <fichier_HTML> <mot>"
	exit
fi


echo $fichier_urls;
basename=$(basename -s .txt $fichier_urls)

echo "<html><body>" > $fichier_concordancier
echo "<h2>Tableau $basename :</h2>" >> $fichier_concordancier
echo "<br/>" >> $fichier_concordancier
echo "<table>" >> $fichier_concordancier
echo "<tr><th>Contexte gauche</th><th>$mot</th><th>Contexte droit</th></tr>" >> $fichier_concordancier

lineno=1;
compteur=0;
while read -r URL; do
	echo -e "\tURL : $URL";
	# la façon attendue, sans l'option -w de cURL
	code=$(curl -ILs $URL | grep -e "^HTTP/" | grep -Eo "[0-9]{3}" | tail -n 1) # le tail permet de récupérer la dernière ligne ici
	# grep -e == egrep
	charset=$(curl -ILs $URL | egrep -o "charset=(\w|-)+" | cut -d= -f2) # le cut coupe la ligne selon le caractère "=" et récupère le 2e élément 

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
		dump=$(lynx -dump -nolist -assume_charset=$charset -display_charset=$charset $URL) # récupère le texte privé de toutes les balises html
		if [[ $charset -ne "UTF-8" && -n "$dump" ]]
		then
			dump=$(echo $dump | iconv -f $charset -t UTF-8//IGNORE)
		fi
		
		curl $URL > aspirations/$basename-$lineno.html # récupération du code html de chaque url
		
		echo "$dump" > dumps-text/$basename-$lineno.txt # récupération du contenu textuel de chaque url
		
		# on peut aussi tokenizer les textes japonais en utilisant le script python donné par les profs sur le git
		nbr_occurrence=$(echo "$dump" | egrep -o "$mot" | wc -w)
		
		concordance=$(echo "$dump" | sed ':a;N;$!ba;s/\n//g' | egrep -o "[^。\.]*$mot[^。\.]*[。\.]" | sed -sE "s/([^。\.]*)$mot([^。\.]*[。\.])/ \1 | $mot | \2/g")
		
		contexte=$(echo "$dump" | sed ':a;N;$!ba;s/\n/./g' | egrep -o "[^。\.]*$mot[^。\.]*[。\.]")
		
		while read -r line
		do
			echo "$contexte"
			contexte_gauche=$(echo "$line" | sed -sE "s/([^。\.]*)$mot([^。\.]*[。\.])/\1/g")
			echo "$contexte_gauche"
			echo "$mot"
			contexte_droit=$(echo "$line" | sed -sE "s/([^。\.]*)$mot([^。\.]*[。\.])/\2/g")
			echo "$contexte_droit"
			echo "<tr><td>$contexte_gauche</td><td>$mot</td><td>$contexte_droit</td></tr>" >> $fichier_concordancier
			compteur=$(($compteur + 1))
		done <<< $contexte
		
	else
		echo -e "\tcode différent de 200 utilisation d'un dump vide"
		dump=""
		charset=""
	fi
	

	
	#contexte_gauche=$(echo "$contexte" | sed -s "s/[。.]\([^。.]*\)$mot\([^。.]*[。.]\)/\1/g")
	#contexte_droit=$(echo "$contexte" | sed -s "s/[。.]\([^。.]*\)$mot\([^。.]*[。.]\)/\2/g")
	
	# commande pour tester l'extraction de contexte
	#lynx -dump -nolist -assume_charset=$charset -display_charset=$charset https://globalnewsview.org/archives/17803 | egrep -o "(。|\.|\!|\?).*$mot.*(。|\.|\!|\?)" | sed -s 's/。\(.*\)$mot\(.*\)/ \1 | $mot | \2/g'
	
	#echo "<tr><td>$contexte_gauche</td><td>$mot</td><td>$contexte_droit</td></tr>" >> $fichier_concordancier
	#echo -e "\t--------------------------------"
	lineno=$((lineno+1));
done < $fichier_urls
echo "</table>" >> $fichier_concordancier
echo "</body></html>" >> $fichier_concordancier

# donne le nombre de concordance
echo "$compteur"
