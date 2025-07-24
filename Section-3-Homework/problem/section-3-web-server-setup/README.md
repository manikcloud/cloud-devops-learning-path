# Section 3: Web Server Setup and HTML Creation

## Learning Objectives
By the end of this section, you will understand:
- How to install and configure Apache web server
- Basic web server administration
- HTML fundamentals and file creation
- Using vim editor effectively
- Testing web applications

---

## Prerequisites
- Completed Section 1: Instance Launch
- Completed Section 2: Access and Configuration
- Have root access to your EC2 instance
- Instance has HTTP (port 80) open in security group

---

## Questions to Answer:

### 1. Web Server Fundamentals
- **Q1.1:** What is a web server?
- **Q1.2:** What is Apache HTTP Server (httpd)?
- **Q1.3:** What are some alternatives to Apache? (Nginx, IIS, etc.)
- **Q1.4:** Why is Apache popular for web hosting?
- **Q1.5:** What is the difference between a web server and an application server?

### 2. Package Installation
- **Q2.1:** How do you install httpd on Amazon Linux?
- **Q2.2:** What does `yum install httpd -y` do?
- **Q2.3:** How do you check if a package is already installed?
- **Q2.4:** What dependencies does httpd require?
- **Q2.5:** How do you uninstall a package if needed?

### 3. Service Management with systemctl
- **Q3.1:** What is systemctl?
- **Q3.2:** What does `systemctl start httpd` do?
- **Q3.3:** What does `systemctl status httpd` show?
- **Q3.4:** What does `systemctl enable httpd` do?
- **Q3.5:** What's the difference between starting and enabling a service?
- **Q3.6:** How do you stop a service?
- **Q3.7:** How do you restart a service?

### 4. Web Directory Structure
- **Q4.1:** What is `/var/www/html` directory used for?
- **Q4.2:** Why is this the default document root?
- **Q4.3:** What permissions should web files have?
- **Q4.4:** What is the default index file name?
- **Q4.5:** How do you change the document root?

### 5. Vim Editor Mastery
- **Q5.1:** What is vim editor?
- **Q5.2:** What are the different modes in vim?
- **Q5.3:** How do you enter insert mode?
- **Q5.4:** How do you exit insert mode?
- **Q5.5:** How do you save a file in vim?
- **Q5.6:** How do you quit vim without saving?
- **Q5.7:** What are some basic navigation commands in vim?

### 6. HTML Basics
- **Q6.1:** What is HTML?
- **Q6.2:** What is the basic structure of an HTML document?
- **Q6.3:** What are HTML tags and elements?
- **Q6.4:** What is the difference between `<head>` and `<body>` sections?
- **Q6.5:** How do you create headings, paragraphs, and lists in HTML?

### 7. Network and Public Access
- **Q7.1:** How do you find your instance's public IP address?
- **Q7.2:** What is the difference between public and private IP addresses?
- **Q7.3:** How do you test if your web server is accessible?
- **Q7.4:** What tools can you use to test web connectivity?
- **Q7.5:** What happens if you access your private IP from the internet?

---

## Practical Tasks:

### Task 1: Install Apache Web Server

```bash
# Ensure you're root
sudo -i

# Install Apache HTTP Server
yum install httpd -y

# Verify installation
rpm -qa | grep httpd
```

### Task 2: Configure and Start Web Server

```bash
# Start the Apache service
systemctl start httpd

# Check service status
systemctl status httpd

# Enable Apache to start on boot
systemctl enable httpd

# Verify it's running and enabled
systemctl is-active httpd
systemctl is-enabled httpd
```

### Task 3: Explore Web Directory

```bash
# Navigate to web root directory
cd /var/www/html

# Check current directory
pwd

# List contents (should be empty initially)
ls -la

# Check directory permissions
ls -ld /var/www/html
```

### Task 4: Create Your First Web Page

```bash
# Create HTML file using vim
vim index.html
```

**In vim editor, create this HTML content:**

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
        
        <p>This is my first web server running on AWS EC2! I've successfully completed the homework assignment.</p>
        
        <h2>📋 Instance Configuration Details:</h2>
        <ul>
            <li><strong>AMI:</strong> Amazon Linux 2</li>
            <li><strong>Instance Type:</strong> t2.micro</li>
            <li><strong>Web Server:</strong> Apache HTTP Server (httpd)</li>
            <li><strong>Region:</strong> [Your AWS Region]</li>
            <li><strong>Availability Zone:</strong> [Your AZ]</li>
        </ul>
        
        <h2>✅ Skills Demonstrated:</h2>
        <ul>
            <li>EC2 instance launch and configuration</li>
            <li>Security group setup (SSH and HTTP)</li>
            <li>SSH access using EC2 Instance Connect</li>
            <li>Linux command line navigation</li>
            <li>Package installation with yum</li>
            <li>Service management with systemctl</li>
            <li>File editing with vim</li>
            <li>HTML creation and web hosting</li>
        </ul>
        
        <h2>🔧 Commands Used:</h2>
        <ul>
            <li><code>sudo -i</code> - Switch to root user</li>
            <li><code>yum update -y</code> - Update system packages</li>
            <li><code>yum install httpd -y</code> - Install Apache</li>
            <li><code>systemctl start httpd</code> - Start web server</li>
            <li><code>systemctl enable httpd</code> - Enable auto-start</li>
            <li><code>vim index.html</code> - Create web page</li>
        </ul>
    </div>

    <div class="success">
        <h2>🚀 Mission Accomplished!</h2>
        <p>Web server is running successfully on AWS EC2</p>
    </div>

    <div class="footer">
        <p><em>AWS Cloud DevOps Learning Path - Section 3 Homework</em></p>
        <p>Completed on: [Today's Date]</p>
    </div>
</body>
</html>
```

**Vim Commands to Remember:**
1. Press `i` to enter insert mode
2. Paste or type the HTML content
3. Press `Esc` to exit insert mode
4. Type `:wq` and press Enter to save and quit

### Task 5: Set Proper File Permissions

```bash
# Check current file permissions
ls -la index.html

# Set appropriate permissions (if needed)
chmod 644 index.html

# Verify ownership
chown apache:apache index.html
```

### Task 6: Test Your Web Server

```bash
# Test locally first
curl http://localhost

# Check if port 80 is listening
netstat -tlnp | grep :80

# Test with your public IP (from another terminal or browser)
curl http://YOUR_PUBLIC_IP
```

### Task 7: Find Your Public IP and Test in Browser

```bash
# Get your public IP from instance metadata
curl http://169.254.169.254/latest/meta-data/public-ipv4

# Or check in AWS Console
echo "Check your public IP in EC2 Console"
```

**Then test in web browser:**
1. Open your web browser
2. Navigate to: `http://YOUR_PUBLIC_IP`
3. You should see your webpage!

---

## Deliverables for Section 3:

### Screenshots Required:
1. **Service Status:** `systemctl status httpd` output
2. **File Creation:** `ls -la /var/www/html` showing your index.html
3. **Local Test:** `curl http://localhost` output
4. **Browser Test:** Your webpage displayed in a web browser
5. **Public IP:** Show your instance's public IP address

### Files to Submit:
1. **HTML Source:** Copy of your index.html file
2. **Command Log:** All commands you executed with outputs
3. **Answers:** Responses to all questions above

### Practical Demonstrations:
1. **Working Website:** Accessible via public IP
2. **Service Management:** Show httpd is running and enabled
3. **File Editing:** Demonstrate vim usage

---

## Advanced Tasks (Optional):

### Task A: Create Additional Pages
```bash
# Create an about page
vim about.html

# Create a simple navigation
# Link pages together
```

### Task B: Customize Apache Configuration
```bash
# View Apache configuration
cat /etc/httpd/conf/httpd.conf

# Check Apache error logs
tail -f /var/log/httpd/error_log

# Check access logs
tail -f /var/log/httpd/access_log
```

### Task C: Add Custom Error Pages
```bash
# Create custom 404 page
vim 404.html

# Configure Apache to use it
# Edit httpd.conf if needed
```

---

## Troubleshooting Guide:

### Issue 1: Web Server Won't Start
**Check:**
- Service status: `systemctl status httpd`
- Error logs: `tail /var/log/httpd/error_log`
- Port conflicts: `netstat -tlnp | grep :80`

### Issue 2: Can't Access Website from Browser
**Check:**
- Security group allows port 80
- Instance is in public subnet
- Apache is running: `systemctl status httpd`
- Public IP is correct

### Issue 3: Vim Editor Problems
**Solutions:**
- Press `Esc` to exit insert mode
- Use `:q!` to quit without saving
- Use `:wq` to save and quit
- Practice basic vim commands

### Issue 4: Permission Denied
**Solutions:**
- Ensure you're root: `sudo -i`
- Check file permissions: `ls -la`
- Set correct ownership: `chown apache:apache filename`

---

## Testing Checklist:

Before submitting, verify:
- [ ] Apache service is running and enabled
- [ ] index.html file exists in /var/www/html
- [ ] File has correct permissions (644)
- [ ] Website loads locally with curl
- [ ] Website accessible via public IP in browser
- [ ] All questions answered completely
- [ ] Screenshots captured as required

---

## Security Considerations:

1. **Keep Apache Updated:** Regular security patches
2. **File Permissions:** Don't make files executable unless needed
3. **Access Logs:** Monitor for suspicious activity
4. **Firewall Rules:** Only open necessary ports
5. **Content Security:** Validate any user-generated content

---

## Cleanup Instructions:

**Important:** After completing homework:

```bash
# Stop Apache (optional)
systemctl stop httpd

# In AWS Console:
# 1. Select your instance
# 2. Instance State → Terminate instance
# 3. Confirm termination
```

---

## Congratulations! 🎉

You have successfully:
- ✅ Launched an EC2 instance
- ✅ Configured security and networking
- ✅ Accessed instance via SSH
- ✅ Installed and configured Apache
- ✅ Created HTML content with vim
- ✅ Deployed a working website
- ✅ Tested public accessibility

**You're now ready for more advanced AWS and DevOps topics!**
