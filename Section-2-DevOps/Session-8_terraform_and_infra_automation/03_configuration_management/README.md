# ⚙️ 03: Configuration Management & Orchestration

<div align="center">

![Configuration](https://img.shields.io/badge/Terraform-Configuration-623CE4?style=for-the-badge&logo=terraform&logoColor=white)
![HCL](https://img.shields.io/badge/HCL-Syntax-green?style=for-the-badge&logo=terraform&logoColor=white)

**🎯 Master HCL Syntax | 🚀 Variables & Modules | 📊 Advanced Configurations**

</div>

---

## 📋 **What You'll Learn**

- ✅ **Advanced HCL syntax** and best practices
- ✅ **Variables and outputs** for flexible configurations
- ✅ **Terraform modules** for reusable infrastructure
- ✅ **Data sources** and resource dependencies
- ✅ **Configuration organization** and structure

---

## 🚀 **Quick Start**

```bash
# 1. Navigate to this section
cd cloud-devops-learning-path/Section-2-DevOps/Session-8_terraform_and_infra_automation/03_configuration_management

# 2. Initialize Terraform
terraform init

# 3. Review the configuration
cat main.tf

# 4. Plan with custom variables
terraform plan -var="environment=dev" -var="instance_count=2"

# 5. Apply the configuration
terraform apply
```

---

## 📁 **Project Structure**

```
03_configuration_management/
├── README.md              # This guide
├── main.tf               # Main configuration with modules
├── variables.tf          # Variable definitions
├── outputs.tf           # Output definitions
├── terraform.tfvars     # Default variable values
├── dev.tfvars          # Development environment values
├── prod.tfvars         # Production environment values
└── modules/            # Reusable modules
    ├── vpc/           # VPC module
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    └── web-server/    # Web server module
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

---

## 🎯 **Advanced HCL Concepts**

### **1. Variables and Data Types**

#### **String Variables:**
```hcl
variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
  
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be dev, staging, or prod."
  }
}
```

#### **Number Variables:**
```hcl
variable "instance_count" {
  description = "Number of instances to create"
  type        = number
  default     = 1
  
  validation {
    condition     = var.instance_count >= 1 && var.instance_count <= 10
    error_message = "Instance count must be between 1 and 10."
  }
}
```

#### **List Variables:**
```hcl
variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}
```

#### **Map Variables:**
```hcl
variable "instance_types" {
  description = "Instance types by environment"
  type        = map(string)
  default = {
    dev     = "t3.micro"
    staging = "t3.small"
    prod    = "t3.medium"
  }
}
```

### **2. Local Values and Functions**

```hcl
locals {
  # Computed values
  common_tags = {
    Environment = var.environment
    Project     = "terraform-advanced"
    CreatedBy   = "terraform"
    Timestamp   = timestamp()
  }
  
  # Conditional logic
  instance_type = var.environment == "prod" ? "t3.medium" : "t3.micro"
  
  # String manipulation
  resource_prefix = "${var.environment}-${var.project_name}"
  
  # List operations
  public_subnets = [for i, az in var.availability_zones : "10.0.${i + 1}.0/24"]
}
```

### **3. Data Sources**

```hcl
# Get latest Amazon Linux AMI
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# Get current AWS region
data "aws_region" "current" {}

# Get current AWS caller identity
data "aws_caller_identity" "current" {}
```

---

## 🏗️ **Module Development**

### **Creating Reusable Modules**

#### **VPC Module Structure:**
```
modules/vpc/
├── main.tf       # VPC, subnets, gateways
├── variables.tf  # Input variables
└── outputs.tf    # Output values
```

#### **Web Server Module Structure:**
```
modules/web-server/
├── main.tf       # EC2, security groups
├── variables.tf  # Input variables
└── outputs.tf    # Output values
```

### **Using Modules:**

```hcl
# Use VPC module
module "vpc" {
  source = "./modules/vpc"
  
  environment         = var.environment
  vpc_cidr           = "10.0.0.0/16"
  availability_zones = var.availability_zones
  
  tags = local.common_tags
}

# Use web server module
module "web_servers" {
  source = "./modules/web-server"
  
  count = var.instance_count
  
  environment       = var.environment
  vpc_id           = module.vpc.vpc_id
  subnet_ids       = module.vpc.public_subnet_ids
  instance_type    = local.instance_type
  
  tags = local.common_tags
}
```

---

## 🔄 **Resource Dependencies**

### **Implicit Dependencies:**
```hcl
# Terraform automatically detects dependencies
resource "aws_security_group" "web" {
  vpc_id = aws_vpc.main.id  # Implicit dependency on VPC
}

resource "aws_instance" "web" {
  security_groups = [aws_security_group.web.id]  # Implicit dependency on SG
}
```

### **Explicit Dependencies:**
```hcl
resource "aws_instance" "web" {
  # ... other configuration
  
  depends_on = [
    aws_security_group.web,
    aws_subnet.public
  ]
}
```

---

## 🎛️ **Environment Management**

### **Using Different Variable Files:**

#### **Development Environment:**
```bash
# Apply with dev variables
terraform apply -var-file="dev.tfvars"
```

#### **Production Environment:**
```bash
# Apply with prod variables
terraform apply -var-file="prod.tfvars"
```

### **Workspace Management:**
```bash
# Create workspaces for different environments
terraform workspace new dev
terraform workspace new staging
terraform workspace new prod

# Switch between workspaces
terraform workspace select dev
terraform apply

terraform workspace select prod
terraform apply
```

---

## 🔍 **Advanced Configuration Patterns**

### **1. Conditional Resources:**
```hcl
# Create load balancer only in production
resource "aws_lb" "main" {
  count = var.environment == "prod" ? 1 : 0
  
  name               = "${var.environment}-lb"
  load_balancer_type = "application"
  subnets           = var.subnet_ids
}
```

### **2. Dynamic Blocks:**
```hcl
resource "aws_security_group" "web" {
  name_prefix = "${var.environment}-web-sg"
  
  # Dynamic ingress rules
  dynamic "ingress" {
    for_each = var.allowed_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
```

### **3. For Expressions:**
```hcl
# Create multiple subnets
resource "aws_subnet" "public" {
  for_each = toset(var.availability_zones)
  
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.${index(var.availability_zones, each.value) + 1}.0/24"
  availability_zone = each.value
  
  tags = {
    Name = "${var.environment}-public-${each.value}"
  }
}
```

---

## 🧪 **Hands-On Exercises**

### **Exercise 1: Multi-Environment Setup**
```bash
# 1. Deploy development environment
terraform workspace new dev
terraform apply -var-file="dev.tfvars"

# 2. Deploy production environment
terraform workspace new prod
terraform apply -var-file="prod.tfvars"

# 3. Compare the environments
terraform workspace select dev
terraform show

terraform workspace select prod
terraform show
```

### **Exercise 2: Module Customization**
```bash
# 1. Modify the web-server module to add monitoring
# 2. Update the module call with new parameters
# 3. Apply changes and verify
terraform plan
terraform apply
```

### **Exercise 3: Dynamic Configuration**
```bash
# 1. Add new ports to allowed_ports variable
# 2. Apply changes to see dynamic security group rules
# 3. Test the new configuration
terraform apply -var='allowed_ports=["80","443","8080"]'
```

---

## 📊 **Best Practices**

### **1. Code Organization:**
- Use modules for reusable components
- Separate environments with workspaces or directories
- Keep variable definitions in separate files
- Use meaningful resource names and tags

### **2. Variable Management:**
- Always provide descriptions for variables
- Use validation rules where appropriate
- Set sensible defaults
- Use locals for computed values

### **3. State Management:**
- Use remote state for team collaboration
- Enable state locking
- Regular state backups
- Never edit state files manually

### **4. Security:**
- Never commit sensitive values to version control
- Use AWS Secrets Manager or similar for secrets
- Implement least privilege access
- Regular security reviews

---

## 🔍 **Testing and Validation**

### **Configuration Validation:**
```bash
# Validate syntax
terraform validate

# Format code
terraform fmt -recursive

# Check for security issues (using tfsec)
tfsec .

# Plan with different variables
terraform plan -var-file="dev.tfvars"
terraform plan -var-file="prod.tfvars"
```

### **Module Testing:**
```bash
# Test individual modules
cd modules/vpc
terraform init
terraform validate

cd ../web-server
terraform init
terraform validate
```

---

## 🧹 **Cleanup**

```bash
# Destroy resources in all workspaces
terraform workspace select dev
terraform destroy -var-file="dev.tfvars"

terraform workspace select prod
terraform destroy -var-file="prod.tfvars"

# Clean up workspaces
terraform workspace select default
terraform workspace delete dev
terraform workspace delete prod
```

---

<div align="center">

### 🎯 **Ready for Production Deployment?**

**Next: [04 Provisioning & Deployments](../04_provisioning_deployments/README.md)**

*Deploy real AWS infrastructure with advanced patterns!*

</div>
