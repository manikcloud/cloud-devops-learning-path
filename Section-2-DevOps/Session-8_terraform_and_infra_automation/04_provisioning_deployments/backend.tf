# Terraform Backend Configuration for Remote State
# Uncomment and configure this after creating the S3 bucket and DynamoDB table

# terraform {
#   backend "s3" {
#     bucket         = "terraform-state-bucket-unique-name"
#     key            = "terraform/infrastructure/state"
#     region         = "us-east-1"
#     encrypt        = true
#     dynamodb_table = "terraform-state-lock"
#   }
# }

# To set up remote state:
# 1. Create S3 bucket for state storage
# 2. Create DynamoDB table for state locking
# 3. Uncomment the backend configuration above
# 4. Run: terraform init -migrate-state
