# Project 1: Linux System Administration & Cloud Deployment

## 🎯 Project Overview

This hands-on project covers the complete Linux fundamentals syllabus through practical implementation. You'll set up a Linux system on AWS cloud, master essential commands, configure SSH access, write shell scripts, and perform system administration tasks.

## 📋 Project Objectives

By completing this project, you will:
- ✅ **Deploy Linux system** on AWS cloud infrastructure
- ✅ **Master basic and advanced commands** for daily operations
- ✅ **Configure secure SSH access** with key-based authentication
- ✅ **Create shell scripts** for automation tasks
- ✅ **Manage users and packages** on Linux systems
- ✅ **Use text editors** effectively for system configuration
- ✅ **Implement file system operations** and permissions

## 🛠️ Project Tasks

### Task 1: Spinning a Linux System on AWS Cloud

#### 1.1 Launch EC2 Instance
```bash
# Using AWS CLI to launch instance
aws ec2 run-instances \
    --image-id ami-0c02fb55956c7d316 \
    --instance-type t2.micro \
    --key-name my-linux-key \
    --security-group-ids sg-12345678 \
    --subnet-id subnet-12345678 \
    --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=Linux-Lab-Server}]'
```

**Manual Steps via AWS Console:**
1. **Login to AWS Console** → Navigate to EC2
2. **Launch Instance** → Choose Amazon Linux 2 AMI
3. **Instance Type** → Select t2.micro (Free Tier)
4. **Configure Security Group:**
   ```
   SSH (22) - Your IP
   HTTP (80) - 0.0.0.0/0
   HTTPS (443) - 0.0.0.0/0
   Custom TCP (8080) - 0.0.0.0/0
   ```
5. **Create Key Pair** → Download .pem file
6. **Launch Instance** → Wait for running state

#### 1.2 Connect to Instance
```bash
# Set proper permissions for key file
chmod 400 my-linux-key.pem

# Connect via SSH
ssh -i my-linux-key.pem ec2-user@<PUBLIC-IP>

# Verify system information
uname -a
cat /etc/os-release
```

### Task 2: Basic Components & Commands Practice

#### 2.1 File System Navigation
```bash
# Explore Linux file system hierarchy
ls -la /
cd /etc && ls -la
cd /var/log && ls -la
cd /home && ls -la

# Practice navigation commands
pwd
cd ~
cd /tmp
cd -
cd ../..
```

#### 2.2 Basic Commands Implementation
```bash
# Create directory structure for project
mkdir -p ~/linux-project/{scripts,configs,logs,backups}
cd ~/linux-project

# File operations
touch test-file.txt
echo "Hello Linux World" > test-file.txt
cat test-file.txt

# Copy and move operations
cp test-file.txt backups/
mv test-file.txt configs/original-file.txt
ls -la configs/

# Create multiple files for practice
touch file{1..5}.txt
ls -la *.txt
```

#### 2.3 File Content Commands
```bash
# Create sample log file
cat > logs/sample.log << 'EOF'
2024-01-15 10:30:15 INFO Application started
2024-01-15 10:30:20 DEBUG Loading configuration
2024-01-15 10:30:25 INFO Database connected
2024-01-15 10:31:00 ERROR Connection timeout
2024-01-15 10:31:05 INFO Retrying connection
2024-01-15 10:31:10 INFO Connection restored
2024-01-15 10:32:00 WARN High memory usage
EOF

# Practice viewing commands
cat logs/sample.log
head -3 logs/sample.log
tail -3 logs/sample.log
less logs/sample.log

# Search operations
grep "ERROR" logs/sample.log
grep -i "info" logs/sample.log
grep -n "connection" logs/sample.log
```

### Task 3: Advanced Commands Mastery

#### 3.1 Find Command Practice
```bash
# Create test directory structure
mkdir -p ~/find-practice/{dir1,dir2,dir3}
touch ~/find-practice/dir1/{file1.txt,file2.log,script1.sh}
touch ~/find-practice/dir2/{data.csv,config.json,readme.md}
touch ~/find-practice/dir3/{backup.tar.gz,image.jpg,document.pdf}

# Find operations
find ~/find-practice -name "*.txt"
find ~/find-practice -type f -name "*.log"
find ~/find-practice -type d
find ~/find-practice -size +0c
find ~/find-practice -name "file*" -exec ls -la {} \;
```

#### 3.2 Advanced File Operations
```bash
# File permissions practice
chmod 755 ~/find-practice/dir1/script1.sh
chmod 644 ~/find-practice/dir2/config.json
ls -la ~/find-practice/dir1/script1.sh

# Ownership operations
sudo chown ec2-user:ec2-user ~/find-practice/dir2/config.json
ls -la ~/find-practice/dir2/config.json

# Archive operations
cd ~/linux-project
tar -czf backups/project-backup.tar.gz scripts/ configs/
tar -tzf backups/project-backup.tar.gz
tar -xzf backups/project-backup.tar.gz -C /tmp/
```

### Task 4: Package Management Implementation

#### 4.1 YUM Package Management (Amazon Linux)
```bash
# Update system packages
sudo yum update -y

# Install essential packages
sudo yum install -y git vim htop tree wget curl

# Search for packages
yum search nginx
yum info nginx

# Install nginx
sudo yum install -y nginx

# List installed packages
yum list installed | grep nginx

# Package information
rpm -qi nginx
rpm -ql nginx | head -10
```

#### 4.2 System Control Operations
```bash
# Service management with systemctl
sudo systemctl start nginx
sudo systemctl enable nginx
sudo systemctl status nginx

# Check system services
systemctl list-units --type=service --state=running

# System information
sysctl -a | grep kernel.hostname
sysctl kernel.version
```

### Task 5: Text Editors Mastery

#### 5.1 Vi/Vim Editor Practice
```bash
# Create configuration file using vim
vim ~/linux-project/configs/app-config.conf
```

**Vim Exercise Content:**
```bash
# Application Configuration File
# Created: $(date)
# Author: DevOps Engineer

[database]
host=localhost
port=5432
username=appuser
password=secure_password

[logging]
level=INFO
file=/var/log/application.log
max_size=100MB

[security]
ssl_enabled=true
encryption=AES256
timeout=300
```

**Vim Commands to Practice:**
```
# In vim (practice these operations):
i                    # Enter insert mode
Esc                  # Return to normal mode
:w                   # Save file
:q                   # Quit
:wq                  # Save and quit
/database            # Search for "database"
:%s/INFO/DEBUG/g     # Replace all INFO with DEBUG
dd                   # Delete current line
yy                   # Copy current line
p                    # Paste
u                    # Undo
```

#### 5.2 File System Configuration
```bash
# Create system monitoring script
vim ~/linux-project/scripts/system-monitor.sh
```

**Script Content:**
```bash
#!/bin/bash
# System Monitoring Script

echo "=== System Monitor Report ==="
echo "Date: $(date)"
echo "Hostname: $(hostname)"
echo "Uptime: $(uptime)"
echo ""

echo "=== Disk Usage ==="
df -h

echo ""
echo "=== Memory Usage ==="
free -h

echo ""
echo "=== CPU Information ==="
lscpu | grep "Model name"

echo ""
echo "=== Network Interfaces ==="
ip addr show | grep inet

echo ""
echo "=== Running Processes (Top 10) ==="
ps aux --sort=-%cpu | head -11
```

### Task 6: SSH & SFTP Implementation

#### 6.1 SSH Key-Based Authentication Setup
```bash
# Generate SSH key pair on local machine
ssh-keygen -t rsa -b 4096 -f ~/.ssh/linux-lab-key -C "linux-lab@example.com"

# Copy public key to server (from local machine)
ssh-copy-id -i ~/.ssh/linux-lab-key.pub ec2-user@<SERVER-IP>

# Test key-based authentication
ssh -i ~/.ssh/linux-lab-key ec2-user@<SERVER-IP>
```

#### 6.2 SSH Configuration
```bash
# Create SSH config file (on local machine)
cat > ~/.ssh/config << 'EOF'
Host linux-lab
    HostName <SERVER-IP>
    User ec2-user
    IdentityFile ~/.ssh/linux-lab-key
    Port 22
    ServerAliveInterval 60
EOF

# Connect using alias
ssh linux-lab
```

#### 6.3 SFTP File Transfer Practice
```bash
# Connect to SFTP
sftp linux-lab

# SFTP commands practice:
# ls                    # List remote files
# lls                   # List local files
# pwd                   # Remote directory
# lpwd                  # Local directory
# put local-file        # Upload file
# get remote-file       # Download file
# mkdir remote-dir      # Create remote directory
# quit                  # Exit SFTP
```

**SCP Operations:**
```bash
# Upload file to server
scp ~/local-file.txt linux-lab:~/remote-file.txt

# Download file from server
scp linux-lab:~/remote-file.txt ~/downloaded-file.txt

# Upload directory
scp -r ~/local-directory linux-lab:~/remote-directory

# Download directory
scp -r linux-lab:~/remote-directory ~/local-directory
```

### Task 7: Shell Scripting Automation

#### 7.1 Basic Shell Script
```bash
# Create user management script
vim ~/linux-project/scripts/user-manager.sh
```

**Script Content:**
```bash
#!/bin/bash
# User Management Script

# Function to create user
create_user() {
    local username=$1
    local fullname=$2
    
    if [ -z "$username" ]; then
        echo "Error: Username is required"
        return 1
    fi
    
    # Check if user exists
    if id "$username" &>/dev/null; then
        echo "User $username already exists"
        return 1
    fi
    
    # Create user
    sudo useradd -m -c "$fullname" "$username"
    echo "User $username created successfully"
    
    # Set temporary password
    echo "$username:TempPass123!" | sudo chpasswd
    echo "Temporary password set for $username"
}

# Function to list users
list_users() {
    echo "=== System Users ==="
    cut -d: -f1,3,5 /etc/passwd | grep -E ":[1-9][0-9]{3}:" | sort
}

# Function to delete user
delete_user() {
    local username=$1
    
    if [ -z "$username" ]; then
        echo "Error: Username is required"
        return 1
    fi
    
    if ! id "$username" &>/dev/null; then
        echo "User $username does not exist"
        return 1
    fi
    
    sudo userdel -r "$username"
    echo "User $username deleted successfully"
}

# Main menu
case $1 in
    create)
        create_user "$2" "$3"
        ;;
    list)
        list_users
        ;;
    delete)
        delete_user "$2"
        ;;
    *)
        echo "Usage: $0 {create|list|delete} [username] [fullname]"
        echo "Examples:"
        echo "  $0 create john 'John Doe'"
        echo "  $0 list"
        echo "  $0 delete john"
        ;;
esac
```

#### 7.2 Advanced Shell Script
```bash
# Create backup automation script
vim ~/linux-project/scripts/backup-system.sh
```

**Script Content:**
```bash
#!/bin/bash
# System Backup Script

# Configuration
BACKUP_DIR="/home/ec2-user/backups"
LOG_FILE="$BACKUP_DIR/backup.log"
DATE=$(date +%Y%m%d_%H%M%S)

# Function to log messages
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

# Function to create backup
create_backup() {
    local source_dir=$1
    local backup_name=$2
    
    if [ ! -d "$source_dir" ]; then
        log_message "ERROR: Source directory $source_dir does not exist"
        return 1
    fi
    
    local backup_file="$BACKUP_DIR/${backup_name}_${DATE}.tar.gz"
    
    log_message "Starting backup of $source_dir"
    
    if tar -czf "$backup_file" -C "$(dirname "$source_dir")" "$(basename "$source_dir")"; then
        log_message "SUCCESS: Backup created - $backup_file"
        
        # Get backup size
        local size=$(du -h "$backup_file" | cut -f1)
        log_message "Backup size: $size"
        
        return 0
    else
        log_message "ERROR: Failed to create backup"
        return 1
    fi
}

# Function to cleanup old backups
cleanup_old_backups() {
    local days=$1
    
    log_message "Cleaning up backups older than $days days"
    
    find "$BACKUP_DIR" -name "*.tar.gz" -mtime +$days -delete
    
    log_message "Cleanup completed"
}

# Create backup directory
mkdir -p "$BACKUP_DIR"

# Main execution
log_message "=== Backup Script Started ==="

# Backup configurations
create_backup "/home/ec2-user/linux-project/configs" "configs"

# Backup scripts
create_backup "/home/ec2-user/linux-project/scripts" "scripts"

# Backup logs
create_backup "/home/ec2-user/linux-project/logs" "logs"

# System information backup
echo "=== System Information ===" > "$BACKUP_DIR/system_info_${DATE}.txt"
uname -a >> "$BACKUP_DIR/system_info_${DATE}.txt"
df -h >> "$BACKUP_DIR/system_info_${DATE}.txt"
free -h >> "$BACKUP_DIR/system_info_${DATE}.txt"
ps aux >> "$BACKUP_DIR/system_info_${DATE}.txt"

# Cleanup backups older than 7 days
cleanup_old_backups 7

log_message "=== Backup Script Completed ==="
```

#### 7.3 Make Scripts Executable
```bash
# Make scripts executable
chmod +x ~/linux-project/scripts/*.sh

# Test scripts
~/linux-project/scripts/system-monitor.sh
~/linux-project/scripts/user-manager.sh list
~/linux-project/scripts/backup-system.sh
```

### Task 8: User Administration

#### 8.1 User Management Operations
```bash
# Create test users
sudo useradd -m -c "Developer User" devuser
sudo useradd -m -c "Test User" testuser

# Set passwords
echo "devuser:DevPass123!" | sudo chpasswd
echo "testuser:TestPass123!" | sudo chpasswd

# Create groups
sudo groupadd developers
sudo groupadd testers

# Add users to groups
sudo usermod -a -G developers devuser
sudo usermod -a -G testers testuser

# Verify group membership
groups devuser
groups testuser
```

#### 8.2 Permission Management
```bash
# Create shared directories
sudo mkdir -p /shared/{dev,test}

# Set group ownership
sudo chgrp developers /shared/dev
sudo chgrp testers /shared/test

# Set permissions
sudo chmod 775 /shared/dev
sudo chmod 775 /shared/test

# Set sticky bit for shared directories
sudo chmod +t /shared/dev
sudo chmod +t /shared/test

# Verify permissions
ls -la /shared/
```

#### 8.3 Advanced Permission Examples
```bash
# Create files with different permissions
touch ~/linux-project/configs/public-config.txt
touch ~/linux-project/configs/private-config.txt
touch ~/linux-project/scripts/admin-script.sh

# Set different permission levels
chmod 644 ~/linux-project/configs/public-config.txt    # rw-r--r--
chmod 600 ~/linux-project/configs/private-config.txt   # rw-------
chmod 755 ~/linux-project/scripts/admin-script.sh      # rwxr-xr-x

# Verify permissions
ls -la ~/linux-project/configs/
ls -la ~/linux-project/scripts/
```

## 📊 Project Deliverables

### 1. System Setup Documentation
- AWS EC2 instance configuration
- Security group settings
- SSH key setup and configuration

### 2. Command Mastery Evidence
- Screenshots of command executions
- File system navigation examples
- Search and file operation results

### 3. Script Collection
- `system-monitor.sh` - System monitoring automation
- `user-manager.sh` - User management operations
- `backup-system.sh` - Automated backup solution

### 4. Configuration Files
- SSH configuration
- Application configuration examples
- System service configurations

### 5. User Administration Setup
- User and group creation
- Permission management examples
- Security implementation

## 🧪 Testing and Validation

### Test Checklist
- [ ] EC2 instance successfully launched and accessible
- [ ] SSH key-based authentication working
- [ ] All basic commands executed successfully
- [ ] Advanced commands (find, grep, tar) working
- [ ] Package management operations completed
- [ ] Text editors (vim) proficiency demonstrated
- [ ] SFTP file transfers working
- [ ] Shell scripts executable and functional
- [ ] User management operations successful
- [ ] File permissions correctly implemented

### Validation Commands
```bash
# System validation
uname -a
whoami
pwd
ls -la ~/linux-project/

# Service validation
systemctl status nginx
systemctl status sshd

# Script validation
~/linux-project/scripts/system-monitor.sh
~/linux-project/scripts/user-manager.sh list

# Permission validation
ls -la /shared/
groups devuser testuser
```

## 📚 Additional Challenges

### Challenge 1: Log Analysis
```bash
# Create log analysis script
vim ~/linux-project/scripts/log-analyzer.sh

# Analyze system logs
sudo tail -100 /var/log/messages | grep ERROR
sudo journalctl --since "1 hour ago" | grep -i error
```

### Challenge 2: System Monitoring
```bash
# Create real-time monitoring
watch -n 5 'df -h && echo "" && free -h'
htop
```

### Challenge 3: Network Configuration
```bash
# Network diagnostics
ip addr show
netstat -tuln
ss -tuln
```

## 🎯 Learning Outcomes

Upon completion of this project, you will have:
- ✅ **Deployed and managed** Linux systems on AWS cloud
- ✅ **Mastered essential Linux commands** for daily operations
- ✅ **Implemented secure SSH access** with key-based authentication
- ✅ **Created automation scripts** for system administration
- ✅ **Managed users and permissions** effectively
- ✅ **Used text editors** for configuration management
- ✅ **Applied package management** for system maintenance

## 💡 Best Practices Learned

1. **Security First**: Always use key-based SSH authentication
2. **Automation**: Script repetitive tasks for efficiency
3. **Documentation**: Keep detailed logs and documentation
4. **Permissions**: Apply principle of least privilege
5. **Backups**: Regular automated backups are essential
6. **Monitoring**: Continuous system monitoring prevents issues
7. **Updates**: Keep systems updated with latest patches

---

**Created by Varun Kumar**

*Project 1: Linux System Administration & Cloud Deployment - Session 2: Linux Fundamentals*
