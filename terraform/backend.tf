# Remote state backend — S3 + DynamoDB locking
#
# HOW TO BOOTSTRAP:
#   1. First run `terraform init` and `terraform apply` WITHOUT this backend block
#      to create the S3 bucket and DynamoDB table (if you're managing them via Terraform).
#   2. Uncomment the block below, fill in your state bucket name and DynamoDB table name.
#   3. Run `terraform init -migrate-state` to move local state into S3.
#
# terraform {
#   backend "s3" {
#     bucket         = "akos-agentic-devops-website-tfstate"
#     key            = "akos-agentic-devops-website/production/terraform.tfstate"
#     region         = "eu-north-1"
#     dynamodb_table = "akos-agentic-devops-website-tfstate-lock"
#     encrypt        = true
#   }
# }
