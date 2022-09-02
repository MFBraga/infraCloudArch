## PROVIDER REQUIREMENTS - AZURE
terraform {
    required_providers {
        google = {
            source  = "hashicorp/google"
            version = "4.33.0"
        }
    }

    required_version = ">= 0.14"
}

## PROVIDER - LOCAL NAME
provider "google" {
    #credentials = file("${var.gcp_credentials}")    ## "gcpkey.json" must be stored at "./terraform/"
    
    project     = "${var.gcp_project_id}"           ## "Project ID" must be informed at "./terraform/variables.tf"
    region      = "${var.gcp_region}"
    zone        = "${var.gcp_zone}"
}