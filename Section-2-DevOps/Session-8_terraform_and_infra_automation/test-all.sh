#!/bin/bash

# Terraform Examples Test Script
# This script tests all Terraform examples

echo "🧪 Terraform Examples Test Script"
echo "=================================="
echo ""

# Function to test a directory
test_directory() {
    local dir=$1
    local name=$2
    
    if [ -d "$dir" ]; then
        echo "🔄 Testing $name..."
        cd "$dir"
        
        # Initialize
        echo "  - Initializing..."
        if terraform init -no-color > /dev/null 2>&1; then
            echo "  ✅ Init successful"
        else
            echo "  ❌ Init failed"
            cd - > /dev/null
            return 1
        fi
        
        # Validate
        echo "  - Validating..."
        if terraform validate -no-color > /dev/null 2>&1; then
            echo "  ✅ Validation successful"
        else
            echo "  ❌ Validation failed"
            cd - > /dev/null
            return 1
        fi
        
        # Plan
        echo "  - Planning..."
        if terraform plan -no-color > /dev/null 2>&1; then
            echo "  ✅ Plan successful"
        else
            echo "  ❌ Plan failed"
            cd - > /dev/null
            return 1
        fi
        
        echo "  ✅ $name test passed"
        cd - > /dev/null
        echo ""
        return 0
    else
        echo "⚠️  Directory $dir not found"
        echo ""
        return 1
    fi
}

# Get the script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo "Starting tests from: $SCRIPT_DIR"
echo ""

# Test all examples
FAILED=0

test_directory "04-local-file-example" "Local File Example" || FAILED=$((FAILED + 1))
test_directory "05-s3-bucket-example" "S3 Bucket Example" || FAILED=$((FAILED + 1))
test_directory "06-ec2-instance-example" "EC2 Instance Example" || FAILED=$((FAILED + 1))

# Summary
echo "📊 Test Summary"
echo "==============="
if [ $FAILED -eq 0 ]; then
    echo "🎉 All tests passed!"
    echo ""
    echo "💡 Ready to run examples:"
    echo "   cd 04-local-file-example && terraform apply"
    echo "   cd 05-s3-bucket-example && terraform apply"
    echo "   cd 06-ec2-instance-example && terraform apply"
    echo ""
    echo "⚠️  Remember to run 'terraform destroy' when done!"
else
    echo "❌ $FAILED test(s) failed"
    exit 1
fi
