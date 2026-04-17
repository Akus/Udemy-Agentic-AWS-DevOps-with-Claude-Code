---
name: Project conventions and cost optimization decisions
description: Terraform layout conventions and cost choices made for the static portfolio site
type: project
---

CloudFront uses `PriceClass_100` (US/Canada/Europe only) — chosen over PriceClass_200 to reduce transfer costs for a portfolio site with a primarily Western audience.

**Why:** Cost optimization pass applied 2026-04-16.
**How to apply:** Default to PriceClass_100 for new CloudFront distributions in this project unless the user explicitly needs global edge coverage.

The project uses a custom `aws_cloudfront_cache_policy` resource (`aws_cloudfront_cache_policy.site_optimized`) instead of the AWS Managed CachingOptimized policy (`658327ea-f89d-4fab-a63d-7e88639e58f6`). TTLs: min=0, default=86400 (1 day), max=31536000 (1 year), with gzip+brotli encoding enabled and cookies/headers/query-strings excluded from the cache key.

**Why:** Custom policy gives explicit control over TTLs and avoids dependency on a hardcoded managed policy ID.
**How to apply:** Reference `aws_cloudfront_cache_policy.site_optimized.id` in `cache_policy_id` for the default cache behavior.

S3 bucket has a lifecycle configuration (`aws_s3_bucket_lifecycle_configuration.site`) with two rules: expire noncurrent versions after 30 days, abort incomplete multipart uploads after 7 days.

**Why:** Preventive cost control — noncurrent versions and stale multipart uploads accrue storage charges silently.
**How to apply:** Always add this lifecycle resource alongside new S3 buckets in this project.
