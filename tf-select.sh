#!/bin/bash

set -e

# Move into the Terraform infra directory
cd ./infra || { echo "❌ Failed to access ./infra directory"; exit 1; }

# List of available modules
MODULES=(
  "vpc"
  "ec2_instance"
  "rds"
  "s3_bucket"
  "iam"
  "cloudwatch"
  "alb"
  "eks"
  "autoscaling"
  "security_group"
  "route53"
)

# Prompt user for Terraform command
echo "📦 Choose Terraform command:"
echo "  [1] plan"
echo "  [2] apply"
echo "  [3] destroy"
read -rp "Enter choice [1-3]: " CMD_CHOICE

case "$CMD_CHOICE" in
  1) TF_CMD="plan" ;;
  2) TF_CMD="apply" ;;
  3) TF_CMD="destroy" ;;
  *) echo "❌ Invalid command." && exit 1 ;;
esac

# Display list of modules
echo "📁 Available modules:"
for i in "${!MODULES[@]}"; do
  printf "  [%d] %s\n" "$((i+1))" "${MODULES[$i]}"
done

# Prompt for module selection
read -rp "Enter module numbers to $TF_CMD (space-separated): " -a SELECTED

# Validate and execute
for index in "${SELECTED[@]}"; do
  if ! [[ "$index" =~ ^[0-9]+$ ]] || (( index < 1 || index > ${#MODULES[@]} )); then
    echo "❌ Invalid module selection: $index"
    exit 1
  fi
done

# Initialize Terraform (only once)
terraform init

# Run Terraform for each selected module
for index in "${SELECTED[@]}"; do
  module="${MODULES[$((index-1))]}"
  echo "🚀 Running 'terraform $TF_CMD' for module: $module"
  if [[ "$TF_CMD" == "apply" || "$TF_CMD" == "destroy" ]]; then
    terraform "$TF_CMD" -target="module.$module" -auto-approve
  else
    terraform "$TF_CMD" -target="module.$module"
  fi
done
