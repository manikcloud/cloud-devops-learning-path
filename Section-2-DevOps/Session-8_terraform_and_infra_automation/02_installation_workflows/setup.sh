#!/bin/bash

# Terraform Installation Script
# Supports Ubuntu, macOS, and basic Linux distributions

set -e

echo "🏗️ Terraform Installation Script"
echo "================================"

# Detect operating system
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="linux"
    echo "📋 Detected: Linux"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macos"
    echo "📋 Detected: macOS"
else
    echo "❌ Unsupported operating system: $OSTYPE"
    exit 1
fi

# Check if Terraform is already installed
if command -v terraform &> /dev/null; then
    echo "✅ Terraform is already installed:"
    terraform version
    echo ""
    echo "🔄 To upgrade, run: terraform init -upgrade"
    exit 0
fi

echo "📦 Installing Terraform..."

# Install Terraform based on OS
if [[ "$OS" == "linux" ]]; then
    # Linux installation
    echo "🔧 Installing for Linux..."
    
    # Add HashiCorp GPG key
    wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
    
    # Add HashiCorp repository
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
    
    # Update package list and install
    sudo apt update
    sudo apt install -y terraform
    
elif [[ "$OS" == "macos" ]]; then
    # macOS installation
    echo "🔧 Installing for macOS..."
    
    # Check if Homebrew is installed
    if ! command -v brew &> /dev/null; then
        echo "❌ Homebrew not found. Please install Homebrew first:"
        echo "   /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
        exit 1
    fi
    
    # Install Terraform using Homebrew
    brew tap hashicorp/tap
    brew install hashicorp/tap/terraform
fi

# Verify installation
echo ""
echo "🔍 Verifying Terraform installation..."
if command -v terraform &> /dev/null; then
    echo "✅ Terraform installed successfully!"
    terraform version
else
    echo "❌ Terraform installation failed"
    exit 1
fi

echo ""
echo "🔧 Checking AWS CLI..."

# Check AWS CLI
if command -v aws &> /dev/null; then
    echo "✅ AWS CLI is installed:"
    aws --version
    
    # Check if AWS is configured
    if aws sts get-caller-identity &> /dev/null; then
        echo "✅ AWS CLI is configured"
        echo "📋 Current AWS identity:"
        aws sts get-caller-identity
    else
        echo "⚠️  AWS CLI is not configured"
        echo "🔧 Run: aws configure"
        echo "   You'll need:"
        echo "   - AWS Access Key ID"
        echo "   - AWS Secret Access Key"
        echo "   - Default region (e.g., us-east-1)"
        echo "   - Default output format (json)"
    fi
else
    echo "❌ AWS CLI not found"
    echo "📦 Installing AWS CLI..."
    
    if [[ "$OS" == "linux" ]]; then
        sudo apt install -y awscli
    elif [[ "$OS" == "macos" ]]; then
        brew install awscli
    fi
    
    echo "✅ AWS CLI installed"
    echo "🔧 Configure it with: aws configure"
fi

echo ""
echo "🎉 Setup Complete!"
echo "=================="
echo "✅ Terraform: $(terraform version | head -1)"
echo "✅ AWS CLI: $(aws --version)"
echo ""
echo "🚀 Next Steps:"
echo "1. Configure AWS CLI: aws configure"
echo "2. Initialize Terraform: terraform init"
echo "3. Plan infrastructure: terraform plan"
echo "4. Apply changes: terraform apply"
echo ""
echo "📚 For help, check the README.md file"
