# Terraform Final Assignments

These projects demonstrate practical Infrastructure as Code on AWS.

## Assignments

### 1. WordPress on AWS

Deploys an Ubuntu EC2 instance with:

- Apache
- PHP and required extensions
- MariaDB
- WordPress
- An EC2 security group
- Automated user data
- Random database credentials
- A public WordPress endpoint

[View Assignment 1](./01-wordpress-aws/README.md)

### 2. EC2 with Cloud-Init

Deploys an Ubuntu EC2 instance configured automatically with:

- NGINX
- A custom webpage
- Cloud-init package installation
- Service enablement and startup
- A completion marker for troubleshooting
- A public HTTP endpoint

[View Assignment 2](./02-ec2-cloud-init/README.md)

## Safe deployment workflow

Run each assignment from its own directory:

```bash
cp terraform.tfvars.example terraform.tfvars
terraform fmt -recursive
terraform init
terraform validate
terraform plan -out=tfplan
terraform apply tfplan
```

After testing and taking screenshots:

```bash
terraform destroy
```

> These projects create chargeable AWS resources. Review the plan and destroy lab resources when finished.

## Evidence status

The code is complete and ready to deploy. Real deployment screenshots must be captured from the AWS account after a successful apply; sample or fabricated evidence is intentionally not included.

