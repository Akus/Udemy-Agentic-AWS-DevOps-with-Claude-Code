variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "eu-north-1"
}

variable "project_name" {
  description = "Project name used for resource naming and tagging"
  type        = string
  default     = "akos-agentic-devops-website"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "production"
}

variable "domain_name" {
  description = "Custom domain name for the CloudFront distribution (leave empty to use the default CloudFront domain)"
  type        = string
  default     = ""
}
