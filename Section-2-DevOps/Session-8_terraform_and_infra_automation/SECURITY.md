# 🔒 Security Best Practices for Terraform

## 📋 **Important Security Guidelines**

### **🚨 Never Commit These Files:**
- `*.tfvars` - May contain sensitive configuration
- `*.tfstate` - Contains infrastructure state and secrets
- `*.pem` - SSH private keys
- `.aws/credentials` - AWS access keys
- `.env` files - Environment variables with secrets

### **✅ Safe to Commit:**
- `*.tf` - Terraform configuration files
- `*.tfvars.example` - Example configuration templates
- `.gitignore` - Git ignore rules
- `README.md` - Documentation

---

## 🛡️ **Security Checklist**

### **Before Committing Code:**
- [ ] Check `.gitignore` is properly configured
- [ ] Verify no `*.tfvars` files are staged
- [ ] Ensure no AWS credentials in code
- [ ] Remove any hardcoded secrets or keys
- [ ] Use `terraform.tfvars.example` for templates

### **AWS Credentials Management:**
```bash
# ✅ Good: Use AWS CLI configuration
aws configure

# ✅ Good: Use environment variables
export AWS_ACCESS_KEY_ID="your-key"
export AWS_SECRET_ACCESS_KEY="your-secret"

# ❌ Bad: Hardcode in .tf files
provider "aws" {
  access_key = "AKIAIOSFODNN7EXAMPLE"  # Never do this!
  secret_key = "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"
}
```

### **State File Security:**
```bash
# ✅ Good: Use remote state with encryption
terraform {
  backend "s3" {
    bucket         = "my-terraform-state"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}

# ❌ Bad: Commit local state files
# terraform.tfstate files contain sensitive data
```

---

## 🔍 **What's in .gitignore**

### **Terraform-Specific:**
```gitignore
# Terraform directories and files
**/.terraform/*
*.tfstate
*.tfstate.*
*.tfvars
*.tfvars.json
*tfplan*
.terraformrc
terraform.rc
```

### **Sensitive Data:**
```gitignore
# AWS credentials
.aws/
credentials
config

# SSH keys
*.pem
*.key
id_rsa*

# Environment files
.env
.env.local
```

### **Development Files:**
```gitignore
# IDE files
.vscode/
.idea/
*.iml

# OS files
.DS_Store
Thumbs.db

# Temporary files
*.log
*.tmp
*.swp
```

---

## 🚀 **Quick Security Setup**

### **1. Configure Git Properly:**
```bash
# Set up global gitignore
git config --global core.excludesfile ~/.gitignore_global

# Add Terraform patterns to global ignore
echo "*.tfvars" >> ~/.gitignore_global
echo "*.tfstate*" >> ~/.gitignore_global
echo ".terraform/" >> ~/.gitignore_global
```

### **2. Use terraform.tfvars.example:**
```bash
# Create example file (safe to commit)
cp terraform.tfvars terraform.tfvars.example

# Edit example to remove sensitive values
# Commit the example, ignore the actual tfvars
git add terraform.tfvars.example
git commit -m "Add terraform variables example"
```

### **3. Verify Before Committing:**
```bash
# Check what files will be committed
git status

# Verify no sensitive files are staged
git diff --cached --name-only | grep -E '\.(tfvars|tfstate|pem)$'

# If any sensitive files found, unstage them
git reset HEAD sensitive-file.tfvars
```

---

## 🔧 **Emergency: Accidentally Committed Secrets**

### **If you committed sensitive data:**

#### **1. Remove from latest commit:**
```bash
# Remove file and commit
git rm terraform.tfvars
git commit -m "Remove sensitive tfvars file"

# Add to gitignore
echo "terraform.tfvars" >> .gitignore
git add .gitignore
git commit -m "Add tfvars to gitignore"
```

#### **2. Remove from git history:**
```bash
# Remove file from entire git history (use carefully!)
git filter-branch --force --index-filter \
  'git rm --cached --ignore-unmatch terraform.tfvars' \
  --prune-empty --tag-name-filter cat -- --all

# Force push (if working alone)
git push --force --all
```

#### **3. Rotate compromised credentials:**
- **AWS Keys:** Delete and create new access keys
- **SSH Keys:** Generate new key pairs
- **Passwords:** Change all affected passwords

---

## 📚 **Additional Resources**

### **Terraform Security:**
- [Terraform Security Best Practices](https://learn.hashicorp.com/tutorials/terraform/security)
- [AWS Provider Security](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#authentication)

### **Git Security:**
- [Git Secrets Tool](https://github.com/awslabs/git-secrets)
- [GitHub Security Best Practices](https://docs.github.com/en/code-security)

### **AWS Security:**
- [AWS IAM Best Practices](https://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html)
- [AWS CLI Configuration](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html)

---

## ⚠️ **Remember:**
- **Security is everyone's responsibility**
- **When in doubt, don't commit**
- **Use example files for templates**
- **Keep credentials separate from code**
- **Regular security audits of repositories**
