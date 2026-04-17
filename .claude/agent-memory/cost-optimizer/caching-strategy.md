---
name: CloudFront Cache Policy Tuning
description: AWS Managed CachingOptimized policy is conservative; static site can push TTLs higher
type: feedback
---

**Rule:** Cache TTL should be tuned to minimize origin requests (S3 GetObject calls), which are the highest-cost CloudFront operation.

**Current state:** main.tf line 89 uses AWS Managed `CachingOptimized` policy (ID: 658327ea-f89d-4fab-a63d-7e88639e58f6), which has default TTLs that are suitable for general-purpose static content but conservative for immutable assets (CSS, images with versioned names).

**Recommended:** Consider a custom cache policy with:
- Immutable assets (style.css, images with hash/version in name): 31536000 seconds (1 year)
- HTML files (index.html, privacy.html, terms.html): 3600 seconds (1 hour) or 86400 (1 day)
- Fallback default: 86400 seconds (1 day)

**Why:** Every CloudFront cache miss triggers an S3 GetObject API call ($0.0075 per 10k requests). Higher TTLs = fewer misses = lower costs. Static portfolios with infrequent updates and versioned assets can safely use long TTLs.

**How to apply:** If traffic analysis shows frequent cache misses on static assets, create a custom cache policy with longer TTLs for CSS/images and keep HTML short. Document asset naming strategy (e.g., style.css vs style.abc123.css) to decide TTL tier per file type.
