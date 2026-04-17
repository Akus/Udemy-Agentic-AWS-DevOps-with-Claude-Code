---
name: CloudFront Price Class Optimization
description: PriceClass_200 costs 3x more than PriceClass_100; static portfolio qualifies for cheaper tier
type: feedback
---

**Rule:** PriceClass_200 is overprovisioned for this static portfolio.

**Current state:** main.tf line 71 uses `price_class = "PriceClass_200"`, which includes edge locations in North America, Europe, Asia, Australia, Middle East, and Africa.

**Recommended:** Change to `PriceClass_100` (cheapest), which covers only US, Europe, and parts of Asia. For a portfolio website with no geographic targeting requirements, the coverage is excessive.

**Why:** PriceClass_200 is 3x the cost of PriceClass_100 at CDN egress. For a static portfolio with primarily developer/recruiter audience, concentrating on US/EU edges is sufficient. If user traffic eventually shows demand in other regions, can escalate later.

**How to apply:** When optimizing costs, downgrade CloudFront to PriceClass_100 unless traffic analysis shows need for broader geo coverage.
