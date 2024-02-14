init:
	terraform init

plan:
	terraform plan -out=plan.out

apply:
	terraform apply -auto-approve plan.out

fmt:
	terraform fmt -recursive -diff
