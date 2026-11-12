# Terraform and Infrastructure as Code

## What is Infrastructure as Code?

Infrastructure as Code (IaC) is the practice of defining infrastructure in files rather than creating and changing it manually through a console.

With IaC, servers, networks, databases and cloud services can be:

- Version controlled
- Reviewed through pull requests
- Recreated consistently
- Tested before deployment
- Automated through CI/CD
- Audited through commit history

### Declarative and imperative approaches

- **Declarative:** describe the desired end state. Terraform calculates the required actions.
- **Imperative:** describe each command and the order in which it must run.

Terraform is mainly declarative.

## Why IaC matters in DevOps

Manual infrastructure is difficult to repeat and can produce configuration drift. IaC makes changes visible, reviewable and repeatable.

| Manual approach | IaC approach |
|---|---|
| Console clicks | Configuration files |
| Difficult to reproduce | Repeatable deployments |
| Limited audit trail | Git commit history |
| Inconsistent environments | Reusable modules and variables |
| Manual approval process | Pull requests and CI checks |

## IaC with version control

A safe team workflow is:

1. Create a feature branch.
2. Edit Terraform configuration.
3. Run `terraform fmt`, `validate` and `plan`.
4. Open a pull request.
5. Review both the code and execution plan.
6. Merge after approval.
7. Apply through a controlled pipeline.

Do commit `.tf` files and `.terraform.lock.hcl`. Do not commit state, secrets, `.terraform/` or saved plan files.

## Orchestration versus configuration management

| Infrastructure orchestration | Configuration management |
|---|---|
| Provisions infrastructure | Configures operating systems and software |
| Creates VPCs, instances and databases | Installs packages and changes services |
| Terraform, CloudFormation | Ansible, Puppet, Chef |
| Usually works through provider APIs | Often connects to existing hosts |

They can work together: Terraform creates an EC2 instance, while Ansible configures software inside it. Cloud-init or image building can also reduce post-provisioning configuration.

## What is Terraform?

Terraform is an IaC tool created by HashiCorp. It uses HashiCorp Configuration Language (HCL) to describe infrastructure and providers to communicate with platforms such as AWS, Azure, Google Cloud, GitHub and Kubernetes.

Terraform compares three things:

1. The desired configuration in `.tf` files
2. The recorded state
3. Real infrastructure returned by provider APIs

It then proposes actions to make the real infrastructure match the desired configuration.

## Idempotency

An idempotent operation can run repeatedly without creating unnecessary changes after the desired result has been reached. After a successful apply, a new plan should normally say that no changes are required.

## Key terms

- **Provider:** plugin that communicates with an API.
- **Resource:** infrastructure object Terraform manages.
- **Data source:** reads existing information without creating it.
- **State:** Terraform's record linking resource addresses to real objects.
- **Module:** reusable collection of Terraform configuration.
- **Backend:** determines where state is stored and how operations are performed.
- **Drift:** real infrastructure differs from the intended configuration.

