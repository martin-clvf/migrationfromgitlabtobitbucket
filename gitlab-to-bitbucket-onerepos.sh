#!/bin/bash

# Renseigner les informations d'identification GitLab et Bitbucket
GITLAB_USERNAME="votre_nom_utilisateur_gitlab"
GITLAB_TOKEN="votre_token_gitlab"
BITBUCKET_USERNAME="votre_nom_utilisateur_bitbucket"
BITBUCKET_PASSWORD="votre_mot_de_passe_bitbucket"

# Renseigner le nom du dépôt GitLab à migrer
GITLAB_REPO="nom_du_depot_gitlab"

# Renseigner le nom du dépôt Bitbucket de destination
BITBUCKET_REPO="nom_du_depot_bitbucket"

# Cloner le dépôt GitLab en local
git clone "git@gitlab.com:${GITLAB_USERNAME}/${GITLAB_REPO}.git"
cd ${GITLAB_REPO}

# Récupérer tous les tags du dépôt GitLab
git fetch --tags

# Ajouter la clé SSH de Bitbucket aux known_hosts
ssh-keyscan -t rsa bitbucket.org >> ~/.ssh/known_hosts

# Créer le dépôt Bitbucket
curl -X POST -v -u ${BITBUCKET_USERNAME}:${BITBUCKET_PASSWORD} \
  -H "Content-Type: application/json" \
  "https://api.bitbucket.org/2.0/repositories/${BITBUCKET_USERNAME}/${BITBUCKET_REPO}" \
  -d '{"scm": "git", "is_private": "true"}'

# Ajouter le dépôt Bitbucket en tant que remote Git
git remote add bitbucket "git@bitbucket.org:${BITBUCKET_USERNAME}/${BITBUCKET_REPO}.git"

# Pusher tous les tags vers Bitbucket
git push bitbucket --tags

# Pusher toutes les branches vers Bitbucket
git push bitbucket --all
