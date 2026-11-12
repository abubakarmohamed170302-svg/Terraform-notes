# Variables, Locals and Outputs

## Input variables

Input variables make a module configurable.

```hcl
variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "test", "prod"], var.environment)
    error_message = "Environment must be dev, test or prod."
  }
}
```

Reference it with `var.environment`.

Good variables have a description, an appropriate type, a sensible default only when one exists, and validation where it prevents mistakes.

## Variable values

```hcl
# terraform.tfvars
environment   = "dev"
instance_type = "t3.micro"
```

Other methods include:

```bash
terraform plan -var="environment=test"
terraform plan -var-file="prod.tfvars"
export TF_VAR_environment="test"
```

Do not commit secret values. A `sensitive = true` variable hides values from normal CLI output but does not stop the value being stored in state.

## Simplified variable precedence

When the same variable is assigned more than once, later/higher-precedence sources win. Important sources include:

1. Defaults in the variable block
2. Environment variables using `TF_VAR_name`
3. `terraform.tfvars` and `terraform.tfvars.json`
4. Automatically loaded `*.auto.tfvars` files
5. `-var-file` and `-var` command-line options

If multiple files or command-line options are supplied, ordering also matters. Check the current HashiCorp documentation when exact precedence affects a deployment.

## Types

Primitive types:

```hcl
string
number
bool
```

Collection and structural types:

```hcl
list(string)
set(string)
map(string)
tuple([string, number])
object({
  name = string
  size = string
})
```

Prefer specific type constraints instead of `any` where possible.

## Local values

Locals give a name to reusable expressions inside a module:

```hcl
locals {
  name_prefix = "${var.project}-${var.environment}"
  common_tags = {
    Project     = var.project
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}
```

Reference them with `local.name_prefix`. Locals reduce repetition; they are not inputs supplied by users.

## Outputs

Outputs expose useful information:

```hcl
output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.web.id
}
```

```bash
terraform output
terraform output instance_id
terraform output -json
```

Outputs can also pass values from a child module to its caller. `sensitive = true` reduces accidental CLI display but the value may still exist in state.

