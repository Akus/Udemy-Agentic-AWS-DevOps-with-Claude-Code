---
name: S3 Lifecycle Policy Gap
description: No S3 lifecycle rules configured; missing cost optimization for old versions and deleted objects
type: feedback
---

**Rule:** S3 buckets with version history should have lifecycle rules to expire old versions and incomplete multipart uploads.

**Current state:** main.tf lines 5-21 define S3 bucket but have no versioning or lifecycle configuration. This is currently appropriate for a simple static site (versioning disabled = no version costs), but if versioning is ever enabled, costs will accumulate.

**Recommended:** If versioning is enabled in future:
1. Add S3 Bucket Versioning resource (optional, currently not configured)
2. Add S3 Lifecycle Policy to expire old versions after 30 days
3. Add rule to clean up incomplete multipart uploads after 7 days

**Why:** Versioning incurs storage costs for each prior version of every object. A default policy to expire old versions after 30 days prevents multi-year cost creep. Incomplete uploads (from failed deployments) are orphaned and billable.

**How to apply:** Document as a preventive measure. If versioning becomes part of the deployment strategy (e.g., for rollback), immediately add lifecycle rules to expire old versions and multipart uploads.
