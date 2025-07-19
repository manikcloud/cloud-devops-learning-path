# Session 2: Linux Fundamentals

## 🎯 Module Overview

This module covers the fundamentals of Linux and cloud computing. You will develop essential skills to run jobs on Linux and access Linux machines on AWS cloud. This foundation is crucial for DevOps professionals working in cloud environments.

## 📚 Learning Objectives

By the end of this session, you will be able to:
- ✅ **Understand operating system concepts** and Linux architecture
- ✅ **Navigate Linux file systems** and directory structures
- ✅ **Execute basic and advanced commands** for system administration
- ✅ **Use text editors** (vi, vim, emacs) effectively
- ✅ **Launch and manage Linux instances** on AWS cloud
- ✅ **Implement secure access** using SSH with keys
- ✅ **Write shell scripts** for automation
- ✅ **Manage packages and users** on Linux systems

## 📖 Module Content

### 1. Introduction to Operating Systems

#### What is an Operating System?
An operating system (OS) is system software that manages computer hardware, software resources, and provides common services for computer programs.

**Key Functions:**
- **Process Management**: Running and scheduling programs
- **Memory Management**: Allocating and managing RAM
- **File System Management**: Organizing and storing data
- **Device Management**: Controlling hardware components
- **Security**: User authentication and access control
- **Networking**: Communication between systems

#### Types of Operating Systems

**Desktop Operating Systems:**
- Windows (Microsoft)
- macOS (Apple)
- Linux Distributions (Ubuntu, CentOS, etc.)

**Server Operating Systems:**
- Windows Server
- Linux Server Distributions
- Unix variants

**Mobile Operating Systems:**
- Android (Google)
- iOS (Apple)

**Cloud Operating Systems:**
- Container-optimized OS
- Serverless computing platforms

### 2. Overview of Linux Operating System

#### What is Linux?
Linux is a free and open-source operating system kernel created by Linus Torvalds in 1991. It forms the foundation of many operating system distributions.

#### Linux Architecture

```
┌─────────────────────────────────────┐
│           Applications              │
├─────────────────────────────────────┤
│           System Libraries          │
├─────────────────────────────────────┤
│           System Calls              │
├─────────────────────────────────────┤
│           Linux Kernel              │
├─────────────────────────────────────┤
│           Hardware                  │
└─────────────────────────────────────┘
```

**Components:**
- **Kernel**: Core of the operating system
- **Shell**: Command-line interface
- **File System**: Data organization structure
- **Utilities**: System and user programs
- **Libraries**: Shared code components

#### Popular Linux Distributions

**Enterprise Distributions:**
- **Red Hat Enterprise Linux (RHEL)**: Commercial enterprise solution
- **CentOS**: Community version of RHEL
- **Amazon Linux**: AWS-optimized distribution
- **SUSE Linux Enterprise**: Enterprise-focused distribution

**Community Distributions:**
- **Ubuntu**: User-friendly, Debian-based
- **Debian**: Stable, community-driven
- **Fedora**: Cutting-edge features
- **Arch Linux**: Minimalist, rolling release

#### Why Linux for DevOps?

**Advantages:**
- **Open Source**: Free to use and modify
- **Stability**: Reliable for server environments
- **Security**: Strong permission system
- **Flexibility**: Highly customizable
- **Performance**: Efficient resource usage
- **Community**: Large support community
- **Cloud Native**: Preferred for cloud deployments

### 3. Basic Components & Commands

#### Linux File System Hierarchy

```
/                    (Root directory)
├── bin/            (Essential user binaries)
├── boot/           (Boot loader files)
├── dev/            (Device files)
├── etc/            (Configuration files)
├── home/           (User home directories)
├── lib/            (Essential shared libraries)
├── media/          (Removable media mount points)
├── mnt/            (Temporary mount points)
├── opt/            (Optional software packages)
├── proc/           (Process information)
├── root/           (Root user home directory)
├── run/            (Runtime data)
├── sbin/           (System binaries)
├── srv/            (Service data)
├── sys/            (System information)
├── tmp/            (Temporary files)
├── usr/            (User programs and data)
└── var/            (Variable data)
```

#### Essential Basic Commands

**Navigation Commands:**
```bash
# List directory contents
ls                  # Basic listing
ls -l              # Long format (detailed)
ls -la             # Include hidden files
ls -lh             # Human-readable file sizes

# Change directory
cd /path/to/dir    # Change to specific directory
cd ~               # Change to home directory
cd ..              # Go up one directory
cd -               # Go to previous directory

# Print working directory
pwd                # Show current directory path

# Create directories
mkdir dirname      # Create single directory
mkdir -p path/to/dir  # Create nested directories
```

**File Operations:**
```bash
# Create files
touch filename     # Create empty file
echo "content" > file  # Create file with content

# Copy files and directories
cp source dest     # Copy file
cp -r source dest  # Copy directory recursively

# Move/rename files
mv oldname newname # Rename file
mv file /path/     # Move file to directory

# Remove files and directories
rm filename        # Remove file
rm -r dirname      # Remove directory recursively
rm -rf dirname     # Force remove (be careful!)
```

**File Content Commands:**
```bash
# View file contents
cat filename       # Display entire file
less filename      # View file page by page
head filename      # Show first 10 lines
tail filename      # Show last 10 lines
tail -f filename   # Follow file changes (logs)

# Search in files
grep "pattern" file    # Search for pattern in file
grep -r "pattern" dir  # Recursive search in directory
grep -i "pattern" file # Case-insensitive search
grep -n "pattern" file # Show line numbers
```

### 4. Advanced Commands

#### File Search and Management
```bash
# Find files and directories
find /path -name "filename"     # Find by name
find /path -type f -name "*.txt" # Find text files
find /path -size +100M          # Find files larger than 100MB
find /path -mtime -7            # Files modified in last 7 days

# Locate files (faster than find)
locate filename    # Find file using database
updatedb          # Update locate database

# File permissions and ownership
chmod 755 filename    # Change file permissions
chmod +x script.sh    # Make file executable
chown user:group file # Change ownership
chgrp group file      # Change group ownership

# Archive and compression
tar -czf archive.tar.gz directory/  # Create compressed archive
tar -xzf archive.tar.gz            # Extract compressed archive
zip -r archive.zip directory/      # Create zip archive
unzip archive.zip                  # Extract zip archive
```

#### System Information Commands
```bash
# System information
uname -a          # System information
hostname          # System hostname
whoami            # Current username
id                # User and group IDs
uptime            # System uptime and load

# Process management
ps aux            # List all processes
top               # Real-time process viewer
htop              # Enhanced process viewer
kill PID          # Terminate process by ID
killall name      # Terminate processes by name

# Disk usage
df -h             # Disk space usage
du -sh directory/ # Directory size
free -h           # Memory usage
lsblk             # List block devices
```

#### Package Management Commands

**For Red Hat/CentOS/Amazon Linux (YUM/DNF):**
```bash
# Package installation and management
yum update                    # Update all packages
yum install package-name      # Install package
yum remove package-name       # Remove package
yum search keyword           # Search for packages
yum list installed          # List installed packages
yum info package-name       # Package information

# DNF (newer package manager)
dnf update                   # Update all packages
dnf install package-name     # Install package
dnf remove package-name      # Remove package
```

**For Debian/Ubuntu (APT):**
```bash
# Package management
apt update                   # Update package list
apt upgrade                  # Upgrade packages
apt install package-name     # Install package
apt remove package-name      # Remove package
apt search keyword          # Search packages
apt list --installed       # List installed packages

# DPKG (low-level package manager)
dpkg -i package.deb         # Install .deb package
dpkg -r package-name        # Remove package
dpkg -l                     # List installed packages
dpkg --configure -a         # Configure packages
```

#### System Control Commands
```bash
# Service management (systemctl)
systemctl start service-name    # Start service
systemctl stop service-name     # Stop service
systemctl restart service-name  # Restart service
systemctl enable service-name   # Enable service at boot
systemctl disable service-name  # Disable service at boot
systemctl status service-name   # Check service status

# System control
sysctl -a                      # Show all kernel parameters
sysctl kernel.hostname         # Show specific parameter
sysctl -w parameter=value      # Set parameter value

# Boot management
systemctl get-default          # Show default boot target
systemctl set-default target   # Set default boot target
systemctl list-units --type=target  # List available targets
```

### 5. Text Editors and File Systems

#### Vi/Vim Editor

**Vim Modes:**
- **Normal Mode**: Navigation and commands (default)
- **Insert Mode**: Text editing
- **Visual Mode**: Text selection
- **Command Mode**: Execute commands

**Basic Vim Commands:**
```bash
# Starting vim
vim filename       # Open file in vim
vim +n filename    # Open file at line n

# Mode switching
i                  # Enter insert mode
Esc               # Return to normal mode
:                 # Enter command mode
v                 # Enter visual mode

# Navigation (Normal mode)
h, j, k, l        # Left, down, up, right
w                 # Next word
b                 # Previous word
0                 # Beginning of line
$                 # End of line
gg                # Beginning of file
G                 # End of file

# Editing (Normal mode)
x                 # Delete character
dd                # Delete line
yy                # Copy line
p                 # Paste
u                 # Undo
Ctrl+r            # Redo

# Search and replace
/pattern          # Search forward
?pattern          # Search backward
n                 # Next search result
N                 # Previous search result
:%s/old/new/g     # Replace all occurrences

# Save and quit (Command mode)
:w                # Save file
:q                # Quit
:wq               # Save and quit
:q!               # Quit without saving
```

#### Emacs Editor

**Basic Emacs Commands:**
```bash
# Starting emacs
emacs filename    # Open file in emacs

# Basic operations
Ctrl+x Ctrl+f     # Open file
Ctrl+x Ctrl+s     # Save file
Ctrl+x Ctrl+c     # Exit emacs

# Navigation
Ctrl+f            # Forward character
Ctrl+b            # Backward character
Ctrl+n            # Next line
Ctrl+p            # Previous line
Ctrl+a            # Beginning of line
Ctrl+e            # End of line

# Editing
Ctrl+d            # Delete character
Ctrl+k            # Delete to end of line
Ctrl+y            # Paste (yank)
Ctrl+_            # Undo
```

#### File Systems

**Common Linux File Systems:**
- **ext4**: Default for many Linux distributions
- **xfs**: High-performance file system
- **btrfs**: Advanced file system with snapshots
- **zfs**: Enterprise-grade file system

**File System Operations:**
```bash
# Mount and unmount
mount /dev/sdb1 /mnt/disk     # Mount device
umount /mnt/disk              # Unmount
mount -a                      # Mount all in /etc/fstab

# File system check
fsck /dev/sdb1               # Check file system
fsck -y /dev/sdb1            # Auto-fix errors

# Create file system
mkfs.ext4 /dev/sdb1          # Create ext4 file system
mkfs.xfs /dev/sdb1           # Create xfs file system
```

### 6. Spinning a Linux System on Cloud

#### AWS EC2 Instance Launch

**Step-by-Step Process:**

1. **Access AWS Console**
   - Login to AWS Management Console
   - Navigate to EC2 service

2. **Launch Instance**
   - Click "Launch Instance"
   - Choose Amazon Machine Image (AMI)
   - Select instance type (t2.micro for free tier)

3. **Configure Instance**
   - Configure instance details
   - Add storage (default 8GB)
   - Configure security group

4. **Security Group Setup**
   ```
   Type: SSH
   Protocol: TCP
   Port: 22
   Source: Your IP or 0.0.0.0/0
   ```

5. **Key Pair**
   - Create new key pair or use existing
   - Download .pem file securely

6. **Launch and Connect**
   - Review and launch instance
   - Wait for instance to be running
   - Connect using SSH

#### Instance Types and Sizing

**Common Instance Types:**
- **t2.micro**: 1 vCPU, 1GB RAM (Free Tier)
- **t2.small**: 1 vCPU, 2GB RAM
- **t3.medium**: 2 vCPU, 4GB RAM
- **m5.large**: 2 vCPU, 8GB RAM

**Choosing Instance Type:**
- **Development**: t2.micro, t2.small
- **Testing**: t3.medium, t3.large
- **Production**: m5.large, c5.large, r5.large

### 7. SSH & SFTP in Action

#### SSH (Secure Shell)

**SSH with Username/Password:**
```bash
# Basic SSH connection
ssh username@hostname
ssh username@ip-address

# SSH with specific port
ssh -p 2222 username@hostname

# SSH with verbose output
ssh -v username@hostname
```

**SSH with Private/Public Keys:**

1. **Generate Key Pair:**
   ```bash
   # Generate RSA key pair
   ssh-keygen -t rsa -b 4096 -C "your-email@example.com"
   
   # Generate ED25519 key pair (recommended)
   ssh-keygen -t ed25519 -C "your-email@example.com"
   
   # Specify key file location
   ssh-keygen -t rsa -f ~/.ssh/my-key
   ```

2. **Copy Public Key to Server:**
   ```bash
   # Copy public key to server
   ssh-copy-id username@hostname
   
   # Manual copy
   cat ~/.ssh/id_rsa.pub | ssh username@hostname "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"
   ```

3. **Connect with Private Key:**
   ```bash
   # Connect using private key
   ssh -i ~/.ssh/private-key username@hostname
   
   # AWS EC2 connection
   ssh -i ~/Downloads/my-key.pem ec2-user@ec2-ip-address
   ```

**SSH Configuration:**
```bash
# SSH config file (~/.ssh/config)
Host myserver
    HostName server.example.com
    User myusername
    IdentityFile ~/.ssh/my-private-key
    Port 22

# Connect using alias
ssh myserver
```

#### SFTP (SSH File Transfer Protocol)

**Basic SFTP Commands:**
```bash
# Connect to SFTP server
sftp username@hostname
sftp -i private-key username@hostname

# SFTP commands (once connected)
ls                    # List remote directory
lls                   # List local directory
pwd                   # Show remote directory
lpwd                  # Show local directory
cd remote-directory   # Change remote directory
lcd local-directory   # Change local directory

# File transfer
get remote-file       # Download file
put local-file        # Upload file
get -r remote-dir     # Download directory
put -r local-dir      # Upload directory

# Exit SFTP
quit
exit
```

**SCP (Secure Copy):**
```bash
# Copy file to remote server
scp local-file username@hostname:/remote/path/

# Copy file from remote server
scp username@hostname:/remote/file /local/path/

# Copy directory recursively
scp -r local-directory username@hostname:/remote/path/

# Copy with private key
scp -i private-key file username@hostname:/path/
```

### 8. Shell Scripting

#### Basic Shell Scripting

**Script Structure:**
```bash
#!/bin/bash
# This is a comment
# Script description

# Variables
NAME="World"
COUNT=10

# Output
echo "Hello, $NAME!"
echo "Count is: $COUNT"
```

**Variables and Data Types:**
```bash
#!/bin/bash

# String variables
NAME="John Doe"
MESSAGE='Hello World'

# Numeric variables
AGE=25
SCORE=95.5

# Arrays
FRUITS=("apple" "banana" "orange")
echo ${FRUITS[0]}    # First element
echo ${FRUITS[@]}    # All elements
echo ${#FRUITS[@]}   # Array length

# Environment variables
echo $HOME           # Home directory
echo $USER           # Current user
echo $PATH           # System PATH
```

**Control Structures:**
```bash
#!/bin/bash

# If-else statements
if [ $AGE -gt 18 ]; then
    echo "Adult"
elif [ $AGE -eq 18 ]; then
    echo "Just turned adult"
else
    echo "Minor"
fi

# For loops
for i in {1..5}; do
    echo "Number: $i"
done

for file in *.txt; do
    echo "Processing: $file"
done

# While loops
counter=1
while [ $counter -le 5 ]; do
    echo "Counter: $counter"
    ((counter++))
done

# Case statements
case $1 in
    start)
        echo "Starting service..."
        ;;
    stop)
        echo "Stopping service..."
        ;;
    restart)
        echo "Restarting service..."
        ;;
    *)
        echo "Usage: $0 {start|stop|restart}"
        ;;
esac
```

#### Advanced Shell Scripting

**Functions:**
```bash
#!/bin/bash

# Function definition
greet() {
    local name=$1
    echo "Hello, $name!"
}

# Function with return value
add_numbers() {
    local num1=$1
    local num2=$2
    local result=$((num1 + num2))
    echo $result
}

# Function calls
greet "Alice"
sum=$(add_numbers 5 3)
echo "Sum: $sum"
```

**Error Handling:**
```bash
#!/bin/bash

# Exit on error
set -e

# Function to handle errors
error_exit() {
    echo "Error: $1" >&2
    exit 1
}

# Check if file exists
if [ ! -f "important-file.txt" ]; then
    error_exit "important-file.txt not found"
fi

# Check command success
if ! command -v git &> /dev/null; then
    error_exit "Git is not installed"
fi
```

**File Operations in Scripts:**
```bash
#!/bin/bash

# Read file line by line
while IFS= read -r line; do
    echo "Line: $line"
done < "input.txt"

# Write to file
echo "Log entry: $(date)" >> logfile.txt

# Check file permissions
if [ -r "file.txt" ]; then
    echo "File is readable"
fi

if [ -w "file.txt" ]; then
    echo "File is writable"
fi

if [ -x "script.sh" ]; then
    echo "Script is executable"
fi
```

### 9. User Administration

#### User Management

**Creating Users:**
```bash
# Add new user
sudo useradd username
sudo useradd -m username        # Create home directory
sudo useradd -m -s /bin/bash username  # Specify shell

# Set user password
sudo passwd username

# Add user with specific UID and GID
sudo useradd -u 1001 -g 1001 username

# Create system user (no home directory)
sudo useradd -r -s /bin/false service-user
```

**Modifying Users:**
```bash
# Modify user account
sudo usermod -c "Full Name" username     # Change comment
sudo usermod -d /new/home username       # Change home directory
sudo usermod -s /bin/zsh username        # Change shell
sudo usermod -l newname oldname          # Change username

# Lock/unlock user account
sudo usermod -L username                 # Lock account
sudo usermod -U username                 # Unlock account

# Add user to group
sudo usermod -a -G groupname username
sudo usermod -a -G sudo username         # Add to sudo group
```

**Deleting Users:**
```bash
# Delete user (keep home directory)
sudo userdel username

# Delete user and home directory
sudo userdel -r username

# Force delete (even if logged in)
sudo userdel -f username
```

#### Group Management

**Group Operations:**
```bash
# Create group
sudo groupadd groupname
sudo groupadd -g 1001 groupname          # Specify GID

# Modify group
sudo groupmod -n newname oldname         # Rename group

# Delete group
sudo groupdel groupname

# Add user to group
sudo gpasswd -a username groupname

# Remove user from group
sudo gpasswd -d username groupname

# List groups
groups                                   # Current user's groups
groups username                          # Specific user's groups
```

#### Permission Management

**File Permissions:**
```bash
# Permission notation
# rwx rwx rwx (owner group others)
# 421 421 421 (read=4, write=2, execute=1)

# Common permission combinations
chmod 755 file    # rwxr-xr-x (owner: all, group/others: read+execute)
chmod 644 file    # rw-r--r-- (owner: read+write, others: read)
chmod 600 file    # rw------- (owner: read+write, others: none)
chmod 777 file    # rwxrwxrwx (all permissions for everyone)

# Symbolic notation
chmod u+x file    # Add execute for owner
chmod g-w file    # Remove write for group
chmod o=r file    # Set others to read only
chmod a+r file    # Add read for all (owner, group, others)
```

**Special Permissions:**
```bash
# Setuid (SUID) - run as file owner
chmod u+s file
chmod 4755 file

# Setgid (SGID) - run as file group
chmod g+s file
chmod 2755 file

# Sticky bit - only owner can delete
chmod +t directory
chmod 1755 directory
```

## 🛠️ Hands-On Labs

### Lab 1: Linux System Exploration
- Launch EC2 instance on AWS
- Explore file system hierarchy
- Practice basic navigation commands
- Create and manage files and directories

### Lab 2: Advanced Command Practice
- Use find and grep for file searching
- Practice file permissions and ownership
- Implement package management tasks
- Monitor system resources

### Lab 3: SSH and Remote Access
- Set up SSH key-based authentication
- Configure SSH client settings
- Practice SFTP file transfers
- Implement secure remote access

### Lab 4: Shell Scripting Project
- Create system monitoring script
- Implement user management script
- Build automated backup solution
- Practice error handling and logging

## 📊 Assessment Methods

### Practical Assessments
- Command-line proficiency test
- Shell scripting assignments
- System administration tasks
- Remote access configuration

### Knowledge Verification
- Linux concepts quiz
- File system understanding
- Security best practices
- Troubleshooting scenarios

## 📚 Additional Resources

### Documentation
- [Linux Documentation Project](https://tldp.org/)
- [GNU/Linux Command-Line Tools Summary](https://tldp.org/LDP/GNU-Linux-Tools-Summary/html/)
- [Bash Guide for Beginners](https://tldp.org/LDP/Bash-Beginners-Guide/html/)
- [Advanced Bash-Scripting Guide](https://tldp.org/LDP/abs/html/)

### Online Learning
- [Linux Journey](https://linuxjourney.com/)
- [OverTheWire Wargames](https://overthewire.org/wargames/)
- [Linux Academy](https://linuxacademy.com/)
- [Red Hat Learning](https://www.redhat.com/en/services/training)

### Books
- "The Linux Command Line" by William Shotts
- "Linux Administration: A Beginner's Guide" by Wale Soyinka
- "UNIX and Linux System Administration Handbook" by Evi Nemeth

## 🎯 Next Steps

After mastering Linux fundamentals, you'll be prepared for:
- **Session 3**: Mastering Git - Version control for collaboration
- **Advanced Linux**: System administration and security
- **Container Technologies**: Docker and Kubernetes
- **Infrastructure Automation**: Ansible and configuration management

## 💡 Key Takeaways

1. **Linux is essential** for DevOps and cloud computing
2. **Command-line proficiency** increases productivity
3. **Shell scripting** enables automation and efficiency
4. **SSH security** is crucial for remote access
5. **User management** ensures system security
6. **Package management** keeps systems updated
7. **File permissions** control access and security
8. **Practice regularly** to build muscle memory

---

**Created by Varun Kumar**

*Session 2: Linux Fundamentals - Section 2: DevOps & Infrastructure as Code*
