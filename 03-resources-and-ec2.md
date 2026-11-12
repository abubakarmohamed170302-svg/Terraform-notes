# Resources and an AWS EC2 Example

## Resource block

```hcl
resource "PROVIDER_TYPE" "LOCAL_NAME" {
  argument = value
}
```

Example:

```hcl
resource "aws_instance" "web" {
  ami           = var.ami_id
  instance_type = var.instance_type

  tags = {
    Name = "terraform-web"
  }
}
```

`aws_instance.web` is the resource address. The provider type is `aws_instance`; `web` is Terraform's local label, not the AWS instance name.

## Arguments, attributes and references

- **Arguments** configure a resource, such as `instance_type`.
- **Attributes** are values exposed after reading or creating it, such as `public_ip`.

```hcl
output "public_ip" {
  value = aws_instance.web.public_ip
}
```

References create implicit dependencies. Use `depends_on` only for a dependency Terraform cannot infer from expressions.

## Data sources

A data source reads information without creating it:

```hcl
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
```

AMI identifiers differ between regions. A carefully filtered data source is more portable than copying an ID from another region. Confirm the publisher owner ID and filters from trusted AWS/Ubuntu documentation before production use.

## EC2 deployment sequence

1. Configure AWS authentication without placing credentials in code.
2. Select the correct AWS region.
3. Define provider requirements.
4. Find a suitable AMI.
5. Define the EC2 resource.
6. Format, initialise and validate.
7. Review the plan.
8. Apply and verify the instance in AWS.
9. Run a second plan to check for unexpected drift.
10. Destroy lab resources when finished to avoid charges.

```bash
cd examples/ec2
cp terraform.tfvars.example terraform.tfvars
terraform fmt
terraform init
terraform validate
terraform plan
terraform apply
terraform destroy
```

## Security points

- Never open SSH to `0.0.0.0/0` unless the risk is understood and accepted.
- Prefer AWS Systems Manager Session Manager where possible.
- Use least-privilege IAM permissions.
- Protect private keys and never commit them.
- Tag resources for owner, environment, project and cost tracking.
- Destroy training resources after use.

