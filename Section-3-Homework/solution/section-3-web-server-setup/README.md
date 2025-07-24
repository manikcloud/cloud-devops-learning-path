# Section 3 Solutions: Web Server Setup and HTML Creation

## Answers to Questions:

### 1. Web Server Fundamentals
- **A1.1:** A web server is software that serves web pages to clients over HTTP/HTTPS protocols.
- **A1.2:** Apache HTTP Server (httpd) is open-source web server software that powers millions of websites worldwide.
- **A1.3:** Alternatives to Apache:
  - **Nginx:** High-performance, lightweight, good for static content
  - **IIS:** Microsoft's web server for Windows environments
  - **LiteSpeed:** Commercial web server with high performance
  - **Caddy:** Modern web server with automatic HTTPS
- **A1.4:** Apache is popular because:
  - Open source and free
  - Highly configurable and modular
  - Extensive documentation and community support
  - Cross-platform compatibility
  - Mature and stable
- **A1.5:** Differences:
  - **Web Server:** Serves static content (HTML, CSS, images)
  - **Application Server:** Executes dynamic code (PHP, Java, Python)

### 2. Package Installation
- **A2.1:** Install httpd: `yum install httpd -y`
- **A2.2:** `yum install httpd -y` downloads and installs Apache HTTP Server with all dependencies, automatically answering "yes" to prompts.
- **A2.3:** Check if package installed: `rpm -qa | grep httpd` or `yum list installed httpd`
- **A2.4:** httpd dependencies include:
  - System libraries (glibc, openssl)
  - Apache modules
  - Configuration files
- **A2.5:** Uninstall package: `yum remove httpd -y`

### 3. Service Management with systemctl
- **A3.1:** systemctl is the command-line tool for controlling systemd services in modern Linux distributions.
- **A3.2:** `systemctl start httpd` starts the Apache HTTP Server service immediately.
- **A3.3:** `systemctl status httpd` shows:
  - Service state (active, inactive, failed)
  - Process ID and memory usage
  - Recent log entries
  - Service uptime
- **A3.4:** `systemctl enable httpd` configures the service to start automatically at boot time.
- **A3.5:** Differences:
  - **Starting:** Runs service now
  - **Enabling:** Configures service to start at boot
- **A3.6:** Stop service: `systemctl stop httpd`
- **A3.7:** Restart service: `systemctl restart httpd`

### 4. Web Directory Structure
- **A4.1:** `/var/www/html` is the default document root where Apache serves web files from.
- **A4.2:** It's the default because it's configured in Apache's main configuration file (`/etc/httpd/conf/httpd.conf`).
- **A4.3:** Web files should have:
  - **Files:** 644 (rw-r--r--) - owner can read/write, others can read
  - **Directories:** 755 (rwxr-xr-x) - owner full access, others read/execute
- **A4.4:** Default index files: `index.html`, `index.htm`, `index.php`
- **A4.5:** Change document root by modifying `DocumentRoot` directive in `/etc/httpd/conf/httpd.conf`

### 5. Vim Editor Mastery
- **A5.1:** vim is a powerful, modal text editor for Unix-like systems.
- **A5.2:** vim modes:
  - **Normal mode:** Default mode for navigation and commands
  - **Insert mode:** For typing and editing text
  - **Visual mode:** For selecting text
  - **Command mode:** For executing commands (`:`)
- **A5.3:** Enter insert mode: Press `i`
- **A5.4:** Exit insert mode: Press `Esc`
- **A5.5:** Save file: `:w` (write)
- **A5.6:** Quit without saving: `:q!`
- **A5.7:** Basic navigation:
  - `h,j,k,l` - left, down, up, right
  - `w` - next word
  - `b` - previous word
  - `0` - beginning of line
  - `$` - end of line

### 6. HTML Basics
- **A6.1:** HTML (HyperText Markup Language) is the standard markup language for creating web pages.
- **A6.2:** Basic HTML structure:
  ```html
  <!DOCTYPE html>
  <html>
  <head>
      <title>Page Title</title>
  </head>
  <body>
      <h1>Heading</h1>
      <p>Paragraph</p>
  </body>
  </html>
  ```
- **A6.3:** HTML tags are keywords enclosed in angle brackets (`<tag>`), elements are complete structures with opening and closing tags.
- **A6.4:** Differences:
  - **`<head>`:** Contains metadata, title, CSS, JavaScript
  - **`<body>`:** Contains visible content displayed to users
- **A6.5:** HTML elements:
  - **Headings:** `<h1>` to `<h6>`
  - **Paragraphs:** `<p>content</p>`
  - **Lists:** `<ul><li>item</li></ul>` (unordered), `<ol><li>item</li></ol>` (ordered)

### 7. Network and Public Access
- **A7.1:** Find public IP:
  - AWS Console: EC2 → Instances → Public IPv4 address
  - Command line: `curl http://169.254.169.254/latest/meta-data/public-ipv4`
- **A7.2:** Differences:
  - **Public IP:** Accessible from internet, changes when instance stops/starts
  - **Private IP:** Only accessible within VPC, remains same
- **A7.3:** Test web server accessibility:
  - Local: `curl http://localhost`
  - Remote: `curl http://public-ip`
  - Browser: Navigate to `http://public-ip`
- **A7.4:** Testing tools:
  - `curl` - Command line HTTP client
  - `wget` - Download files from web
  - `telnet` - Test port connectivity
  - Browser - Visual testing
- **A7.5:** Private IP from internet won't work - it's not routable over the internet.

---

## Complete Step-by-Step Solution:

### Task 1: Install Apache Web Server

```bash
# Ensure you're root
sudo -i

# Install Apache HTTP Server
yum install httpd -y

# Expected output:
Loaded plugins: extras_suggestions, langpacks, priorities, update-motd
Resolving Dependencies
--> Running transaction check
---> Package httpd.x86_64 0:2.4.54-1.amzn2 will be installed
...
Complete!

# Verify installation
rpm -qa | grep httpd
# Expected output:
httpd-2.4.54-1.amzn2.x86_64
httpd-tools-2.4.54-1.amzn2.x86_64
httpd-filesystem-2.4.54-1.amzn2.noarch
```

### Task 2: Configure and Start Web Server

```bash
# Start the Apache service
systemctl start httpd

# Check service status
systemctl status httpd
# Expected output:
● httpd.service - The Apache HTTP Server
   Loaded: loaded (/usr/lib/systemd/system/httpd.service; disabled; vendor preset: disabled)
   Active: active (running) since Thu 2024-07-24 10:30:15 UTC; 5s ago
     Docs: man:httpd(8)
           man:apachectl(8)
 Main PID: 3456 (httpd)
   Status: "Processing requests..."
   CGroup: /system.slice/httpd.service
           ├─3456 /usr/sbin/httpd -DFOREGROUND
           ├─3457 /usr/sbin/httpd -DFOREGROUND
           └─3458 /usr/sbin/httpd -DFOREGROUND

# Enable Apache to start on boot
systemctl enable httpd
# Expected output:
Created symlink from /etc/systemd/system/multi-user.target.wants/httpd.service to /usr/lib/systemd/system/httpd.service.

# Verify it's running and enabled
systemctl is-active httpd
# Expected output: active

systemctl is-enabled httpd
# Expected output: enabled
```

### Task 3: Explore Web Directory

```bash
# Navigate to web root directory
cd /var/www/html

# Check current directory
pwd
# Expected output: /var/www/html

# List contents (should be empty initially)
ls -la
# Expected output:
total 0
drwxr-xr-x 2 root root  6 Jul 24 10:30 .
drwxr-xr-x 4 root root 33 Jul 24 10:30 ..

# Check directory permissions
ls -ld /var/www/html
# Expected output:
drwxr-xr-x 2 root root 6 Jul 24 10:30 /var/www/html
```

### Task 4: Create Your First Web Page

```bash
# Create HTML file using vim
vim index.html

# In vim editor:
# 1. Press 'i' to enter insert mode
# 2. Type or paste the HTML content
# 3. Press 'Esc' to exit insert mode
# 4. Type ':wq' and press Enter to save and quit
```

**Complete HTML Content:**
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My First AWS Web Server</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .header {
            background-color: #232F3E;
            color: white;
            padding: 20px;
            text-align: center;
            border-radius: 10px;
        }
        .content {
            background-color: white;
            padding: 20px;
            margin: 20px 0;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        .highlight {
            background-color: #FF9900;
            color: white;
            padding: 10px;
            border-radius: 5px;
            margin: 10px 0;
        }
        .success {
            background-color: #4CAF50;
            color: white;
            padding: 15px;
            border-radius: 5px;
            text-align: center;
        }
        ul {
            line-height: 1.6;
        }
        .footer {
            text-align: center;
            margin-top: 30px;
            color: #666;
        }
        code {
            background-color: #f4f4f4;
            padding: 2px 4px;
            border-radius: 3px;
            font-family: monospace;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>🎉 Welcome to My First AWS Web Server!</h1>
        <p>Successfully deployed on Amazon EC2</p>
    </div>

    <div class="content">
        <div class="highlight">
            <h2>👋 Hello! My name is [Your Name Here]</h2>
        </div>
        
        <p>This is my first web server running on AWS EC2! I've successfully completed the homework assignment and learned fundamental cloud computing skills.</p>
        
        <h2>📋 Instance Configuration Details:</h2>
        <ul>
            <li><strong>AMI:</strong> Amazon Linux 2</li>
            <li><strong>Instance Type:</strong> t2.micro (Free Tier)</li>
            <li><strong>Web Server:</strong> Apache HTTP Server (httpd)</li>
            <li><strong>Region:</strong> [Your AWS Region]</li>
            <li><strong>Availability Zone:</strong> [Your AZ]</li>
            <li><strong>Security Group:</strong> SSH (22) + HTTP (80)</li>
        </ul>
        
        <h2>✅ Skills Successfully Demonstrated:</h2>
        <ul>
            <li>EC2 instance launch and configuration</li>
            <li>Security group setup for web traffic</li>
            <li>SSH access using EC2 Instance Connect</li>
            <li>Linux command line navigation and administration</li>
            <li>Package installation and management with yum</li>
            <li>Service management with systemctl</li>
            <li>File editing with vim text editor</li>
            <li>HTML creation and web content development</li>
            <li>Web server configuration and testing</li>
        </ul>
        
        <h2>🔧 Key Commands Mastered:</h2>
        <ul>
            <li><code>sudo -i</code> - Switch to root user</li>
            <li><code>yum update -y</code> - Update system packages</li>
            <li><code>yum install httpd -y</code> - Install Apache web server</li>
            <li><code>systemctl start httpd</code> - Start web server service</li>
            <li><code>systemctl enable httpd</code> - Enable auto-start on boot</li>
            <li><code>systemctl status httpd</code> - Check service status</li>
            <li><code>vim index.html</code> - Create and edit web pages</li>
            <li><code>curl http://localhost</code> - Test web server locally</li>
        </ul>

        <h2>🌐 Network Configuration:</h2>
        <ul>
            <li><strong>Public IP:</strong> [Your Public IP]</li>
            <li><strong>Private IP:</strong> [Your Private IP]</li>
            <li><strong>VPC:</strong> Default VPC</li>
            <li><strong>Subnet:</strong> Public subnet</li>
            <li><strong>Internet Gateway:</strong> Enabled</li>
        </ul>
    </div>

    <div class="success">
        <h2>🚀 Mission Accomplished!</h2>
        <p>Web server is running successfully on AWS EC2</p>
        <p>Ready for advanced cloud computing challenges!</p>
    </div>

    <div class="footer">
        <p><em>AWS Cloud DevOps Learning Path - Section 3 Homework</em></p>
        <p>Completed on: <strong>[Today's Date]</strong></p>
        <p>Student: <strong>[Your Name]</strong></p>
    </div>
</body>
</html>
```

### Task 5: Set Proper File Permissions

```bash
# Check current file permissions
ls -la index.html
# Expected output:
-rw-r--r-- 1 root root 4567 Jul 24 10:45 index.html

# Set appropriate permissions (already correct)
chmod 644 index.html

# Set proper ownership for Apache
chown apache:apache index.html

# Verify changes
ls -la index.html
# Expected output:
-rw-r--r-- 1 apache apache 4567 Jul 24 10:45 index.html
```

### Task 6: Test Your Web Server

```bash
# Test locally first
curl http://localhost
# Expected output: Your HTML content

# Check if port 80 is listening
netstat -tlnp | grep :80
# Expected output:
tcp6       0      0 :::80                   :::*                    LISTEN      3456/httpd

# Alternative check
ss -tlnp | grep :80
# Expected output:
LISTEN     0      128       [::]:80                     [::]:*                   users:(("httpd",pid=3456,fd=4))

# Test with your public IP
curl http://YOUR_PUBLIC_IP
# Should return your HTML content
```

### Task 7: Find Your Public IP and Test in Browser

```bash
# Get your public IP from instance metadata
curl http://169.254.169.254/latest/meta-data/public-ipv4
# Expected output: Your public IP address (e.g., 54.123.45.67)

# Get additional instance information
curl http://169.254.169.254/latest/meta-data/instance-id
curl http://169.254.169.254/latest/meta-data/placement/availability-zone
curl http://169.254.169.254/latest/meta-data/instance-type
```

**Browser Testing:**
1. Copy your public IP address
2. Open web browser
3. Navigate to: `http://YOUR_PUBLIC_IP`
4. Your webpage should load with full styling

---

## Advanced Tasks Solutions:

### Task A: Create Additional Pages

```bash
# Create an about page
vim about.html

# Content for about.html:
<!DOCTYPE html>
<html>
<head>
    <title>About - My AWS Journey</title>
</head>
<body>
    <h1>About My AWS Learning Journey</h1>
    <p>This page demonstrates creating multiple HTML files.</p>
    <a href="index.html">Back to Home</a>
</body>
</html>

# Update index.html to include navigation
# Add this to your index.html in the content section:
<p><a href="about.html">Learn more about my journey</a></p>
```

### Task B: Customize Apache Configuration

```bash
# View Apache configuration
cat /etc/httpd/conf/httpd.conf | grep DocumentRoot
# Expected output:
DocumentRoot "/var/www/html"

# Check Apache error logs
tail -f /var/log/httpd/error_log
# Monitor for any errors

# Check access logs
tail -f /var/log/httpd/access_log
# Shows visitor requests in real-time

# View Apache modules
httpd -M | head -10
```

### Task C: Add Custom Error Pages

```bash
# Create custom 404 page
vim 404.html

# Content for 404.html:
<!DOCTYPE html>
<html>
<head>
    <title>Page Not Found</title>
</head>
<body>
    <h1>404 - Page Not Found</h1>
    <p>Sorry, the page you're looking for doesn't exist.</p>
    <a href="index.html">Return to Home</a>
</body>
</html>

# Test 404 page by accessing non-existent page
curl http://localhost/nonexistent.html
```

---

## Troubleshooting Solutions:

### Issue 1: Web Server Won't Start

**Diagnosis Commands:**
```bash
# Check service status
systemctl status httpd -l

# Check for port conflicts
netstat -tlnp | grep :80
ss -tlnp | grep :80

# Check Apache configuration syntax
httpd -t

# View error logs
tail -20 /var/log/httpd/error_log
```

**Common Solutions:**
```bash
# If port 80 is in use by another service
systemctl stop other_service
systemctl start httpd

# If configuration error
httpd -t  # Shows syntax errors
vim /etc/httpd/conf/httpd.conf  # Fix errors

# If permission issues
chown -R apache:apache /var/www/html
chmod -R 644 /var/www/html/*
```

### Issue 2: Can't Access Website from Browser

**Diagnosis:**
```bash
# Check security group in AWS Console
# Ensure port 80 is open from 0.0.0.0/0

# Verify Apache is running
systemctl status httpd

# Test local connectivity
curl http://localhost
curl http://127.0.0.1

# Check public IP
curl http://169.254.169.254/latest/meta-data/public-ipv4

# Test from instance
curl http://YOUR_PUBLIC_IP
```

**Solutions:**
```bash
# If security group issue
# Go to AWS Console → EC2 → Security Groups
# Add inbound rule: HTTP (80) from 0.0.0.0/0

# If Apache not running
systemctl start httpd
systemctl enable httpd

# If firewall blocking (rare on Amazon Linux)
systemctl status firewalld
# Usually disabled by default
```

### Issue 3: Vim Editor Problems

**Common vim Issues and Solutions:**
```bash
# Stuck in vim
Press Esc, then :q! to quit without saving

# Can't save file
Press Esc, then :w! to force save

# Accidentally deleted content
Press Esc, then u to undo

# Can't enter insert mode
Press Esc first, then i

# File is read-only
:w! to force write (if you have permissions)
sudo vim filename (edit as root)
```

### Issue 4: Permission Denied

**Diagnosis and Solutions:**
```bash
# Check file ownership
ls -la /var/www/html/

# Fix ownership
chown apache:apache /var/www/html/*

# Check directory permissions
ls -ld /var/www/html

# Fix directory permissions
chmod 755 /var/www/html
chmod 644 /var/www/html/*.html

# Ensure you're root for system changes
sudo -i
```

---

## Performance and Security Enhancements:

### Security Improvements:
```bash
# Hide Apache version
echo "ServerTokens Prod" >> /etc/httpd/conf/httpd.conf
echo "ServerSignature Off" >> /etc/httpd/conf/httpd.conf

# Restart Apache to apply changes
systemctl restart httpd

# Set up log rotation (usually already configured)
ls -la /etc/logrotate.d/httpd
```

### Performance Monitoring:
```bash
# Monitor Apache processes
ps aux | grep httpd

# Check memory usage
free -h

# Monitor disk usage
df -h

# Check network connections
netstat -an | grep :80

# Monitor real-time access
tail -f /var/log/httpd/access_log
```

---

## Complete Testing Checklist:

### Local Testing:
- [ ] `systemctl status httpd` shows "active (running)"
- [ ] `curl http://localhost` returns HTML content
- [ ] `netstat -tlnp | grep :80` shows httpd listening
- [ ] `/var/www/html/index.html` exists and has correct permissions
- [ ] Apache error log shows no critical errors

### Remote Testing:
- [ ] Public IP accessible from AWS Console
- [ ] `curl http://PUBLIC_IP` returns HTML content
- [ ] Website loads in web browser
- [ ] All styling and content displays correctly
- [ ] Navigation links work (if created)

### Security Verification:
- [ ] Security group allows HTTP (80) from 0.0.0.0/0
- [ ] Security group allows SSH (22) for management
- [ ] File permissions are appropriate (644 for files, 755 for directories)
- [ ] Apache running as apache user, not root

---

## Final Deliverables Checklist:

### Screenshots Required:
- [ ] `systemctl status httpd` output showing active status
- [ ] `ls -la /var/www/html` showing index.html file
- [ ] `curl http://localhost` output showing HTML content
- [ ] Web browser displaying your complete webpage
- [ ] AWS Console showing your instance's public IP

### Documentation Required:
- [ ] All 42 questions answered completely
- [ ] Command log with all executed commands and outputs
- [ ] HTML source code saved separately
- [ ] Any challenges faced and how you solved them
- [ ] Performance observations and improvements made

### Practical Evidence:
- [ ] Working website accessible via public IP
- [ ] Apache service running and enabled for auto-start
- [ ] Proper file permissions and ownership
- [ ] Clean error logs with no critical issues
- [ ] Additional pages created (if attempted advanced tasks)

---

## Cleanup and Next Steps:

### Proper Cleanup:
```bash
# Optional: Stop Apache if no longer needed
systemctl stop httpd
systemctl disable httpd

# In AWS Console:
# 1. Select your instance
# 2. Instance State → Terminate instance
# 3. Confirm termination
# 4. Delete security group if no longer needed
# 5. Delete key pair if no longer needed
```

### What You've Accomplished:
✅ **Infrastructure:** Launched and configured EC2 instance
✅ **Security:** Configured security groups and SSH access
✅ **System Administration:** Managed Linux services and packages
✅ **Web Development:** Created HTML content and deployed website
✅ **Networking:** Understood public/private IPs and web traffic
✅ **Troubleshooting:** Diagnosed and solved common issues

### Ready for Next Level:
- Load balancers and auto-scaling
- Database integration (RDS)
- Content delivery networks (CloudFront)
- Infrastructure as Code (CloudFormation/Terraform)
- Container deployment (Docker/ECS)
- CI/CD pipelines

---

## Congratulations! 🎉

You have successfully completed all three sections of the AWS EC2 homework! You now have practical experience with:

- **Cloud Infrastructure:** EC2 instance management
- **Linux Administration:** Command line proficiency
- **Web Technologies:** HTML and Apache configuration
- **Security:** AWS security groups and SSH
- **Networking:** Public/private networking concepts
- **Troubleshooting:** Problem-solving skills

**You're now ready to tackle more advanced cloud computing and DevOps challenges!**
