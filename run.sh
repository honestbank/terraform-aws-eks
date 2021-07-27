export AWS_ACCESS_KEY_ID="AKIARRPLFNP7IU6BFQ5U"
export AWS_SECRET_ACCESS_KEY="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"
export AWS_DEFAULT_REGION="ap-southeast-1"

export TF_VAR_name="test-vpc"

terraform plan -var-file=test.tfvars
pause
terraform apply -var-file=test.tfvars
pause
terraform destroy -var-file=test.tfvars
