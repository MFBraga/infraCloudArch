# KUBERNETES - NGINX + MySQL + SVC LoadBalancer

```
- FACULDADE IMPACTA TECNOLOGIA - FIT
- Disciplina: Infrastructure and Cloud Architecture
- Professor:  João Victorino
- Turma:      Arquitetura de Soluções Digitais (AS_04 - 2022)
```

## ✔️ Resumo do Projeto
- Este projeto foi desenvolvido como cumprimento da entrega do Trabalho/Atividade "[Kubernetes](https://classroom.google.com/u/0/c/NDYwMDUzMjg3NDUx/a/NDg5MDQwNTE5MzE0)" (24/08/2022)
- Execução de `PODs NGINX`, com mapeamento da porta `HTTP (80-TCP)` para acesso externo, via `SVC-LoadBalancer`
- Execução de `POD MySQL`, com mapeamento da porta `3306-TCP` para acesso interno via `SVC-NodePort`


## 🔨 Funcionalidades do projeto
- Ambiente: `Google Cloud Plataform - GCP`
- Recursos: `Google Kubernetes Engine - GKE` e `Google Artifact Registry`
- Provisionamento: `Terraform`


## 📋 Requisitos
- Habilitar previamente `Kubernetes Engine API` e `Artifact Registry API` 
    ```
    gcloud services enable container.googleapis.com
    gcloud services enable artifactregistry.googleapis.com
    ```
- Criar o arquivo `terraform.tfvars` em `./terraform/`, com o seguinte conteúdo:
    ```
    gcp_project_id  = "<GCP Project ID>"
    gcp_region      = "us-west1"
    ```


## 📁 Files:

| Folder/File                   | Descrição                                     |
| :---------------------------- | :-------------------------------------------- |
| `docker/Dockerfile.mysql`     | Build de nova imagem MySQL                    |
| `docker/Dockerfile.nginx`     | Build de nova imagem NGINX/PHP                |
| `docker/index.html`           | HTML/PHP index page                           |
| `docker/schema.sql`           | Configuração inicial/testes do MySQL          |
|                               |                                               |
| `terraform/variables.tf`      | Declaração de variáveis                       |
| `terraform/providers.tf`      | Descrição do(s) Providers                     |
| `terraform/gke.tf`            | GKE - Google Kubernetes Engine Resources      |
| `terraform/arr.tf`            | ARR - Artifact Registry Repository Resources  |
| `terraform/outputs.tf`        | Saídas após a aplicar o Plano de Execução     |
|                               |                                               |
| `k8s/pod-nginx.yaml`          | Declaração do POD NGINX                       |
| `k8s/svc-nginx-lb.yaml`       | Declaração do NGINX SVC LoadBalancer          |
| `k8s/svc-nginx-nodeport.yaml` | Declaração do NGINX SVC Nodeport              |
| `k8s/pod-mysql.yaml`          | Declaração do POD MySQL                       |
| `k8s/svc-mysql-lb.yaml`       | Declaração do MySQL SVC LoadBalancer          |
| `k8s/svc-mysql-nodeport.yaml` | Declaração do MySQL SVC Nodeport              |
|                               |                                               |
| `deploy.sh`                   | Script LINUX para execução do Projeto         |
| `deploy.bat`                  | Script WINDOWS para execução do Projeto       |
| `destroy.sh`                  | Script LINUX para Limpeza do Ambiente         |
| `destroy.bat`                 | Script WINDOWS para Limpeza do Ambiente       |


## 🎮 Login na GCP, via `gcloud CLI`
```
gcloud init
gcloud auth application-default login
``` 


## 🎮 Execução do Projeto (Linux ou Windows)
```
./deploy.sh
```
```
./deploy.bat
```


## 💻 Outputs:
- Endereço IP (público) do NGINX SVC LoadBalancer

&nbsp;


## 💣 "Destruir" Ambiente (Linux ou Windows)
```
./destroy.sh
```
```
./destroy.bat
```