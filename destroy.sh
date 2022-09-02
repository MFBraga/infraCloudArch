#!/bin/bash

## "DESTRUIR" AMBIENTE
cd terraform
echo "\n ===========================================\n \
DESTROYING GCP RESOURCES..."
terraform destroy -auto-approve