# Variable definitions for Terraform configuration

variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "us-east-1"
  
  validation {
    condition = can(regex("^[a-z]{2}-[a-z]+-[0-9]$", var.aws_region))
    error_message = "AWS region must be in the format: us-east-1, eu-west-1, etc."
  }
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
  
  validation {
    condition = contains([
      "t3.micro", "t3.small", "t3.medium",
      "t2.micro", "t2.small", "t2.medium"
    ], var.instance_type)
    error_message = "Instance type must be a valid EC2 instance type (t3.micro, t3.small, etc.)."
  }
}

variable "key_pair_name" {
  description = "Name of the AWS key pair for SSH access (optional)"
  type        = string
  default     = null
  
  # Note: If you want SSH access, create a key pair in AWS Console first
  # and set this variable to the key pair name
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "learning"
  
  validation {
    condition = contains(["dev", "staging", "prod", "learning"], var.environment)
    error_message = "Environment must be one of: dev, staging, prod, learning."
  }
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "terraform-basics"
}

# Local values for computed configurations
locals {
  common_tags = {
    Environment = var.environment
    Project     = var.project_name
    CreatedBy   = "terraform"
    Owner       = "learning-session"
  }
}
