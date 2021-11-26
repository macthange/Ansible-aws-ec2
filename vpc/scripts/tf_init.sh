cd  ../
AWS_PROFILE=default \
 terraform init -reconfigure -upgrade \
-backend-config=./terraform.backendconfig