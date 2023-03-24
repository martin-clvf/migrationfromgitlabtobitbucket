#!/bin/bash

# Récupérer le nom du dépôt GitLab à migrer
echo "Nom du dépôt GitLab à migrer :"
read gitlab_repo

# Récupérer l'URL du dépôt Bitbucket de destination
echo "URL du dépôt Bitbucket de destination :"
read bitbucket_url

# Cloner le dépôt GitLab localement
git clone --mirror git@gitlab.com:username/$gitlab_repo.git

# Se déplacer dans le dépôt cloné
cd $gitlab_repo.git

# Ajouter l'URL du dépôt Bitbucket de destination comme remote
git remote add bitbucket $bitbucket_url

# Pousser toutes les branches et les tags vers le dépôt Bitbucket
git push --mirror bitbucket

# Supprimer le répertoire cloné
cd ..
rm -rf $gitlab_repo.git

echo "Migration terminée !"
