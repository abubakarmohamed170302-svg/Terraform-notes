# Assignment 2: EC2 Deployment with Cloud-Init

## Project objective

This project uses Terraform and a separate cloud-init YAML file to launch an Ubuntu EC2 instance that installs NGINX and publishes a custom webpage automatically. No manual server configuration is required.

## Architecture

```text
Terraform
   |-- creates security group
   |-- creates EC2 instance
   `-- passes cloud-init.yaml as user_data
                  |
                  v
          Ubuntu cloud-init
            |-- installs NGINX
            |-- writes webpage
            |-- enables service
            `-- starts NGINX
```

## Files

| File | Purpose |
|---|---|
| `versions.tf` | Terraform and AWS provider requirements |
| `providers.tf` | AWS provider and common tags |
| `main.tf` | AMI lookup, security group and EC2 instance |
| `variables.tf` | Typed and validated inputs |
| `outputs.tf` | Instance details and NGINX URL |
| `cloud-init.yaml` | Package and service configuration performed at boot |
| `terraform.tfvars.example` | Safe example input values |

## Deployment

```bash
cp terraform.tfvars.example terraform.tfvars
terraform fmt -recursive
terraform init
terraform validate
terraform plan -out=tfplan
terraform apply tfplan
```

Open the output URL:

```bash
terraform output nginx_url
```

## How `user_data` works

Terraform reads the YAML file and passes it to EC2:

```hcl
user_data = file("${path.module}/cloud-init.yaml")
```

On first boot, cloud-init reads the configuration, installs NGINX, writes the webpage and starts the service.

## Verification

The public URL should display the custom Terraform assignment page. If administration access was enabled, useful checks are:

```bash
sudo cloud-init status --wait
sudo systemctl status nginx
sudo tail -n 100 /var/log/cloud-init-output.log
cat /var/lib/cloud-init-nginx-complete
```

## Screenshots

After deployment, add real evidence to [`screenshots/`](./screenshots/):

- `nginx-site.png`
- `cloud-init-status.png`
- `terraform-apply.png`

## Troubleshooting

### NGINX page is unreachable

- Confirm the instance has a public IPv4 address.
- Confirm TCP port 80 is open in the security group.
- Wait for cloud-init to complete.
- Check the NGINX service and cloud-init output log.

### Cloud-init did not run again

Cloud-init normally runs during the instance's first boot. This configuration sets `user_data_replace_on_change = true`, so changing the cloud-init file replaces the training instance and applies the new bootstrap configuration cleanly.

## What I learnt

- How cloud-init automates operating-system configuration
- How Terraform passes a separate file as EC2 user data
- How to structure Terraform across provider, resource, variable and output files
- How security groups control public access
- How to use cloud-init logs and service status for troubleshooting
- Why repeatable configuration is more reliable than manual setup

## Cleanup

```bash
terraform destroy
```

