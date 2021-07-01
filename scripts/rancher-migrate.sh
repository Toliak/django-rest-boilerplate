#! /bin/sh

# Made by Toliak Purple, 2021

# Variables
## RANCHER_URL -- url to rancher  (Example: 'https://rancher.domain.com')
## RANCHER_TOKEN -- rancher API token (Bearer token)
## RANCHER_DEPLOYMENT -- deployment name (optionally)
## DOCKER_IMAGE -- image with tag (Example: 'my-image:latest')
## REGISTRY_URL -- url to docker registry (Example: 'registry.domain.com')
## K8S_SECRETS -- secrets name in K8S (Example: 'my-project')
## K8S_SECRETS_REGISTRY -- registry secrets name in K8S (Example: 'registry-secrets')

DEPLOYMENT=$RANCHER_DEPLOYMENT
if test -z $DEPLOYMENT; then
  DEPLOYMENT=$CI_PROJECT_NAME
fi
DEPLOYMENT="${DEPLOYMENT}-migrate-$(date '+%Y-%m-%d-%H-%M-%S')"

# Login with cert skip
rancher login "$RANCHER_URL" --token "$RANCHER_TOKEN" <<EOF
yes
EOF

# Apply migrate job
cat <<EOF | rancher kubectl apply --insecure-skip-tls-verify -f -

apiVersion: batch/v1
kind: Job
metadata:
  name: $DEPLOYMENT
spec:
  ttlSecondsAfterFinished: 300
  activeDeadlineSeconds: 60
  backoffLimit: 6
  completions: 1
  parallelism: 1
  template:
    metadata:
      labels:
        job-name: $DEPLOYMENT
    spec:
      containers:
      - command:
        - ./scripts/run-prepare.sh
        envFrom:
        - secretRef:
            name: $K8S_SECRETS
            optional: false
        image: $REGISTRY_URL/$DOCKER_IMAGE
        imagePullPolicy: Always
        name: $DEPLOYMENT
      imagePullSecrets:
      - name: $K8S_SECRETS_REGISTRY
      restartPolicy: Never

EOF
