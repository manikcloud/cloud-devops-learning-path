# Section 2 Solutions: Instance Access and Configuration

## Answers to Questions:

### 1. Instance Access Methods
- **A1.1:** Different ways to connect to EC2:
  - EC2 Instance Connect (browser-based SSH)
  - SSH client with key pair
  - AWS Systems Manager Session Manager
  - EC2 Serial Console (for troubleshooting)
- **A1.2:** EC2 Instance Connect is a browser-based SSH connection service that allows secure access without managing SSH keys locally.
- **A1.3:** Prerequisites for browser-based SSH:
  - Instance running Amazon Linux 2 or Ubuntu
  - Security group allows SSH (port 22)
  - EC2 Instance Connect package installed (pre-installed on Amazon Linux 2)
  - Instance in public subnet or accessible via NAT
- **A1.4:** Differences:
  - **EC2 Instance Connect:** Browser-based, no local SSH client needed, temporary keys
  - **Traditional SSH:** Requires SSH client, uses your downloaded key pair, more control
- **A1.5:** Use cases:
  - **EC2 Instance Connect:** Quick access, no SSH client available, temporary tasks
  - **Traditional SSH:** Automation, scripting, file transfers, persistent connections

### 2. SSH and Key-Based Authentication
- **A2.1:** SSH (Secure Shell) is a cryptographic network protocol for secure communication over unsecured networks.
- **A2.2:** Key-based authentication uses public-private key pairs where the public key is on the server and private key is with the user.
- **A2.3:** Differences:
  - **Password:** User types password, can be brute-forced, easier to compromise
  - **Key-based:** Uses cryptographic keys, much more secure, no password transmission
- **A2.4:** Key-based authentication is more secure because:
  - Keys are much longer and more complex than passwords
  - Private key never transmitted over network
  - Resistant to brute-force attacks
  - Can be easily revoked and replaced
- **A2.5:** SSH uses port 22 by default.

### 3. Linux User Management
- **A3.1:** `sudo -i` switches to the root user with root's environment and shell.
- **A3.2:** Differences:
  - **`sudo`:** Runs single command as root, keeps current environment
  - **`sudo -i`:** Switches to root user completely with root's environment
- **A3.3:** `su` (switch user) changes to another user account, typically root.
- **A3.4:** Sudo privileges needed for:
  - Installing software packages
  - Modifying system files
  - Managing services
  - Changing system configuration
- **A3.5:** Root user is the superuser with unlimited privileges on the system.
- **A3.6:** `whoami` shows the current username you're logged in as.

### 4. System Updates and Package Management
- **A4.1:** `yum update` downloads and installs the latest versions of all installed packages.
- **A4.2:** Regular updates are important for:
  - Security patches and vulnerability fixes
  - Bug fixes and stability improvements
  - New features and performance enhancements
  - Compatibility with other software
- **A4.3:** The `-y` flag automatically answers "yes" to all prompts, making the command non-interactive.
- **A4.4:** Differences:
  - **`yum update`:** Updates packages to newer versions within same major release
  - **`yum upgrade`:** Similar to update but handles obsolete packages differently
- **A4.5:** Check installed packages: `yum list installed` or `rpm -qa`
- **A4.6:** Package manager automates software installation, updates, and removal, handling dependencies automatically.

### 5. Basic Linux Commands
- **A5.1:** Command explanations:
  - **`ls -la`:** List all files with detailed information including hidden files
  - **`pwd`:** Print working directory (current location)
  - **`cd /path/to/directory`:** Change directory to specified path
  - **`mkdir directory_name`:** Create new directory
  - **`touch filename`:** Create empty file or update timestamp
  - **`cat filename`:** Display file contents
- **A5.2:** System information commands:
  - **`uname -a`:** System information (kernel, hostname, architecture)
  - **`df -h`:** Disk space usage in human-readable format
  - **`free -h`:** Memory usage in human-readable format
  - **`ps aux`:** List all running processes
- **A5.3:** File permissions format: `rwxrwxrwx` (owner, group, others) where r=read, w=write, x=execute.

---

## Step-by-Step Solutions:

### Task 1: Connect to Your Instance

#### Method 1: EC2 Instance Connect
```
1. AWS Console → EC2 → Instances
2. Select your instance
3. Click "Connect" button
4. Select "EC2 Instance Connect" tab
5. User name: ec2-user (default for Amazon Linux)
6. Click "Connect"
```

**Expected Result:** Browser opens terminal session connected to your instance.

#### Method 2: SSH Client (if available)
```bash
# Make key file secure
chmod 400 homework-key-yourname.pem

# Connect via SSH
ssh -i "homework-key-yourname.pem" ec2-user@YOUR_PUBLIC_IP
```

### Task 2: Basic System Exploration

**Commands and Expected Outputs:**

```bash
# Check current user
$ whoami
ec2-user

# Check current directory
$ pwd
/home/ec2-user

# List files in current directory
$ ls -la
total 12
drwx------ 3 ec2-user ec2-user  95 Jul 24 10:00 .
drwxr-xr-x 3 root     root      22 Jul 24 09:45 ..
-rw-r--r-- 1 ec2-user ec2-user  18 Jan 28 22:29 .bash_logout
-rw-r--r-- 1 ec2-user ec2-user 193 Jan 28 22:29 .bash_profile
-rw-r--r-- 1 ec2-user ec2-user 231 Jan 28 22:29 .bashrc
drwx------ 2 ec2-user ec2-user  29 Jul 24 09:45 .ssh

# Check system information
$ uname -a
Linux ip-172-31-32-123 5.10.184-175.731.amzn2.x86_64 #1 SMP Thu Jun 15 21:33:12 UTC 2023 x86_64 x86_64 x86_64 GNU/Linux

# Check system resources
$ free -h
              total        used        free      shared  buff/cache   available
Mem:          983Mi        85Mi       743Mi       0.0Ki       154Mi       783Mi
Swap:            0B          0B          0B

$ df -h
Filesystem      Size  Used Avail Use% Mounted on
devtmpfs        483M     0  483M   0% /dev
tmpfs           492M     0  492M   0% /dev/shm
tmpfs           492M  460K  492M   1% /run
tmpfs           492M     0  492M   0% /sys/fs/cgroup
/dev/xvda1      8.0G  1.6G  6.5G  20% /
tmpfs            99M     0   99M   0% /run/user/1000

# Check running processes (first 10)
$ ps aux | head -10
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root         1  0.0  0.1  43496  1648 ?        Ss   09:45   0:01 /usr/lib/systemd/systemd --switched-root --system --deserialize 22
root         2  0.0  0.0      0     0 ?        S    09:45   0:00 [kthreadd]
root         4  0.0  0.0      0     0 ?        I<   09:45   0:00 [kworker/0:0H]
...
```

### Task 3: Switch to Root User

```bash
# Switch to root user
$ sudo -i

# Verify you're now root
# whoami
root

# Check current directory
# pwd
/root
```

**Notice:** Prompt changes from `$` to `#` indicating root access.

### Task 4: System Updates

```bash
# Update package repository
# yum update -y
Loaded plugins: extras_suggestions, langpacks, priorities, update-motd
amzn2-core                                               | 3.7 kB     00:00
Resolving Dependencies
--> Running transaction check
...
Complete!

# Check if any packages were updated
# echo "System update completed"
System update completed

# Check yum history
# yum history | head -5
Loaded plugins: extras_suggestions, langpacks, priorities, update-motd
ID     | Command line             | Date and time    | Action(s)      | Altered
-------------------------------------------------------------------------------
     2 | update -y                | 2024-07-24 10:15 | Update         |   15
     1 |                          | 2024-07-24 09:45 | Install        |  137
```

### Task 5: Basic File Operations

```bash
# Create a test directory
# mkdir /tmp/homework-test

# Navigate to the directory
# cd /tmp/homework-test

# Create a test file
# touch test-file.txt

# Add some content
# echo "Hello from EC2 instance!" > test-file.txt

# View the content
# cat test-file.txt
Hello from EC2 instance!

# List files with details
# ls -la
total 4
drwxr-xr-x  2 root root   26 Jul 24 10:20 .
drwxrwxrwt 10 root root  220 Jul 24 10:20 ..
-rw-r--r--  1 root root   25 Jul 24 10:20 test-file.txt
```

---

## Screenshot Examples:

### 1. EC2 Instance Connect
**What to capture:**
- Browser showing terminal interface
- Command prompt showing `ec2-user@ip-xxx-xxx-xxx-xxx`
- Successful connection message

### 2. Terminal Output
**What to capture:**
- Results of `whoami`, `pwd`, `ls -la` commands
- System information from `uname -a`
- Memory and disk usage outputs

### 3. Root Access
**What to capture:**
- Prompt change from `$` to `#`
- `whoami` showing "root"
- Different working directory `/root`

### 4. System Update
**What to capture:**
- `yum update -y` command execution
- Package update progress
- "Complete!" message

---

## Common Issues and Solutions:

### Issue 1: EC2 Instance Connect Fails
**Symptoms:**
- "Failed to connect" error
- Timeout during connection

**Solutions:**
```bash
# Check instance status
Instance must be "Running"

# Verify security group
Inbound rule: SSH (22) from 0.0.0.0/0

# Check instance subnet
Must be public subnet or have NAT gateway

# Verify EC2 Instance Connect availability
Available in most regions for Amazon Linux 2
```

### Issue 2: Permission Denied Errors
**Symptoms:**
- "Permission denied" when running commands
- Cannot create files or directories

**Solutions:**
```bash
# Use sudo for system operations
sudo command_name

# Switch to root for multiple operations
sudo -i

# Check current user
whoami
```

### Issue 3: Command Not Found
**Symptoms:**
- "command not found" error
- Package-specific commands fail

**Solutions:**
```bash
# Update package database
yum update -y

# Install missing packages
yum install package_name -y

# Check if command exists
which command_name
```

### Issue 4: Network Connectivity Issues
**Symptoms:**
- Cannot reach external sites
- Package downloads fail

**Solutions:**
```bash
# Test internet connectivity
ping -c 3 8.8.8.8

# Check DNS resolution
nslookup google.com

# Verify routing
ip route show
```

---

## Security Best Practices Demonstrated:

### 1. Proper User Management
```bash
# Don't stay as root unnecessarily
sudo -i  # Only when needed
exit     # Return to regular user

# Use sudo for individual commands
sudo systemctl status httpd
```

### 2. System Maintenance
```bash
# Regular updates
yum update -y

# Check system logs
tail /var/log/messages
```

### 3. File Permissions
```bash
# Check permissions before modifying
ls -la filename

# Set appropriate permissions
chmod 644 filename  # Read/write for owner, read for others
```

---

## Knowledge Validation:

### Commands You Should Now Know:
- [ ] `whoami` - Check current user
- [ ] `pwd` - Show current directory
- [ ] `ls -la` - List files with details
- [ ] `sudo -i` - Switch to root
- [ ] `yum update -y` - Update system
- [ ] `mkdir` - Create directory
- [ ] `touch` - Create file
- [ ] `cat` - Display file content
- [ ] `echo` - Print text
- [ ] `uname -a` - System information

### Concepts You Should Understand:
- [ ] Difference between regular user and root
- [ ] Purpose of sudo and when to use it
- [ ] Basic file permissions (rwx)
- [ ] Package management with yum
- [ ] System resource monitoring
- [ ] File system navigation

---

## Troubleshooting Commands Reference:

```bash
# System status
systemctl status service_name
ps aux | grep process_name
netstat -tlnp | grep port_number

# File operations
ls -la /path/to/directory
cat /path/to/file
tail -f /var/log/logfile

# Network
ping hostname
curl http://example.com
ip addr show

# Disk and memory
df -h
free -h
du -sh /path/to/directory
```

---

## Next Steps:
✅ **Section 2 Complete!**

You now have:
- Secure access to your EC2 instance
- Basic Linux command line skills
- Understanding of user privileges
- System administration fundamentals

Proceed to **Section 3: Web Server Setup and HTML Creation** to install Apache and create your first website!

---

## Important Notes:

⚠️ **Security Reminder:** Always log out when finished working
🔧 **Practice:** Try additional Linux commands to build confidence
📚 **Learning:** Explore man pages (`man command_name`) for more details
🔄 **Backup:** Consider creating snapshots of important configurations
