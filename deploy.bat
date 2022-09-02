@echo off

:::: BUILD LOCAL IMAGES (Docker)
cd docker
echo.
echo ===========================================
echo BUILDING LOCAL IMAGES - WEB SERVER...
docker build -f Dockerfile.nginx -t mbraga-nginx:aula05 .

echo.
echo ===========================================
echo BUILDING LOCAL IMAGES - DATABASE...
docker build -f Dockerfile.mysql -t mbraga-mysql:aula05 .

:::: TERRAFORM INITIALIZATION (providers and modules)
cd ../terraform
echo.
echo ===========================================
echo TERRAFORM INITIALIZATION - GCP...
terraform init -upgrade

:::: EXECUTE TERRAFORM PLANNING
echo.
echo ===========================================
echo EXECUTE TERRAFORM PLANNING - GCP...
terraform apply -auto-approve

:::: FETCH CREDENTIALS - Google Kubernetes Engine (clulster)
echo.
echo ===========================================
echo FETCH CREDENTIALS - RUNNING GKE CLUSTER...
gcloud container clusters get-credentials as04-aula05-gke-cluster --region us-west1 | echo

:::: DOCKER LOGIN - GCP ARTIFACTORY REGISTRY (Repository)
echo.
echo ===========================================
echo GCP ARTIFACT REGISTRY LOGIN - DOCKER...
gcloud auth print-access-token | docker login -u oauth2accesstoken --password-stdin https://us-west1-docker.pkg.dev

:::: CREATE REPOSITORY SECRET
echo.
echo ===========================================
echo CREATING SECRET FOR REPOSITORY/IMAGE PULLs...
kubectl create secret generic regcred --from-file=.dockerconfigjson="%homedrive%%homepath%/.docker/config.json" --type=kubernetes.io/dockerconfigjson

:::: TAG LOCAL IMAGES
echo.
echo ===========================================
echo TAGGING LOCAL IMAGES...
docker tag mbraga-nginx:aula05 us-west1-docker.pkg.dev/infra-cloud-architecture/as04-aula05/mbraga-nginx:aula05
docker tag mbraga-mysql:aula05 us-west1-docker.pkg.dev/infra-cloud-architecture/as04-aula05/mbraga-mysql:aula05

:::: PUSH LOCAL IMAGES TO GCP REPOSITORY
echo.
echo ===========================================
echo PUSHING LOCAL IMAGES TO GCP REPOSITORY...
docker push us-west1-docker.pkg.dev/infra-cloud-architecture/as04-aula05/mbraga-nginx:aula05
docker push us-west1-docker.pkg.dev/infra-cloud-architecture/as04-aula05/mbraga-mysql:aula05

:::: DEPLOY TO GKE (using kubeconfig credentials)
echo.
echo ===========================================
echo DEPLOYMENT TO GKE...
kubectl apply -f ../k8s
timeout /t 10 /nobreak

:::: PRINT SVC-LOADBALANCER EXTERNAL IP ADDRESS
echo.
echo ===========================================
echo FETCHING SVC-LOADBALANCER EXTERNAL IP ADDRESS...
kubectl get svc svc-nginx-loadbalancer -o jsonpath="{.status.loadBalancer.ingress[*].ip}"
