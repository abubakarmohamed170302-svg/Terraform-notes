# Terraform Modules

A module is a collection of Terraform files managed as one unit. Every Terraform configuration has a root module. A module called by another configuration is a child module.

## Why use modules?

- Reuse proven infrastructure patterns
- Reduce duplication
- Apply consistent security and tagging
- Hide unnecessary implementation detail
- Make testing and maintenance easier

## Typical structure

```text
modules/ec2-instance/
├── main.tf
├── variables.tf
├── outputs.tf
└── README.md
```

File names are conventions; Terraform loads all `.tf` files in a directory as one module.

## Calling a local module

```hcl
module "web" {
  source = "../../modules/ec2-instance"

  ami_id        = var.ami_id
  instance_type = var.instance_type
  name          = "dev-web"
  tags          = local.common_tags
}

output "web_instance_id" {
  value = module.web.instance_id
}
```

Run `terraform init` after adding or changing module sources.

## What makes a good module?

A good module:

- Has one clear responsibility
- Uses typed, described and validated inputs
- Exposes only useful outputs
- Avoids embedding credentials or environment-specific secrets
- Provides secure defaults without preventing valid customisation
- Pins or constrains compatibility appropriately
- Includes examples and a README
- Uses consistent naming and tagging
- Does not create an oversized collection of unrelated resources
- Is tested before release

## Module sources and versions

Modules can come from local paths, the Terraform Registry, Git or other supported sources. For registry modules, pin a compatible version:

```hcl
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 6.0"
}
```

Do not use a third-party module blindly. Review its source, maintenance, inputs, outputs, security choices and proposed plan.

## Module design mistakes

- Too many unrelated responsibilities
- Hardcoded regions, account IDs or names
- Excessive variables that expose every internal detail
- No validation or documentation
- Outputs that expose secrets
- Using modules before understanding the resources they wrap
- Breaking changes without versioning

