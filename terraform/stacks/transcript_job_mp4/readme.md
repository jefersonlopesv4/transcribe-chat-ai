TF_VAR_ENVIRONMENT=homolog terraform init -backend-config=backend-homolog.hcl
TF_VAR_ENVIRONMENT=homolog terraform validate  
TF_VAR_ENVIRONMENT=homolog terraform fmt  
TF_VAR_ENVIRONMENT=homolog terraform plan
TF_VAR_ENVIRONMENT=homolog terraform apply