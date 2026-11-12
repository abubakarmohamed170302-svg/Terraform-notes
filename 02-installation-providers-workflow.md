# Installation, Providers and Core Workflow

## Installation

Always use the official HashiCorp installation instructions for the operating system.

### Windows

Common options include the official binary package or a supported package manager. After installation:

```powershell
terraform -version
```

If Terraform is not recognised, confirm that the directory containing `terraform.exe` is in the system `PATH`, then restart the terminal.

### macOS with Homebrew

```bash
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
terraform -version
```

### Linux

Use HashiCorp's signed package repository for the distribution, then verify:

```bash
terraform -version
```

## Useful VS Code setup

- Install the official HashiCorp Terraform extension.
- Enable format on save.
- Use `.tf` for configuration and `.tfvars` for variable values.
- Open the repository root as the VS Code workspace.

## Provider configuration

Providers translate Terraform operations into API calls.

```hcl
terraform {
  required_version = ">= 1.10.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "eu-west-2"
}
```

Pin a suitable version range so upgrades are intentional. `terraform init` creates or updates `.terraform.lock.hcl`; commit that lock file.

Do not hardcode AWS access keys. Prefer an AWS profile, environment variables, IAM roles or workload identity.

## Terraform Registry

The Terraform Registry contains providers and modules. Provider documentation explains:

- Supported resources and data sources
- Required and optional arguments
- Exported attributes
- Import identifiers
- Example configuration

Always check the documentation for the exact provider version being used.

## Core commands

### `terraform init`

Initialises the working directory, backend, providers and modules. Run it after cloning a project or changing provider, module or backend configuration.

```bash
terraform init
terraform init -upgrade
```

It is safe to run repeatedly. Do not commit the generated `.terraform/` directory.

### `terraform fmt`

```bash
terraform fmt -recursive
terraform fmt -check -recursive
```

The first command formats files; the second is useful in CI because it checks without rewriting.

### `terraform validate`

```bash
terraform validate
```

Checks syntax and internal consistency. It does not prove that provider credentials work or that a deployment will succeed.

### `terraform plan`

```bash
terraform plan
terraform plan -out=tfplan
terraform show tfplan
```

A plan refreshes state, compares configuration and state, and proposes actions. It does not change infrastructure.

Symbols commonly shown:

- `+` create
- `~` update in place
- `-` destroy
- `-/+` replace

Saved plans may contain sensitive values. Do not commit them.

### `terraform apply`

```bash
terraform apply
terraform apply tfplan
```

Review the plan carefully before approving. Applying a saved plan ensures the reviewed plan is the one executed.

### `terraform destroy`

```bash
terraform plan -destroy
terraform destroy
```

Destroy removes objects managed by the current configuration and state. Use it carefully, especially with databases, storage and production infrastructure.

## Recommended workflow

```bash
terraform fmt -recursive
terraform init
terraform validate
terraform plan -out=tfplan
terraform apply tfplan
```

After applying, run another plan. A stable configuration should normally report no changes.

