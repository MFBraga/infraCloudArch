#!/bin/bash

## BUILD LOCAL IMAGES (Docker)
cd docker
echo -e "\n===========================================\n \
BUILDING LOCAL IMAGES - WEB SERVER..."
docker build -f Dockerfile.nginx -t mbraga-nginx:aula05 .

echo -e "\n===========================================\n \
BUILDING LOCAL IMAGES - DATABASE..."
docker build -f Dockerfile.mysql -t mbraga-mysql:aula05 .


## TERRAFORM INITIALIZATION (providers and modules)
cd ../terraform
echo -e "\n===========================================\n \
TERRAFORM INITIALIZATION - GCP..."
terraform init -upgrade


## EXECUTE TERRAFORM PLANNING
echo -e "\n===========================================\n \
EXECUTE TERRAFORM PLANNING - GCP..."
terraform apply -auto-approve


## FETCH CREDENTIALS - Google Kubernetes Engine (clulster)
echo -e "\n===========================================\n \
FETCH CREDENTIALS - RUNNING GKE CLUSTER..."
gcloud container clusters get-credentials as04-aula05-gke-cluster --region us-west1


## DOCKER LOGIN - GCP ARTIFACTORY REGISTRY (Repository)
echo -e "\n===========================================\n \
GCP ARTIFACT REGISTRY LOGIN - DOCKER..."
gcloud auth print-access-token | docker login -u oauth2accesstoken --password-stdin https://us-west1-docker.pkg.dev


## CREATE REPOSITORY SECRET
echo -e "\n===========================================\n \
CREATING SECRET FOR REPOSITORY/IMAGE PULLs..."
kubectl create secret generic regcred --from-file=.dockerconfigjson="%homedrive%%homepath%/.docker/config.json" --type=kubernetes.io/dockerconfigjson


## TAG LOCAL IMAGES
echo -e "\n===========================================\n \
TAGGING LOCAL IMAGES..."
docker tag mbraga-nginx:aula05 us-west1-docker.pkg.dev/infra-cloud-architecture/as04-aula05/mbraga-nginx:aula05
docker tag mbraga-mysql:aula05 us-west1-docker.pkg.dev/infra-cloud-architecture/as04-aula05/mbraga-mysql:aula05


## PUSH LOCAL IMAGES TO GCP REPOSITORY
echo -e "\n===========================================\n \
PUSHING LOCAL IMAGES TO GCP REPOSITORY..."
docker push us-west1-docker.pkg.dev/infra-cloud-architecture/as04-aula05/mbraga-nginx:aula05
docker push us-west1-docker.pkg.dev/infra-cloud-architecture/as04-aula05/mbraga-mysql:aula05


## DEPLOY TO GKE (using kubeconfig credentials)
echo -e "\n===========================================\n \
DEPLOYMENT TO GKE..."
kubectl apply -f ../k8s
sleep 10


## PRINT SVC-LOADBALANCER EXTERNAL IP ADDRESS
echo -e "\n===========================================\n \
FETCHING SVC-LOADBALANCER EXTERNAL IP ADDRESS..."
kubectl get svc svc-nginx-loadbalancer -o jsonpath="{.status.loadBalancer.ingress[*].ip}"
