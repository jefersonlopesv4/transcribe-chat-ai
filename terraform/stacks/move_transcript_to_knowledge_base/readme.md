TF_VAR_ENVIRONMENT=development terraform init -backend-config=backend-development.hcl
TF_VAR_ENVIRONMENT=development terraform validate  
TF_VAR_ENVIRONMENT=development terraform fmt  
TF_VAR_ENVIRONMENT=development terraform plan
TF_VAR_ENVIRONMENT=development terraform apply -auto-approve