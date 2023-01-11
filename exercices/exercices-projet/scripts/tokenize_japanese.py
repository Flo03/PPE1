#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Script pour tokeniser un document japonais
#
A exécuter ainsi 
python3 ./scripts/tokenize_japanese.py <chemin du fichier à tokeniser>
"""

import spacy
import sys
import os

entree =  sys.argv[1]
coupe_path=entree.split('/')
coupe_ext=coupe_path[-1].split('.')
coupe_path=coupe_path[:len(coupe_path)-1]
path='/'.join(coupe_path)
coupe_path='/'.join(coupe_path[-1])
sortie=path+'/'+coupe_ext[0]+"-tok."+coupe_ext[1]

print(sortie)

nlp = spacy.load("ja_core_news_sm")
with open(entree, 'r') as rf:
	with open (sortie, 'w') as wt:
		for line in rf:
			doc=nlp(line)
			for token in doc:
				wt.write(token.text)
				wt.write(" ")


