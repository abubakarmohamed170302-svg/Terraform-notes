# Importing Existing Infrastructure

Import associates an object that already exists with a Terraform resource address. It does not create the real object.

## Before importing

1. Identify the exact object and import ID.
2. Read that resource's provider documentation.
3. Back up state if the environment is important.
4. Define the destination resource address.
5. Ensure one real object will map to only one resource address.

## CLI import workflow

Create a resource block:

```hcl
resource "aws_instance" "imported" {
  ami           = "ami-REPLACE_ME"
  instance_type = "t3.micro"
}
```

Then initialise and import using the identifier format documented for that resource:

```bash
terraform init
terraform import aws_instance.imported i-0123456789abcdef0
terraform state show aws_instance.imported
terraform plan
```

The import updates state, but configuration must still describe the object accurately. Repeatedly adjust the code and review the plan until Terraform no longer proposes unintended changes or replacement.

## Import blocks

Modern Terraform also supports declarative import blocks:

```hcl
import {
  to = aws_instance.imported
  id = "i-0123456789abcdef0"
}
```

Then run:

```bash
terraform plan
terraform apply
```

Import blocks can be reviewed in version control and included in normal planning. They may be removed after a successful import or retained as a record, depending on team policy.

## Generating configuration

Terraform can help generate configuration for import targets during planning:

```bash
terraform plan -generate-config-out=generated.tf
```

Generated configuration is a starting point, not automatically production-quality. Review arguments, remove unnecessary values, introduce variables, apply naming standards and run another plan.

## Common problems

- Wrong import ID format
- Importing to the wrong resource or module address
- Provider configured for the wrong region or account
- Missing configuration after import
- A plan proposes replacement because an immutable argument differs
- The same object is already recorded elsewhere in state

Never force an import without understanding the provider documentation and the following plan.

