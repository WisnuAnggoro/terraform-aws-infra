# terraform-aws-infra
AWS Infrastructure with Terraform

This repository provisions a basic, production-grade AWS infrastructure using Terraform.  
It includes a VPC, subnet, and an EC2 instance — all built using clean, reusable modules and secure practices.

---

## Features

- VPC with public subnet
- EC2 instance with configurable type
- Modular and reusable Terraform code
- Remote state via S3 and DynamoDB (optional)
- Secure credential and profile management

---

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/downloads) (v1.0 or later)
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)
- An [AWS account](https://aws.amazon.com/)

---

## Getting Started

### 1. Install AWS CLI

Follow the official installation guide:  
👉 https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html

Or install via Homebrew (macOS):

```bash
brew install awscli
```

Verify installation:

```bash
aws --version
```

---

### 2. Configure AWS Credentials Securely

We use AWS CLI profiles to avoid storing keys in plain Terraform code.

#### a. Create an IAM user with programmatic access

Go to [IAM > Users](https://console.aws.amazon.com/iamv2/home#/users) in the AWS Console and:

- Create a new user
- Enable **programmatic access**
- Attach policy like `AdministratorAccess` (or use fine-grained permissions)

#### b. Configure the AWS CLI

```bash
aws configure --profile my-terraform-profile
```

It will prompt:

```bash
AWS Access Key ID [None]: <your-access-key>
AWS Secret Access Key [None]: <your-secret-key>
Default region name [None]: us-east-1
Default output format [None]: json
```

Now credentials are stored securely in:

```bash
~/.aws/credentials
```

---

### 3. Clone This Repo

```bash
git clone https://github.com/WisnuAnggoro/terraform-aws-infra.git
cd terraform-aws-infra/infra
```

---

### 4. Initialize Terraform

```bash
terraform init
```

This downloads the necessary providers and sets up the remote backend if configured.

---

### 5. Plan Infrastructure Changes

```bash
terraform plan -var="aws_profile=my-terraform-profile"
```

Preview all actions Terraform will perform.

---

### 6. Apply Infrastructure

```bash
terraform apply -var="aws_profile=my-terraform-profile"
```

Confirm with `yes` when prompted.

---

### 7. Output

After a successful apply, Terraform will output values like the public IP of your EC2 instance.

```bash
Outputs:
instance_public_ip = "34.xxx.xxx.xxx"
```

---

## Project Structure

```plaintext
.
├── backend.tf            # Remote state configuration (S3 + DynamoDB)
├── main.tf               # Main module declarations
├── variables.tf          # Input variables
├── outputs.tf            # Output values
├── terraform.tfvars      # Actual values for variables
├── provider.tf           # AWS provider with profile support
└── modules/              # Reusable infrastructure components
    ├── network/
    └── compute/
```

---

## Cleanup

To destroy all resources created:

```bash
terraform destroy -var="aws_profile=my-terraform-profile"
```



