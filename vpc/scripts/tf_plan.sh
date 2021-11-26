cd ../
AWS_PROFILE=default \
terraform plan \
-input=false \
-var-file=./terraform.tfvars \
-out="jenkins.tfplan" 
