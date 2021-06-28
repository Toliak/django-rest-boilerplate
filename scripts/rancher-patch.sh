#! /bin/sh

# Made by Toliak Purple, 2021

# Variables
## RANCHER_URL -- url to rancher  (Example: 'https://rancher.int.toliak.ru')
## RANCHER_TOKEN -- rancher API token (Bearer token)
## RANCHER_DEPLOYMENT -- deployment name (optionally)
## DOCKER_IMAGE -- image with tag (Example: 'my-image:latest')
## REGISTRY_URL -- url to docker registry (Example: 'registry.toliak.ru')

set -e

DEPLOYMENT=$RANCHER_DEPLOYMENT
if test -z $DEPLOYMENT; then
  DEPLOYMENT=$CI_PROJECT_NAME
fi

# Login with cert skip
rancher login "$RANCHER_URL" --token "$RANCHER_TOKEN" <<EOF
yes
EOF

# Deployment update
rancher kubectl patch deployment "$DEPLOYMENT" \
  --patch "
spec:
  template:
    spec:
      containers:
      - name: $DEPLOYMENT
        image: $REGISTRY_URL/$DOCKER_IMAGE
  " \
  --insecure-skip-tls-verify
