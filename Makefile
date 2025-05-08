# Variables
TF_DIR ?= ./infra
TF_VARS_FILE ?= terraform.tfvars

# Terraform commands
init:
	terraform -chdir=$(TF_DIR) init

validate:
	terraform -chdir=$(TF_DIR) validate

fmt:
	terraform -chdir=$(TF_DIR) fmt -recursive

plan:
	terraform -chdir=$(TF_DIR) plan -var-file=$(TF_VARS_FILE) -out=tfplan

apply:
	terraform -chdir=$(TF_DIR) apply tfplan

destroy:
	terraform -chdir=$(TF_DIR) destroy -var-file=$(TF_VARS_FILE)

output:
	terraform -chdir=$(TF_DIR) output

state-list:
	terraform -chdir=$(TF_DIR) state list

state-show:
	@echo "Usage: make state-show RESOURCE=resource_name"
	terraform -chdir=$(TF_DIR) state show $(RESOURCE)

clean:
	rm -f tfplan

help:
	@echo "Available commands:"
	@echo "  make init         - Initialize the Terraform working directory"
	@echo "  make validate     - Validate Terraform configuration files"
	@echo "  make fmt          - Format Terraform code recursively"
	@echo "  make plan         - Generate and save an execution plan"
	@echo "  make apply        - Apply the saved execution plan"
	@echo "  make destroy      - Destroy all managed infrastructure"
	@echo "  make output       - Show output values"
	@echo "  make state-list   - List Terraform-managed resources"
	@echo "  make state-show   - Show details of a resource (RESOURCE=...)"
	@echo "  make clean        - Remove generated files"