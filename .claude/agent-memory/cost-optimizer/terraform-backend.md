---
name: Terraform Backend DynamoDB Billing
description: Backend not yet active; plan for billing mode once bootstrap complete
type: project
---

**Rule:** When S3 backend with DynamoDB locking is enabled (currently commented in backend.tf), configure DynamoDB with `billing_mode = "PAY_PER_REQUEST"`.

**Current state:** backend.tf lines 10-17 show the S3 backend is commented out and awaiting bootstrap. The S3 bucket name is `akos-agentic-devops-website-tfstate`, DynamoDB table is `akos-agentic-devops-website-tfstate-lock`.

**Recommended:** When DynamoDB table is created (either manually or via separate Terraform):
- Use on-demand billing mode (`BillingMode = "PAY_PER_REQUEST"`)
- Reason: State lock table has infrequent, unpredictable access (only during terraform apply, typically <10/day). Provisioned capacity ($1.25/mo base) is wasteful; on-demand costs ~$0.01/mo for typical usage.

**Why:** Terraform state locking is not high-frequency. On-demand is cheaper than provisioned for state backend tables.

**How to apply:** Document as part of bootstrap checklist. When DynamoDB table is created for state backend, explicitly set `BillingMode = "PAY_PER_REQUEST"` to avoid over-provisioning.
