## GCP CREDENTIALS (Service Account)
variable "gcp_credentials" {
    type        = string
    default     = "gcpkey.json"             ## file must be stored at "./terraform/"
    description = "GCP Credentials"
}


## GCP PROVIDER - 
variable "gcp_project_id" {
    type        = string
    description = "GCP Projetc ID reference"
}

variable "gcp_region" {
    type        = string
    default     = "us-west1"
    description = "GCP Default Region"
}

variable "gcp_zone" {
    type        = string
    default     = "us-west1-c"
    description = "GCP Default Zone"
}


## GCP GKE (Kubernetes Engine)
variable "gke_nodes" {
    type        = number
    default     = 2
    description = "GKE - Number of Worker Nodes"
}

variable "machine" {
    type        = string
    default     = "e2-small"
    description = "value"
}


## COMMON VARIABLES
variable "prefix" {
    type        = string
    default     = "as04-aula05"
    description = "Common Prefix to be used in Resource Names"
}

variable "tag_env" {
    type        = string
    default     = "classroom"
    description = "References Environment"
}

variable "tag_terraform" {
    type        = string
    default     = "terraform"
    description = "References Resources created by Terraform"
}