# Section 3 - Homework Solutions: AWS EC2 Basics

## Part 1: Launch an EC2 Instance - Solutions

### 1. Instance Name Tag
**Answer:**
- A Name tag is a key-value pair that helps identify and organize your AWS resources
- It's important because it makes resource management easier, especially when you have multiple instances
- Descriptive names help team members understand the purpose of each instance

**Steps:**
1. In EC2 Console, click "Launch Instance"
2. In "Name and tags" section, enter "MyFirstWebServer"

### 2. AMI (Amazon Machine Image)
**Answer:**
- An AMI is a pre-configured template that contains the OS, application server, and applications needed to launch an instance
- Different AMI types:
  - **Amazon Linux**: AWS-optimized, lightweight, good for web servers
  - **Ubuntu**: Popular Linux distribution, large community support
  - **Windows**: For Windows-based applications
- **Choose Amazon Linux 2** for this homework because it's optimized for AWS and includes yum package manager

### 3. Instance Type and Family
**Answer:**
- **Instance Type**: Specific configuration of CPU, memory, storage, and networking capacity
- **Instance Family**: Group of instance types designed for specific use cases

**Differences:**
- **t2.micro vs t3.micro**: t3 is newer generation, better performance, same cost
- **t2.micro vs m5.large**: m5.large has more CPU/memory, costs more
- **General Purpose (t2, t3, m5)**: Balanced CPU, memory, networking
- **Compute Optimized (c5)**: High-performance processors for CPU-intensive tasks

**Choose t2.micro** for homework because it's free tier eligible

### 4. Key Pair Details
**Answer:**
- A key pair consists of a public key (stored by AWS) and private key (downloaded by you)
- Used for secure SSH access to Linux instances
- Two parts: Public key (stays on instance) and Private key (.pem file you download)
- Required for secure authentication instead of passwords

**Steps:**
1. In "Key pair" section, click "Create new key pair"
2. Name: "my-homework-key"
3. Type: RSA
4. Format: .pem
5. Download and save securely

### 5. Security Group Configuration
**Answer:**
- Security group acts as a virtual firewall controlling inbound/outbound traffic
- Port 22 (SSH): Needed for command-line access to the instance
- Port 80 (HTTP): Needed for web traffic to access your website
- Opening port 22 to 0.0.0.0/0 is NOT a best practice - should restrict to your IP

**Configuration:**
```
Inbound Rules:
- Type: SSH, Port: 22, Source: 0.0.0.0/0
- Type: HTTP, Port: 80, Source: 0.0.0.0/0
```

### 6. VPC, Subnet, and Availability Zone
**Answer:**
- **VPC**: Isolated virtual network in AWS cloud
- **Subnet**: Range of IP addresses within a VPC
- **Availability Zone**: Physically separate data center within a region
- **Public Subnet**: Has internet gateway, instances get public IPs
- **Private Subnet**: No direct internet access

**Choose public subnet** for web server to allow internet access

---

## Part 2: Access and Configure - Solutions

### 7. Accessing via AWS Console
**Answer:**
- EC2 Instance Connect allows browser-based SSH access
- Prerequisites: Instance must be running, security group allows SSH, EC2 Instance Connect endpoint available

**Steps:**
1. Select your instance in EC2 Console
2. Click "Connect"
3. Choose "EC2 Instance Connect"
4. Click "Connect"

### 8. Command Line Basics
**Answer:**
- `sudo -i`: Switches to root user with root environment
- Sudo privileges needed for system administration tasks
- `sudo`: Runs single command as root
- `sudo -i`: Switches to root user completely

### 9. System Updates
**Answer:**
- `yum update`: Updates all installed packages to latest versions
- Important for security patches and bug fixes
- `-y` flag: Automatically answers "yes" to all prompts

### 10. Web Server Installation
**Answer:**
- **httpd**: Apache HTTP Server, popular web server software
- Install: `yum install httpd -y`
- `systemctl start httpd`: Starts the web server service
- `systemctl status httpd`: Shows current status of service
- `systemctl enable httpd`: Enables service to start on boot

### 11. Web Directory and File Editing
**Answer:**
- `/var/www/html`: Default document root for Apache web server
- **vim**: Powerful text editor for Linux
- Basic vim commands:
  - `vim filename`: Open/create file
  - `i`: Enter insert mode
  - `Esc`: Exit insert mode
  - `:w`: Save
  - `:q`: Quit
  - `:wq`: Save and quit

### 12. HTML and Public Access
**Answer:**
- Find public IP in EC2 Console under "Public IPv4 address"
- Test by opening `http://YOUR_PUBLIC_IP` in browser

---

## Complete Step-by-Step Solution

### Step 1: Launch EC2 Instance
1. Go to AWS Console → EC2
2. Click "Launch Instance"
3. **Name**: MyFirstWebServer
4. **AMI**: Amazon Linux 2
5. **Instance Type**: t2.micro
6. **Key Pair**: Create new "my-homework-key"
7. **Security Group**: Create new with SSH (22) and HTTP (80) from 0.0.0.0/0
8. **Subnet**: Default public subnet
9. Click "Launch Instance"

### Step 2: Connect to Instance
1. Wait for instance to be "Running"
2. Select instance → Click "Connect"
3. Choose "EC2 Instance Connect"
4. Click "Connect"

### Step 3: System Setup and Web Server Installation
```bash
# Switch to root user
sudo -i

# Update system
yum update -y

# Install Apache web server
yum install httpd -y

# Start web server
systemctl start httpd

# Check status
systemctl status httpd

# Enable auto-start on boot
systemctl enable httpd

# Navigate to web directory
cd /var/www/html
```

### Step 4: Create Web Page
```bash
# Create HTML file
vim index.html
```

**In vim editor:**
1. Press `i` to enter insert mode
2. Copy and paste the HTML content:

```html
<!DOCTYPE html>
<html>
<head>
    <title>My First AWS Web Server</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; }
        h1 { color: #232F3E; }
        .container { max-width: 800px; margin: 0 auto; }
        .highlight { background-color: #FF9900; padding: 10px; border-radius: 5px; }
    </style>
</head>
<body>
    <div class="container">
        <h1>🎉 Welcome to My First AWS Web Server!</h1>
        <div class="highlight">
            <p><strong>Hello! My name is [Your Name]</strong></p>
        </div>
        <p>This is my first web server running on AWS EC2!</p>
        
        <h2>📋 Instance Details:</h2>
        <ul>
            <li><strong>AMI:</strong> Amazon Linux 2</li>
            <li><strong>Instance Type:</strong> t2.micro</li>
            <li><strong>Web Server:</strong> Apache HTTP Server (httpd)</li>
            <li><strong>Region:</strong> [Your Region]</li>
        </ul>
        
        <h2>✅ What I Learned:</h2>
        <ul>
            <li>How to launch an EC2 instance</li>
            <li>Security group configuration</li>
            <li>SSH access using EC2 Instance Connect</li>
            <li>Linux command line basics</li>
            <li>Installing and configuring Apache</li>
            <li>Basic HTML and vim editor</li>
        </ul>
        
        <p><em>Homework completed successfully! 🚀</em></p>
    </div>
</body>
</html>
```

3. Press `Esc` to exit insert mode
4. Type `:wq` and press Enter to save and quit

### Step 5: Test Your Web Server
1. Go back to EC2 Console
2. Find your instance's "Public IPv4 address"
3. Open new browser tab
4. Navigate to: `http://YOUR_PUBLIC_IP`
5. You should see your webpage!

### Step 6: Verification Commands
```bash
# Check if httpd is running
systemctl status httpd

# Check if port 80 is listening
netstat -tlnp | grep :80

# View your HTML file
cat /var/www/html/index.html

# Check system information
uname -a
whoami
```

---

## Troubleshooting Common Issues

### Issue 1: Can't connect via SSH
**Solution:**
- Check security group allows port 22
- Verify instance is in "running" state
- Ensure you're using correct key pair

### Issue 2: Webpage not loading
**Solution:**
- Check security group allows port 80
- Verify httpd service is running: `systemctl status httpd`
- Confirm HTML file exists: `ls -la /var/www/html/`

### Issue 3: Permission denied in vim
**Solution:**
- Make sure you're root: `sudo -i`
- Check file permissions: `ls -la /var/www/html/`

---

## Bonus Answers

### 1. Making Web Server More Secure
- Restrict SSH access to your IP only
- Use HTTPS instead of HTTP
- Regular security updates
- Use IAM roles instead of key pairs when possible
- Enable CloudTrail for logging

### 2. Public IP Changes
- Yes, public IP changes when you stop/start instance
- Use Elastic IP for static public IP
- Private IP remains the same

### 3. Creating Custom AMI
1. Select instance → Actions → Image and templates → Create image
2. Provide name and description
3. AMI will be created with your configurations

### 4. Stop vs Terminate
- **Stop**: Instance shuts down, can be restarted, EBS volumes preserved
- **Terminate**: Instance is permanently deleted, all data lost

---

## Cleanup Instructions
**Important:** Don't forget to terminate your instance to avoid charges!

1. Go to EC2 Console
2. Select your instance
3. Instance State → Terminate instance
4. Confirm termination

**Congratulations! You've successfully completed your first AWS EC2 homework! 🎉**
