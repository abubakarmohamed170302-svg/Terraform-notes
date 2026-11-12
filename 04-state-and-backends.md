# Terraform State and Remote Backends

## What state does

Terraform state maps resource addresses in configuration to real infrastructure objects. It also stores metadata and dependency information used during planning and applying.

By default, local state is stored as `terraform.tfstate`.

Important rules:

- Do not manually edit the state JSON.
- Do not commit state to Git.
- Treat state as sensitive; it can contain secrets or private values.
- Back it up and restrict access.
- Use Terraform state commands when controlled state changes are necessary.

## Local state

Local state is simple for individual experiments but unsuitable for most teams because it is tied to one filesystem, is easier to lose and does not provide safe collaboration by itself.

Useful inspection commands:

```bash
terraform state list
terraform state show aws_instance.web
terraform show
```

## Remote state

A remote backend centralises state so approved users and CI/CD systems can use the same authoritative copy. Benefits include collaboration, access control, backup and state locking where supported.

## S3 backend

```hcl
terraform {
  backend "s3" {
    bucket       = "REPLACE-WITH-UNIQUE-STATE-BUCKET"
    key          = "terraform-notes/dev/terraform.tfstate"
    region       = "eu-west-2"
    encrypt      = true
    use_lockfile = true
  }
}
```

The bucket must exist before Terraform can initialise this backend. Enable S3 versioning and block public access. Apply least-privilege bucket permissions.

Modern Terraform supports native S3 locking with `use_lockfile = true`. DynamoDB-based locking is deprecated, so do not introduce it into a new configuration unless compatibility with an older setup requires it.

## Migrating state

After adding or changing backend configuration:

```bash
terraform init -migrate-state
```

Read the prompts carefully and back up important state first. `-reconfigure` accepts the new backend settings without attempting the same state migration behaviour, so understand which option the situation requires.

## State locking

Locking prevents two writers from changing the same state simultaneously. Do not disable locking casually. If a process fails and leaves a lock, investigate who owns it before considering `terraform force-unlock LOCK_ID`.

## Drift and refresh

Drift occurs when infrastructure is changed outside Terraform. Planning normally refreshes current object information and shows differences.

Possible responses:

- Change the real object back through Terraform.
- Update configuration so the manual change becomes intentional.
- Import an unmanaged object.
- Use a controlled state operation when the mapping itself is wrong.

Avoid routine console changes to Terraform-managed infrastructure.

