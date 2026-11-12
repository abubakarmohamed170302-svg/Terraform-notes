# Terraform Notes

Beginner-friendly Terraform revision notes and practical AWS examples completed during the CoderCo DevOps Academy.

## Contents

1. [Terraform and Infrastructure as Code](./01-terraform-and-iac.md)
2. [Installation, Providers and Core Workflow](./02-installation-providers-workflow.md)
3. [Resources and an AWS EC2 Example](./03-resources-and-ec2.md)
4. [Terraform State and Remote Backends](./04-state-and-backends.md)
5. [Importing Existing Infrastructure](./05-importing-infrastructure.md)
6. [Variables, Locals and Outputs](./06-variables-locals-outputs.md)
7. [Terraform Modules](./07-modules.md)
8. [Best Practices and Interview Questions](./08-best-practices-interview.md)

## Core workflow

```text
Write configuration -> terraform fmt -> terraform init -> terraform validate
        -> terraform plan -> review -> terraform apply -> verify
```

## Essential commands

| Command | Purpose |
|---|---|
| `terraform version` | Display the installed version |
| `terraform fmt -recursive` | Format Terraform files |
| `terraform init` | Initialise providers, modules and backend |
| `terraform validate` | Check syntax and internal consistency |
| `terraform plan` | Preview proposed changes |
| `terraform apply` | Create or update infrastructure |
| `terraform destroy` | Destroy resources managed by the configuration |
| `terraform output` | Display output values |
| `terraform state list` | List resources recorded in state |
| `terraform import` | Associate an existing object with a resource address |

## Practice project

The [`examples/ec2`](./examples/ec2) directory contains a reusable example that creates an AWS EC2 instance using input variables, locals, validation and outputs.

> Never commit AWS credentials, private keys, state files, plan files or sensitive variable values.

## Author

**Abubakar Mohamed** — Aspiring DevOps Engineer completing the CoderCo DevOps Academy.

[Connect with me on LinkedIn](https://www.linkedin.com/in/abubakar-mohamed-3047a5211/)

