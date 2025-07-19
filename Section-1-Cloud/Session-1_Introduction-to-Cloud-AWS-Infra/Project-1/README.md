# Hands-On Project 1: Deploy Live Website on EC2 with Nginx

## 🎯 Project Overview

In this hands-on project, you'll deploy a live website on Amazon EC2 using Nginx web server. You'll learn how to use EC2 User Data to automatically configure your server during launch, making the deployment process automated and repeatable.

## 📋 Prerequisites

- AWS Free Tier account
- Basic understanding of Linux commands
- AWS Management Console access
- Text editor (for creating HTML files)

## 🎓 Learning Objectives

By completing this project, you will:
- Launch and configure an EC2 instance
- Use EC2 User Data for automated server setup
- Install and configure Nginx web server
- Deploy a custom website
- Configure security groups for web traffic
- Access your live website from the internet
- Understand basic web server concepts

## 🛠️ Project Architecture

```
Internet → Security Group → EC2 Instance (Nginx) → Website Files
```

## 📝 Step-by-Step Implementation

### Step 1: Create Your Website Content

Before launching the EC2 instance, let's prepare the website content that will be deployed.

**Website Template:** See [`website-template.html`](./website-template.html) for the complete HTML code.

This template includes:
- Responsive design with modern CSS
- Professional gradient background
- Interactive skill cards with hover effects
- Technical project details
- Mobile-friendly layout

### Step 2: Access AWS Management Console

1. **Login to AWS Console:**
   - Go to https://aws.amazon.com/console/
   - Sign in with your AWS account credentials
   - Ensure you're in your preferred region (e.g., us-east-1, us-west-2)

2. **Navigate to EC2 Service:**
   - In the AWS Console search bar, type "EC2"
   - Click on "EC2" from the dropdown
   - You'll be taken to the EC2 Dashboard

### Step 3: Launch EC2 Instance

1. **Start Instance Launch:**
   - Click the orange "Launch Instance" button
   - You'll be taken to the instance launch wizard

2. **Configure Instance Details:**

   **Name and Tags:**
   - Name: `WebServer-Nginx-Project`
   - Add additional tags if needed:
     - Key: `Project`, Value: `CloudTraining`
     - Key: `Environment`, Value: `Development`

   **Application and OS Images (Amazon Machine Image):**
   - Select "Amazon Linux"
   - Choose "Amazon Linux 2 AMI (HVM) - Kernel 5.10, SSD Volume Type"
   - Architecture: 64-bit (x86)

   **Instance Type:**
   - Select `t2.micro` (Free tier eligible)
   - 1 vCPU, 1 GiB Memory

   **Key Pair (login):**
   - If you have an existing key pair, select it
   - If not, click "Create new key pair":
     - Name: `webserver-keypair`
     - Key pair type: RSA
     - Private key file format: .pem
     - Click "Create key pair" and download the .pem file
     - Store it securely on your local machine

### Step 4: Configure Network Settings

1. **Network Settings:**
   - VPC: Use default VPC
   - Subnet: Use default subnet (public subnet)
   - Auto-assign public IP: Enable

2. **Security Group Configuration:**
   - Create new security group or edit existing
   - Security group name: `WebServer-SG`
   - Description: `Security group for web server allowing HTTP and SSH`

   **Inbound Rules:**
   - Rule 1: SSH
     - Type: SSH
     - Protocol: TCP
     - Port: 22
     - Source: My IP (for secure access)
   
   - Rule 2: HTTP
     - Type: HTTP
     - Protocol: TCP
     - Port: 80
     - Source: Anywhere (0.0.0.0/0)
   
   - Rule 3: HTTPS (Optional)
     - Type: HTTPS
     - Protocol: TCP
     - Port: 443
     - Source: Anywhere (0.0.0.0/0)

### Step 5: Configure Storage

1. **Storage Configuration:**
   - Root volume: 8 GiB gp2 (General Purpose SSD)
   - Encrypted: No (for this demo)
   - Delete on termination: Yes

### Step 6: Advanced Details - User Data Script

This is the most important part! In the "Advanced Details" section, scroll down to find "User Data" and paste the script from [`user-data.sh`](./user-data.sh).

**Key features of the User Data script:**
- Updates the system packages
- Installs and configures Nginx
- Creates the custom website with professional styling
- Sets up proper file permissions and security headers
- Includes a status monitoring page
- Logs installation progress for troubleshooting

**Script highlights:**
- Automated Nginx installation and configuration
- Custom HTML website deployment
- Security headers implementation
- Status page creation
- Comprehensive logging

### Step 7: Launch the Instance

1. **Review and Launch:**
   - Review all your configurations
   - Click "Launch Instance"
   - Wait for the instance to launch (usually 1-2 minutes)

2. **Monitor Launch Status:**
   - Go to "Instances" in the EC2 dashboard
   - Find your instance named "WebServer-Nginx-Project"
   - Wait for the status to show "Running"
   - Instance State should be "running"
   - Status Checks should show "2/2 checks passed" (may take 2-3 minutes)

### Step 8: Access Your Live Website

1. **Get Public IP Address:**
   - Select your running instance
   - In the details pane below, find "Public IPv4 address"
   - Copy this IP address (e.g., 54.123.45.67)

2. **Access Your Website:**
   - Open a web browser
   - Navigate to: `http://YOUR_PUBLIC_IP`
   - You should see your live website!

3. **Test Additional Pages:**
   - Status page: `http://YOUR_PUBLIC_IP/status.html`

### Step 9: Verify Installation (Optional)

If you want to SSH into your instance to verify the setup:

1. **Connect via SSH:**
   ```bash
   chmod 400 webserver-keypair.pem
   ssh -i webserver-keypair.pem ec2-user@YOUR_PUBLIC_IP
   ```

2. **Check Nginx Status:**
   ```bash
   sudo systemctl status nginx
   sudo nginx -t
   ls -la /var/www/html/
   ```

3. **View User Data Logs:**
   ```bash
   sudo cat /var/log/user-data.log
   sudo cat /var/log/cloud-init-output.log
   ```

## 🔧 Troubleshooting

### Common Issues and Solutions:

1. **Website not loading:**
   - Check security group allows HTTP (port 80)
   - Verify instance is in "running" state
   - Ensure public IP is assigned
   - Wait 2-3 minutes for user data script to complete

2. **SSH connection refused:**
   - Check security group allows SSH (port 22) from your IP
   - Verify you're using correct key pair
   - Ensure key file permissions are 400

3. **Nginx not starting:**
   - SSH into instance and check: `sudo systemctl status nginx`
   - Check logs: `sudo journalctl -u nginx`
   - Verify configuration: `sudo nginx -t`

4. **User Data script issues:**
   - Check cloud-init logs: `sudo cat /var/log/cloud-init-output.log`
   - Verify script syntax and permissions

## 💰 Cost Considerations

- **t2.micro instance**: Free for 750 hours/month (Free Tier)
- **Data transfer**: First 1GB outbound free per month
- **Storage**: 30GB EBS free per month
- **Estimated monthly cost**: $0 (within Free Tier limits)

## 🧹 Cleanup Instructions

**Important:** Always clean up resources to avoid unexpected charges!

1. **Terminate EC2 Instance:**
   - Go to EC2 Dashboard → Instances
   - Select your instance
   - Instance State → Terminate Instance
   - Confirm termination

2. **Delete Security Group (Optional):**
   - Go to Security Groups
   - Select "WebServer-SG"
   - Actions → Delete Security Group

3. **Delete Key Pair (Optional):**
   - Go to Key Pairs
   - Select "webserver-keypair"
   - Actions → Delete

## 🎯 Learning Outcomes Achieved

After completing this project, you have:

✅ **Launched an EC2 instance** with proper configuration
✅ **Used User Data** for automated server setup
✅ **Configured Security Groups** for web traffic
✅ **Installed and configured Nginx** web server
✅ **Deployed a live website** accessible from the internet
✅ **Applied security best practices** with proper permissions
✅ **Understood Infrastructure as Code** concepts
✅ **Gained hands-on AWS experience** with core services

## 🚀 Next Steps

1. **Enhance the website** with more pages and features
2. **Add SSL/TLS certificate** for HTTPS
3. **Set up a custom domain** using Route 53
4. **Implement monitoring** with CloudWatch
5. **Create an AMI** from your configured instance
6. **Explore Load Balancers** for high availability
7. **Learn about Auto Scaling Groups** for scalability

## 📚 Additional Resources

### Quick Reference Guide
For a condensed version of this project with essential commands and troubleshooting tips, see the [Quick Reference Guide](./Quick-Reference/README.md).

### Project Files
- [`user-data.sh`](./user-data.sh) - Complete User Data script for EC2
- [`website-template.html`](./website-template.html) - HTML template for the website

### AWS Documentation
- [EC2 User Guide](https://docs.aws.amazon.com/ec2/latest/userguide/)
- [Nginx Documentation](https://nginx.org/en/docs/)
- [AWS Security Groups](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_SecurityGroups.html)
- [EC2 User Data Scripts](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/user-data.html)

---

**Project Created by Varun Kumar**

*Cloud & DevOps Training Course - Session 1 Hands-On Project*
