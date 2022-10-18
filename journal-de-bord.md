# Journal de bord du projet encadré
## 30/09/2022
**Git : mise en pratique** 
1. Création du répertoire PPE1 sur github ainsi que les fichier readme.md  
2. Récupération de ce répertoire sur ma machine personnelle via la commande `git clone <URL>`  
3. Création du journal de bord : journal-de-bord.md  
4. Vérification du retard de la version de ma machine par rapport à la version en ligne grâce aux commande `git fetch` pour mettre à jour les métadonnées et `git status` pour constater le retard  
5. Mise à jour de la version de ma machine avec la commande `git pull`
6. Entrée du journal de bord  
## 01/10/2022
**Exercice : création d'une arborescence pour le contenu du Fichier.zip**  
1. Création d'un dossier de travail intitulé exercice_tri-fichier dans lequel j'ai extrait le contenu du fichier avec la commande  `unzip Fichier.zip`  
2. Observation du contenu : des fichiers .ann .txt .jpg .bmp .wav  
3. Création de quatre dossiers avec la commande `mkdir <nom-dossier>` : ann/ audio/ img/ txt/  
4. Déplacement des fichiers .ann dans le dossier ann/  
5. Déplacement des fichiers .txt dans le dossier txt/  
6. Déplacement du fichiers .wav dans le dossier audio/  
7. Déplacement des fichiers .jpg et du fichier .bmp dans le dossier img/  
8. Création de dossiers année/ (ex : 2016/) dans les dossiers ann/ et txt/  
9. Création de dossiers mois/ (ex : 05/ ) dans les dossiers année/  
10. Déplacement des fichiers correspondants dans les dossiers années/mois/ avec une commande du type `mv 2016_05_* 2016/05/`  
11. Création des dossiers France/ et Japon/ dans le dossier img/  
12. Création des dossiers Paris/ et Kyoto/ dans les dossiers France/ et Japon/ respectivement  
13. Déplacement de tous les fichiers comportant la chaîne de caractère 'Paris' dans le dossier Paris/ avec une commande du type `mv *Paris* France/Paris/`  
14. Idem pour le dossier Kyoto/ mais avec la chaîne 'Kyoto'
15. Le reste des fichiers fut déplacé au cas par cas. Idéalement, il faudrait renommer tous les fichiers contenu dans le dossiers img pour les uniformiser  
16. Vérification de l'arborescence grâce à la commande `tree > exercice_tri-fichiers_arborescence.txt`  
## 02/10/2022  
1. Création d'un répertoire Exercices/Rangement-fichiers/ pour y mettre les résultats de l'exercice de rangement des fichiers contenus dans l'archive Fichiers.zip
## 18/10/2022  
1. Création de scripts pour faire l'exercice de scripts avec arguments sur les annotations en fonction de l'année.
2. Travail de prise en main de git avec les différentes commandes vues en cours
