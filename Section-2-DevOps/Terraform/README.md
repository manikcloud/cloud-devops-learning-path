# Terraform: Infrastructure as Code for EC2 + Nginx Deployment

## 🎯 Project Overview

This project demonstrates Infrastructure as Code (IaC) principles by recreating the same EC2 + Nginx website deployment from Section 1, but using Terraform instead of the AWS Console. You'll learn how to manage infrastructure programmatically, version control your infrastructure, and implement DevOps best practices.

## 📋 Prerequisites

- Completion of Section 1 (Cloud Fundamentals)
- Basic understanding of command-line interface
- Text editor or IDE (VS Code recommended)
- Internet connection for downloading tools

## 🛠️ Environment Setup

### Step 1: Install AWS CLI

#### For Linux/macOS:
```bash
# Download AWS CLI v2
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

# Unzip the installer
unzip awscliv2.zip

# Run the installer
sudo ./aws/install

# Verify installation
aws --version
```

#### For Windows:
1. Download AWS CLI MSI installer from: https://awscli.amazonaws.com/AWSCLIV2.msi
2. Run the installer
3. Open Command Prompt and verify: `aws --version`

### Step 2: Configure AWS CLI

#### Method 1: Interactive Configuration
```bash
aws configure
```

You'll be prompted to enter:
- **AWS Access Key ID**: Your access key
- **AWS Secret Access Key**: Your secret key
- **Default region name**: e.g., `us-east-1`
- **Default output format**: `json` (recommended)

#### Method 2: Environment Variables
```bash
export AWS_ACCESS_KEY_ID="your-access-key"
export AWS_SECRET_ACCESS_KEY="your-secret-key"
export AWS_DEFAULT_REGION="us-east-1"
```

#### Method 3: AWS Credentials File
Create `~/.aws/credentials`:
```ini
[default]
aws_access_key_id = your-access-key
aws_secret_access_key = your-secret-key
```

Create `~/.aws/config`:
```ini
[default]
region = us-east-1
output = json
```

### Step 3: Verify AWS CLI Configuration

```bash
# Test AWS CLI connection
aws sts get-caller-identity

# List available regions
aws ec2 describe-regions --output table

# Check your default region
aws configure get region
```

### Step 4: Install Terraform

#### For Linux:
```bash
# Add HashiCorp GPG key
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

# Add HashiCorp repository
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

# Update and install
sudo apt update && sudo apt install terraform

# Verify installation
terraform --version
```

#### For macOS:
```bash
# Using Homebrew
brew tap hashicorp/tap
brew install hashicorp/tap/terraform

# Verify installation
terraform --version
```

#### For Windows:
1. Download Terraform from: https://www.terraform.io/downloads
2. Extract the executable to a directory in your PATH
3. Verify: `terraform --version`

### Step 5: Set Up Project Directory

```bash
# Navigate to the Terraform directory
cd Section-2-DevOps/Terraform

# Initialize Terraform (run this after creating .tf files)
terraform init

# Validate configuration
terraform validate

# Plan deployment
terraform plan

# Apply configuration
terraform apply
```

## 📁 Project Structure

```
Terraform/
├── README.md                 # This file
├── main.tf                   # Main Terraform configuration
├── variables.tf              # Input variables
├── outputs.tf                # Output values
├── terraform.tfvars.example  # Example variables file
├── user-data.sh             # User data script
└── .gitignore               # Git ignore file
```

## 🚀 Terraform Configuration Files

The following files will be created to deploy the same EC2 + Nginx setup:

1. **main.tf** - Main infrastructure configuration
2. **variables.tf** - Configurable parameters
3. **outputs.tf** - Important values to display
4. **user-data.sh** - Server initialization script
5. **terraform.tfvars.example** - Example configuration values

## 🎓 Learning Objectives

By completing this Terraform project, you will:

- ✅ **Understand IaC principles** and benefits
- ✅ **Write Terraform configurations** using HCL syntax
- ✅ **Manage infrastructure state** with Terraform
- ✅ **Use variables and outputs** for flexible configurations
- ✅ **Implement version control** for infrastructure code
- ✅ **Apply DevOps best practices** for infrastructure management
- ✅ **Compare IaC vs manual deployment** approaches

## 🔄 Terraform Workflow

```
Write → Plan → Apply → Manage → Destroy
```

1. **Write**: Create .tf configuration files
2. **Plan**: Review what Terraform will create/change
3. **Apply**: Execute the infrastructure changes
4. **Manage**: Update and maintain infrastructure
5. **Destroy**: Clean up resources when done

## 💡 Key Concepts Covered

### Infrastructure as Code Benefits:
- **Version Control**: Track infrastructure changes
- **Reproducibility**: Deploy identical environments
- **Automation**: Reduce manual errors
- **Documentation**: Code serves as documentation
- **Collaboration**: Team-based infrastructure management

### Terraform Concepts:
- **Providers**: Interface to cloud services (AWS)
- **Resources**: Infrastructure components (EC2, Security Groups)
- **Variables**: Parameterized configurations
- **Outputs**: Important values to display
- **State**: Current infrastructure status tracking

## 🔧 Troubleshooting

### Common Issues:

1. **AWS CLI not configured:**
   ```bash
   aws configure list
   aws sts get-caller-identity
   ```

2. **Terraform not initialized:**
   ```bash
   terraform init
   ```

3. **Permission errors:**
   - Check AWS IAM permissions
   - Verify access keys are correct

4. **State file issues:**
   ```bash
   terraform refresh
   terraform state list
   ```

## 🧹 Cleanup

**Important**: Always destroy resources to avoid charges!

```bash
# Destroy all resources
terraform destroy

# Confirm destruction
# Type 'yes' when prompted
```

## 📚 Additional Resources

- [Terraform AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [AWS CLI User Guide](https://docs.aws.amazon.com/cli/latest/userguide/)
- [Terraform Best Practices](https://www.terraform.io/docs/cloud/guides/recommended-practices/index.html)
- [HashiCorp Learn Terraform](https://learn.hashicorp.com/terraform)

## 🎯 Next Steps

After completing this project:
1. Explore Terraform modules for reusability
2. Learn about Terraform state management
3. Implement CI/CD for infrastructure
4. Study advanced Terraform patterns
5. Explore other IaC tools (CloudFormation, Pulumi)

---

**Created by Varun Kumar**

*Terraform Module - Section 2: DevOps & Infrastructure as Code*
