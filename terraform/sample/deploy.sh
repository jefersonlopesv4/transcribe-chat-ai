cd ../stacks/transcript_job_mp4
TF_VAR_ENVIRONMENT=development terraform init -backend-config=backend-development.hcl
TF_VAR_ENVIRONMENT=development terraform validate
TF_VAR_ENVIRONMENT=development terraform apply -auto-approve
cd ..
cd move_transcript_to_knowledge_base
TF_VAR_ENVIRONMENT=development terraform init -backend-config=backend-development.hcl
TF_VAR_ENVIRONMENT=development terraform validate
TF_VAR_ENVIRONMENT=development terraform apply -auto-approve