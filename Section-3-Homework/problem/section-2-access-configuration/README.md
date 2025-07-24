# Section 2: Instance Access and Configuration

## Learning Objectives
By the end of this section, you will understand:
- Different methods to access EC2 instances
- Basic Linux command line operations
- System administration fundamentals
- User privileges and security

---

## Prerequisites
- Completed Section 1: Instance Launch
- Have a running EC2 instance
- Downloaded your key pair file

---

## Questions to Answer:

### 1. Instance Access Methods
- **Q1.1:** What are the different ways to connect to an EC2 instance?
- **Q1.2:** What is "EC2 Instance Connect"?
- **Q1.3:** What are the prerequisites for using browser-based SSH?
- **Q1.4:** What's the difference between EC2 Instance Connect and traditional SSH?
- **Q1.5:** When would you use each method?

### 2. SSH and Key-Based Authentication
- **Q2.1:** What is SSH (Secure Shell)?
- **Q2.2:** How does key-based authentication work?
- **Q2.3:** What's the difference between password and key-based authentication?
- **Q2.4:** Why is key-based authentication more secure?
- **Q2.5:** What port does SSH use by default?

### 3. Linux User Management
- **Q3.1:** What does `sudo -i` command do?
- **Q3.2:** What's the difference between `sudo` and `sudo -i`?
- **Q3.3:** What does `su` command do?
- **Q3.4:** Why do we need sudo privileges?
- **Q3.5:** What is the root user and why is it important?
- **Q3.6:** What does `whoami` command show?

### 4. System Updates and Package Management
- **Q4.1:** What does `yum update` command do?
- **Q4.2:** Why is it important to update your system regularly?
- **Q4.3:** What does the `-y` flag do in yum commands?
- **Q4.4:** What's the difference between `yum update` and `yum upgrade`?
- **Q4.5:** How do you check what packages are installed?
- **Q4.6:** What is a package manager and why do we need it?

### 5. Basic Linux Commands
- **Q5.1:** What do these commands do:
  - `ls -la`
  - `pwd`
  - `cd /path/to/directory`
  - `mkdir directory_name`
  - `touch filename`
  - `cat filename`
- **Q5.2:** How do you check system information:
  - `uname -a`
  - `df -h`
  - `free -h`
  - `ps aux`
- **Q5.3:** What are file permissions in Linux and how do you read them?

---

## Practical Tasks:

### Task 1: Connect to Your Instance

#### Method 1: Using EC2 Instance Connect (Browser-based)
1. Go to EC2 Console
2. Select your instance
3. Click "Connect" button
4. Choose "EC2 Instance Connect"
5. Click "Connect"

#### Method 2: Using SSH Client (if available)
```bash
# If you have SSH client installed locally
ssh -i "your-key.pem" ec2-user@your-public-ip
```

### Task 2: Basic System Exploration
Once connected, run these commands and document the output:

```bash
# Check current user
whoami

# Check current directory
pwd

# List files in current directory
ls -la

# Check system information
uname -a

# Check system resources
free -h
df -h

# Check running processes
ps aux | head -10
```

### Task 3: Switch to Root User
```bash
# Switch to root user
sudo -i

# Verify you're now root
whoami

# Check current directory
pwd
```

### Task 4: System Updates
```bash
# Update package repository
yum update -y

# Check if any packages were updated
echo "System update completed"

# Check yum history
yum history | head -5
```

### Task 5: Basic File Operations
```bash
# Create a test directory
mkdir /tmp/homework-test

# Navigate to the directory
cd /tmp/homework-test

# Create a test file
touch test-file.txt

# Add some content
echo "Hello from EC2 instance!" > test-file.txt

# View the content
cat test-file.txt

# List files with details
ls -la
```

---

## Deliverables for Section 2:

### Screenshots Required:
1. **EC2 Instance Connect:** Browser showing successful connection
2. **Terminal Output:** Results of system exploration commands
3. **Root Access:** Terminal showing you switched to root user
4. **System Update:** Output of yum update command

### Documentation Required:
1. **Answer all questions** in a text document
2. **Command Log:** Copy and paste all commands you ran with their outputs
3. **Observations:** Note any interesting findings or issues encountered

### Practical Evidence:
1. **File Creation:** Show you successfully created files in /tmp/homework-test
2. **System Info:** Document your instance's system specifications
3. **Update Log:** Show what packages (if any) were updated

---

## Common Issues and Troubleshooting:

### Issue 1: Can't Connect via EC2 Instance Connect
**Possible Causes:**
- Instance not in running state
- Security group doesn't allow SSH (port 22)
- Instance in private subnet without proper routing

**Solutions:**
- Check instance state in EC2 console
- Verify security group rules
- Ensure instance is in public subnet

### Issue 2: Permission Denied Errors
**Possible Causes:**
- Not using sudo for system operations
- Incorrect file permissions

**Solutions:**
- Use `sudo` for system commands
- Switch to root with `sudo -i`

### Issue 3: Command Not Found
**Possible Causes:**
- Package not installed
- Command not in PATH

**Solutions:**
- Install required package with yum
- Check command spelling

---

## Security Best Practices:

1. **Always log out** when finished working
2. **Don't leave sessions open** unattended
3. **Use sudo judiciously** - don't stay as root unnecessarily
4. **Keep systems updated** regularly
5. **Monitor access logs** for suspicious activity

---

## Knowledge Check:

Before proceeding to Section 3, ensure you can:
- [ ] Connect to your instance using EC2 Instance Connect
- [ ] Switch between regular user and root
- [ ] Run basic Linux commands confidently
- [ ] Update system packages
- [ ] Create and manipulate files and directories
- [ ] Understand file permissions basics

---

## Next Steps:
Once you complete this section, proceed to:
- **Section 3:** Web Server Setup and HTML Creation

---

## Additional Learning Resources:
- AWS EC2 User Guide: Instance Connect
- Linux Command Line Basics
- SSH Key Management Best Practices
