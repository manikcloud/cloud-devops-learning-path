# Section 1 Solutions: EC2 Instance Launch Basics

## Answers to Questions:

### 1. Instance Name Tag
- **A1.1:** A Name tag is a key-value pair metadata that helps identify and organize AWS resources. It appears as the instance name in the EC2 console.
- **A1.2:** Descriptive names are important for:
  - Easy identification in large environments
  - Team collaboration and resource management
  - Cost tracking and billing organization
  - Automation and scripting
- **A1.3:** Without a Name tag, the instance appears as just an instance ID (e.g., i-1234567890abcdef0), making it hard to identify its purpose.

### 2. AMI (Amazon Machine Image)
- **A2.1:** An AMI is a pre-configured template containing the OS, application server, and applications needed to launch an EC2 instance.
- **A2.2:** AMI differences:
  - **Amazon Linux 2:** AWS-optimized, lightweight, includes AWS CLI, good performance, yum package manager
  - **Ubuntu 20.04 LTS:** Popular Linux distribution, apt package manager, large community support
  - **Windows Server 2019:** For Windows applications, GUI interface, PowerShell, .NET framework
- **A2.3:** **Amazon Linux 2** is best for basic web servers because:
  - Optimized for AWS services
  - Includes AWS tools pre-installed
  - Regular security updates
  - Good documentation and support
- **A2.4:** Yes, you can create custom AMIs by configuring an instance and creating an image from it.

### 3. Instance Type and Family
- **A3.1:** Instance type defines the hardware configuration (CPU, memory, storage, network capacity) of your virtual server.
- **A3.2:** Instance family is a group of instance types designed for specific use cases (general purpose, compute optimized, etc.).
- **A3.3:** Differences:
  - **t2.micro vs t3.micro:** t3 is newer generation, better performance, same cost
  - **t2.micro vs m5.large:** m5.large has more CPU cores, memory, and costs significantly more
  - **t2.micro vs c5.large:** c5.large is compute-optimized with high-performance processors
- **A3.4:** Instance families:
  - **General Purpose (T, M):** Balanced CPU, memory, networking for web servers, small databases
  - **Compute Optimized (C):** High-performance processors for CPU-intensive applications
  - **Memory Optimized (R, X):** Fast performance for memory-intensive applications
  - **Storage Optimized (I, D):** High sequential read/write access to large datasets
- **A3.5:** **t2.micro** for homework because it's free tier eligible and sufficient for basic web server.

### 4. Key Pair Details
- **A4.1:** A key pair consists of a public key (stored by AWS) and private key (downloaded by you) used for secure instance access.
- **A4.2:** Two parts: **Public key** (stays on AWS/instance) and **Private key** (.pem file you download).
- **A4.3:** Key pairs provide secure, password-less authentication that's more secure than passwords.
- **A4.4:** 
  - **RSA:** Traditional, widely supported, larger key size
  - **ED25519:** Newer, more secure, smaller key size, faster
- **A4.5:** 
  - **.pem:** For OpenSSH (Linux/Mac)
  - **.ppk:** For PuTTY (Windows)
- **A4.6:** If you lose your private key, you cannot access the instance. You'd need to:
  - Create new key pair
  - Stop instance, detach EBS volume
  - Attach volume to new instance to recover data

### 5. Security Group Configuration
- **A5.1:** Security group acts as a virtual firewall controlling inbound and outbound traffic to instances.
- **A5.2:** 
  - **Security Groups:** Instance-level, stateful, allow rules only
  - **NACLs:** Subnet-level, stateless, allow and deny rules
- **A5.3:** Security group rules:
  - **Port 22 (SSH):** Allows secure shell access for command line management
  - **Port 80 (HTTP):** Allows web traffic to access your website
- **A5.4:** Port 22 needed for SSH access to manage the instance via command line.
- **A5.5:** Port 80 needed for web browsers to access your website over HTTP.
- **A5.6:** Opening port 22 to 0.0.0.0/0 is NOT a best practice. Better options:
  - Restrict to your specific IP address
  - Use VPN or bastion host
  - Use AWS Systems Manager Session Manager
- **A5.7:** 0.0.0.0/0 means "anywhere on the internet" - all possible IP addresses.

### 6. VPC, Subnet, and Availability Zone
- **A6.1:** VPC is a logically isolated virtual network in AWS cloud where you can launch resources.
- **A6.2:** Subnet is a range of IP addresses within a VPC, typically associated with one Availability Zone.
- **A6.3:** Availability Zone is a physically separate data center within an AWS region.
- **A6.4:** 
  - **Public Subnet:** Has internet gateway, instances can get public IPs
  - **Private Subnet:** No direct internet access, more secure
- **A6.5:** **Public subnet** for web servers that need internet access.
- **A6.6:** Internet Gateway enables communication between VPC and the internet.

---

## Step-by-Step Solution:

### Launch EC2 Instance Process:

1. **Navigate to EC2 Console:**
   - AWS Console → Services → EC2
   - Click "Launch Instance"

2. **Configure Instance:**
   ```
   Name: MyFirstWebServer-[YourName]
   AMI: Amazon Linux 2 AMI (HVM) - Kernel 5.10, SSD Volume Type
   Instance Type: t2.micro (Free tier eligible)
   ```

3. **Key Pair Setup:**
   - Click "Create new key pair"
   - Name: homework-key-[yourname]
   - Key pair type: RSA
   - Private key file format: .pem
   - Click "Create key pair" and download file

4. **Network Settings:**
   - Create security group: "web-server-sg"
   - Description: "Security group for web server homework"
   - Inbound rules:
     ```
     Type: SSH, Protocol: TCP, Port: 22, Source: 0.0.0.0/0
     Type: HTTP, Protocol: TCP, Port: 80, Source: 0.0.0.0/0
     ```

5. **Storage Configuration:**
   - Keep default: 8 GiB gp2 root volume

6. **Launch:**
   - Review settings
   - Click "Launch instance"
   - Wait for "Running" state

### Verification Steps:

```bash
# Check instance status
Instance State: Running
Status Checks: 2/2 checks passed

# Verify security group
Inbound rules:
- SSH (22) from 0.0.0.0/0
- HTTP (80) from 0.0.0.0/0

# Note important details
Instance ID: i-xxxxxxxxxxxxxxxxx
Public IPv4 address: x.x.x.x
Private IPv4 address: x.x.x.x
Availability Zone: us-east-1a (example)
```

---

## Screenshots Guide:

### Required Screenshots:

1. **EC2 Dashboard:**
   - Show instances list with your running instance
   - Instance name should be visible
   - Status should be "Running"

2. **Instance Details:**
   - Click on instance ID to open details
   - Show instance type, AMI, key pair name
   - Show public and private IP addresses

3. **Security Group Rules:**
   - Click on security group link
   - Show inbound rules for ports 22 and 80
   - Show source as 0.0.0.0/0

### Screenshot Tips:
- Use full browser window
- Ensure all relevant information is visible
- Highlight important details if needed
- Save in common format (PNG, JPG)

---

## Common Issues and Solutions:

### Issue 1: Can't find Amazon Linux 2 AMI
**Solution:** 
- Look for "Amazon Linux 2 AMI (HVM) - Kernel 5.10, SSD Volume Type"
- It should be marked as "Free tier eligible"

### Issue 2: t2.micro not available
**Solution:**
- Check you're in a region that supports free tier
- Verify your account is eligible for free tier

### Issue 3: Key pair download fails
**Solution:**
- Ensure pop-ups are not blocked
- Try different browser
- Check download folder

### Issue 4: Security group creation fails
**Solution:**
- Ensure you have proper IAM permissions
- Check VPC limits haven't been exceeded
- Try creating in default VPC

---

## Best Practices Applied:

1. **Naming Convention:** Used descriptive, consistent naming
2. **Security:** Documented security group risks and alternatives
3. **Documentation:** Recorded all configuration details
4. **Cost Management:** Used free tier eligible resources
5. **Region Awareness:** Noted importance of region selection

---

## Validation Checklist:

- [ ] Instance is in "Running" state
- [ ] Instance has public IP address
- [ ] Security group allows SSH (22) and HTTP (80)
- [ ] Key pair file downloaded and saved securely
- [ ] All screenshots captured
- [ ] All questions answered
- [ ] Instance details documented

---

## Next Steps:
✅ **Section 1 Complete!**

Proceed to **Section 2: Access and Configuration** to learn how to connect to your instance and perform basic system administration tasks.

---

## Important Reminders:

⚠️ **Security:** Keep your .pem file secure and never share it
💰 **Cost:** Monitor your usage to stay within free tier limits
📝 **Documentation:** Keep track of all your AWS resources
🔄 **Cleanup:** Remember to terminate resources when done
