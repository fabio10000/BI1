# Marche à suivre
## Récupérer les raw data
Premièrement il faut récupérer aller a l'URL indiquée pour chaque fichier dans [data/raw/readme.md](../data/raw/readme.md).  
Une fois a l'URL indiquée il faut choisir les informations a exporter, selon le tableau ci-dessous.  
Ensuite il faut choisir `Fichier texte(séparateur: virgule) avec en-tête` et cliquer sur continuer.  Quand le fichier esst téléchargé il faut le renommer correctement et le placer dans le dossier [data/raw](../data/raw/)

| Fichier | Colonne | Données |  
| ------- | ------- | ------- |  
| salaire_mensuel_brut_selon_formation.csv | Année | 2010 |
| salaire_mensuel_brut_selon_formation.csv | Grande région  | Tout selectionner sauf `Suisse` |
| salaire_mensuel_brut_selon_formation.csv | Formation  | Tout selectionner sauf `Formation - Total` |
| salaire_mensuel_brut_selon_formation.csv | Sexe  | Homme, Femme |
| salaire_mensuel_brut_selon_formation.csv | Valeur centrale et intervalle interquartile  | Médiane |
| salaire_mensuel_brut_suisse.csv | Année | 2010 |
| salaire_mensuel_brut_suisse.csv | Grande région  | Tout selectionner sauf `Suisse` |
| salaire_mensuel_brut_suisse.csv | Sexe  | Homme, Femme |
| salaire_mensuel_brut_suisse.csv | Valeur centrale et intervalle interquartile  | Médiane |

## Traiter les données
1. Depuis un terminal se déplacer dans le répertoire [code/scripts](../code/scripts)
1. Lancer le script ruby qui correspond a chaque fichier dans raw data `ruby process_<nom_fichier_sans_extension>.rb`
1. un fichier appelé `processed_<nom_fichier>` est créé dans [data/processed](../data/processed)  
