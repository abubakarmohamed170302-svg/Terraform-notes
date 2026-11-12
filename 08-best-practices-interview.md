# Best Practices and Interview Questions

## Practical tips

1. Read the plan before every apply.
2. Run `fmt`, `validate` and security checks in CI.
3. Use remote state with locking for team environments.
4. Never commit credentials, state or saved plan files.
5. Commit `.terraform.lock.hcl`.
6. Pin provider and module versions appropriately.
7. Use variables, locals and modules to remove meaningful repetition.
8. Use provider documentation as the source of truth.
9. Prefer small, reviewable pull requests.
10. Avoid manual changes to Terraform-managed objects.
11. Back up and version remote state.
12. Use least-privilege cloud permissions.
13. Separate environments and their state.
14. Tag infrastructure for ownership and cost control.
15. Destroy training resources when finished.

## Common file layout

```text
terraform-project/
├── versions.tf
├── providers.tf
├── main.tf
├── variables.tf
├── outputs.tf
├── locals.tf
├── backend.tf
├── terraform.tfvars.example
├── .gitignore
└── README.md
```

## Interview questions and model answers

### 1. What is Terraform?

Terraform is a declarative Infrastructure as Code tool. It uses providers to manage infrastructure through APIs and state to map configuration addresses to real objects.

### 2. What is the difference between `plan` and `apply`?

`plan` previews proposed actions without changing infrastructure. `apply` executes an approved plan and updates state.

### 3. Why does Terraform need state?

State records the binding between resource addresses and real objects, along with metadata Terraform needs to calculate changes efficiently.

### 4. Why should state not be committed to Git?

It may contain sensitive data, creates collaboration conflicts and lacks safe locking. A secured remote backend is normally more appropriate.

### 5. What does `terraform init` do?

It initialises the working directory, installs providers and modules, and configures the backend.

### 6. What is a provider?

A provider is a plugin that translates Terraform resource operations into API calls for a platform or service.

### 7. What is a resource address?

It identifies an instance in Terraform configuration or state, for example `aws_instance.web` or `module.web.aws_instance.this`.

### 8. What is configuration drift?

Drift is a difference between the real infrastructure and the intended Terraform configuration/state, often caused by manual changes.

### 9. What is the difference between a variable and a local?

An input variable lets callers supply a value. A local names an expression calculated inside the module to reduce repetition.

### 10. What is an output?

An output exposes a value after evaluation, such as an instance ID, or passes information from a child module to its caller.

### 11. What is a module?

A module is a reusable collection of Terraform configuration with inputs and outputs. The current working directory is the root module.

### 12. How do you import existing infrastructure?

Define the destination resource, identify the correct provider import ID, use an import block or `terraform import`, inspect state and reconcile configuration until the plan is safe.

### 13. What is state locking?

State locking prevents concurrent writers from modifying the same state and reduces the risk of corruption or conflicting changes.

### 14. How do you manage secrets?

Use a dedicated secret manager, workload identity, environment injection or secured CI variables. Never hardcode or commit secrets, and remember that sensitive Terraform values can still be stored in state.

### 15. How would you make a Terraform change safely in a team?

Create a branch, make a focused change, format and validate it, run security checks and a plan, open a pull request, review the plan, merge after approval and apply through a controlled pipeline using remote locked state.

## Revision checks

- Can I explain configuration, state and real infrastructure?
- Can I read each action symbol in a plan?
- Can I explain why state is sensitive?
- Can I create and call a child module?
- Can I import an existing resource safely?
- Can I explain variable precedence and types?
- Can I describe a safe Git and CI/CD workflow?

