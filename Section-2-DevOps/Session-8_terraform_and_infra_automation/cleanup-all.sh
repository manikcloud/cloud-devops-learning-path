#!/bin/bash

# Terraform Examples Cleanup Script
# This script destroys all Terraform resources to avoid AWS charges

echo "🧹 Terraform Examples Cleanup Script"
echo "====================================="
echo ""

# Function to cleanup a directory
cleanup_directory() {
    local dir=$1
    local name=$2
    
    if [ -d "$dir" ]; then
        echo "🔄 Cleaning up $name..."
        cd "$dir"
        if [ -f "terraform.tfstate" ]; then
            terraform destroy -auto-approve
            echo "✅ $name cleaned up"
        else
            echo "ℹ️  No state file found in $name"
        fi
        cd - > /dev/null
        echo ""
    else
        echo "⚠️  Directory $dir not found"
        echo ""
    fi
}

# Get the script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo "Starting cleanup from: $SCRIPT_DIR"
echo ""

# Cleanup all examples
cleanup_directory "04-local-file-example" "Local File Example"
cleanup_directory "05-s3-bucket-example" "S3 Bucket Example"
cleanup_directory "06-ec2-instance-example" "EC2 Instance Example"

# Check for any remaining AWS resources
echo "🔍 Checking for remaining AWS resources..."
echo ""

echo "S3 Buckets with 'terraform' in name:"
aws s3api list-buckets --query 'Buckets[?contains(Name, `terraform`)].Name' --output table 2>/dev/null || echo "AWS CLI not configured or no access"
echo ""

echo "EC2 Instances with 'terraform' tag:"
aws ec2 describe-instances --filters "Name=tag:Name,Values=*terraform*" --query 'Reservations[].Instances[?State.Name!=`terminated`].[InstanceId,Tags[?Key==`Name`].Value|[0],State.Name]' --output table 2>/dev/null || echo "AWS CLI not configured or no access"
echo ""

echo "🎉 Cleanup complete!"
echo ""
echo "💡 Tips:"
echo "   - Always run 'terraform destroy' when done with examples"
echo "   - Check AWS console to verify all resources are deleted"
echo "   - Use AWS Cost Explorer to monitor spending"
