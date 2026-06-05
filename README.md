# AWS Bastion Host Terraform Automation

## Project Overview

This repository demonstrates a professional Terraform-based AWS infrastructure automation pipeline using modular architecture and GitHub Actions CI/CD. The current implementation deploys a bastion host and VPC networking resources in AWS while applying infrastructure-as-code best practices, security checks, and an approval workflow.

> The repo is designed to scale gradually: additional Terraform modules can be added over time, and the workflow will continue to execute the same security, plan, approval, and deployment stages.

## What This Project Does

- Builds AWS infrastructure using Terraform modules
- Separates the network and bastion host resources into reusable Terraform modules
- Automates infrastructure validation, scanning, planning, and deployment
- Supports workflow dispatch with parameterized deployments
- Enables optional static analysis and conditional destruction
- Uses a manual approval gate before deployment

## Architecture and Workflow

![Terraform automation diagram](https://raw.githubusercontent.com/santuCG/terraform-modules/main/docs/terraform-automation-diagram.svg)

The deployment workflow follows this flow:

1. **Checkov security scan**: first stage validates Terraform code for policy violations using Checkov
2. **Optional static analysis**: TFLint runs only when the workflow dispatch input `run_static_analysis` is set to `true`
3. **Terraform plan**: code formatting, init, validate, and plan are executed in a dedicated stage
4. **Manual approval gate**: a review step is enforced through a GitHub environment before deployment
5. **Deploy or destroy**: the final stage runs `terraform apply` or `terraform destroy` based on the `destroy` input

## Workflow Inputs

This repository uses GitHub Actions `workflow_dispatch` inputs to make deployments flexible:

- `run_static_analysis`: boolean flag to toggle optional static code analysis
- `destroy`: boolean flag to run Terraform destroy instead of apply

This pattern supports manual and parameter-based deployments without changing the workflow file for every execution.

## Repository Structure

- `main.tf` — root Terraform entry point for this project
- `variables.tf` — root-level variable definitions
- `infra/aws/terraform/modules/network` — reusable network Terraform module
- `infra/aws/terraform/resources/aws_vpc` — VPC resource definitions
- `infra/aws/terraform/resources/Bastion_Host` — Bastion Host resource definitions
- `.github/workflows/network.yml` — GitHub Actions CI/CD workflow

## Best Practices Implemented

This project follows Terraform and automation best practices, including:

- **Modular design**: resources are organized into reusable Terraform modules
- **Code formatting**: `terraform fmt -check` ensures consistent formatting
- **Validation**: `terraform validate` confirms syntax and configuration correctness
- **Security scanning**: Checkov scans Terraform code for common misconfigurations and policy issues
- **Optional static analysis**: TFLint can be enabled on demand for deeper linting
- **Manual approval gating**: a controlled deployment gate ensures human review before infrastructure changes
- **Input-driven deployment**: parameterized dispatch supports `apply` or `destroy` flows cleanly
- **Environment separation**: GitHub Actions job environments isolate deployment stages and approvals
- **Secret management**: AWS credentials are injected through GitHub Secrets rather than stored in code
- **Gradual extension**: module architecture allows adding more AWS services and infrastructure components over time

## How To Use

1. Configure AWS credentials in GitHub Secrets:
   - `AWS_ACCESS_KEY`
   - `AWS_SECRET_KEY`
2. Configure the GitHub environment `manual-approval` with a 15-minute wait timer to auto-continue if no review occurs.
3. Start the workflow manually from GitHub Actions using `workflow_dispatch`.
4. Choose whether to run optional static analysis and whether to perform destroy.

### Dispatch Options

- `run_static_analysis: true` — runs TFLint in addition to Checkov and Terraform plan
- `destroy: true` — runs `terraform destroy` in the final stage instead of `terraform apply`

## Why This Project Is Resume-Worthy

This project showcases:

- Infrastructure-as-code expertise with Terraform
- Secure AWS automation using modular Terraform design
- CI/CD pipeline orchestration with GitHub Actions
- Policy-based security scanning with Checkov
- Flexible workflow dispatch and conditional deployment logic
- A practical manual approval process for production-safe deployments
- A roadmap for extending the project with more modules and cloud services

## Future Extensions

This repo is intentionally built for growth. Future improvements can include:

- additional Terraform modules for compute, security, and logging
- remote state backend configuration for team collaboration
- environment-specific workspaces or state separation
- automated drift detection and policy enforcement
- multi-account AWS deployment patterns

---

For a polished resume entry, highlight this project as a real infrastructure automation pipeline that combines Terraform modularity, security scanning, and GitHub Actions deployment controls.
