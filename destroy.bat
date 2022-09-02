@echo off

:::: "DESTRUIR" AMBIENTE
cd terraform
echo.
echo ===========================================
echo DESTROYING GCP RESOURCES...
terraform destroy -auto-approve