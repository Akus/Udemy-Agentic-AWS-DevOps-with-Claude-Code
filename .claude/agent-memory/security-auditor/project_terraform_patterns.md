---
name: Terraform Security Patterns — S3 + CloudFront Static Site
description: Recurring security findings and patterns observed in this project's Terraform files
type: project
---

Audits conducted 2026-04-16 and re-confirmed 2026-04-17. All findings from the first audit remain unremediated as of 2026-04-17.

Key findings for this project:

1. CloudFront viewer_certificate uses cloudfront_default_certificate=true — no minimum TLS version enforced (defaults to TLSv1). Should pin minimum_protocol_version = "TLSv1.2_2021".
2. No CloudFront response headers policy (security headers: CSP, X-Frame-Options, HSTS, etc.) attached to default_cache_behavior.
3. S3 bucket has no server-side encryption block (aws_s3_bucket_server_side_encryption_configuration). SSE-S3 is now on by default in AWS but not explicitly declared in IaC.
4. No CloudFront access logging configured on the distribution.
5. No S3 server access logging configured.
6. backend.tf remote state block is commented out — state is currently stored locally, not in the encrypted S3 backend.
7. No OIDC IAM role / GitHub Actions resources exist in the terraform/ directory — OIDC trust policy cannot be audited. CI/CD auth is undeclared in IaC.
8. 404 custom_error_response returns HTTP 200 — masks errors for monitoring/alerting tools.
9. S3 bucket missing versioning configuration (aws_s3_bucket_versioning) — noncurrent_version_expiration lifecycle rule exists but versioning itself is never explicitly enabled.

**Why:** Static public portfolio site — risk is lower than a data app, but missing TLS pinning and security headers are meaningful findings for any public CloudFront distribution.
**How to apply:** Re-raise these findings in future audits if not yet remediated. Check for aws_cloudfront_response_headers_policy resource as evidence of fix for item 2. Check for minimum_protocol_version in viewer_certificate block for item 1.
