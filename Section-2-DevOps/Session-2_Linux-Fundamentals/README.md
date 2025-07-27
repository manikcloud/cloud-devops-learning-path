# 🐧 Session 2: Linux Fundamentals
## *Essential Linux Skills for DevOps Professionals*

<div align="center">

![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)
![Shell](https://img.shields.io/badge/Shell-Scripting-green?style=for-the-badge&logo=gnu-bash&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-EC2-orange?style=for-the-badge&logo=amazon-aws&logoColor=white)

**Duration:** 2 Weeks | **Level:** Beginner to Intermediate | **Type:** Hands-on + Theory

</div>

---

## 📋 Presentation Navigation
<div align="center">

| [🎯 Overview](#-slide-1-session-overview) | [📚 Learning Goals](#-slide-2-learning-objectives) | [💻 Operating Systems](#-slide-3-operating-systems-fundamentals) | [🐧 Linux Overview](#-slide-4-linux-operating-system) |
|:---:|:---:|:---:|:---:|
| [📁 File System](#-slide-5-linux-file-system--navigation) | [⚡ Basic Commands](#-slide-6-essential-linux-commands) | [🔧 Advanced Commands](#-slide-7-advanced-linux-commands) | [📝 Text Editors](#-slide-8-text-editors--file-management) |
| [☁️ Cloud Deployment](#-slide-9-linux-on-aws-cloud) | [🔐 SSH & Security](#-slide-10-ssh--secure-access) | [📜 Shell Scripting](#-slide-11-shell-scripting-mastery) | [👥 User Management](#-slide-12-user--system-administration) |
| [🎓 Next Steps](#-slide-13-next-steps--takeaways) | | | |

</div>

---

## 🎯 Slide 1: Session Overview

<div align="center">

### 🌟 **Master Linux for DevOps Excellence**

</div>

> **Mission:** Build essential Linux skills for cloud computing and DevOps automation

### 🎪 **Why Linux Matters for DevOps**
```
🌐 90% of Cloud Infrastructure    📊 95% of Container Platforms    🔧 100% of DevOps Tools
💰 Lower TCO than Windows        🔒 Superior Security Model       🚀 Automation-Friendly
```

### 📅 **Session Structure**
- **Week 1:** Linux Fundamentals & Command Line Mastery
- **Week 2:** Shell Scripting & System Administration

### 🎯 **Target Audience**
- DevOps engineers transitioning to Linux
- System administrators exploring cloud
- Developers needing server-side skills
- IT professionals building automation

---

## 📚 Slide 2: Learning Objectives

<div align="center">

### 🎓 **By the End of This Session, You Will:**

</div>

<table>
<tr>
<td width="50%">

### 🧠 **Core Linux Skills**
- ✅ **Navigate** Linux file systems confidently
- ✅ **Execute** basic and advanced commands
- ✅ **Manage** files, directories, and permissions
- ✅ **Use** text editors (vi/vim) effectively

</td>
<td width="50%">

### 🛠️ **DevOps Applications**
- ✅ **Deploy** Linux instances on AWS cloud
- ✅ **Implement** secure SSH access with keys
- ✅ **Write** shell scripts for automation
- ✅ **Administer** users and system resources

</td>
</tr>
</table>

### 🎯 **Success Metrics**
```
Command Proficiency: 50+ commands | Shell Scripting: 5+ scripts | AWS Deployment: Live instance
```

---

## 💻 Slide 3: Operating Systems Fundamentals

<div align="center">

### 🖥️ **Understanding Operating Systems**

![OS Architecture](../images/os-architecture.svg)

</div>

### 🏗️ **Operating System Functions**

<table>
<tr>
<td width="33%">

### ⚙️ **Process Management**
*Running Programs*
- 🔄 Process scheduling
- 🧵 Thread management
- 💾 Memory allocation
- 🔒 Resource protection

</td>
<td width="33%">

### 📁 **File System**
*Data Organization*
- 🗂️ File storage
- 📂 Directory structure
- 🔐 Access permissions
- 💿 Device management

</td>
<td width="33%">

### 🌐 **Networking**
*System Communication*
- 🔗 Network protocols
- 🛡️ Security layers
- 📡 Remote access
- 🔄 Data transfer

</td>
</tr>
</table>

### 📊 **OS Market Share (Server Environment)**
```
Linux: 96.3% | Windows Server: 1.9% | Unix: 1.8%
```

---

## 🐧 Slide 4: Linux Operating System

<div align="center">

### 🌟 **Linux: The DevOps Foundation**

![Linux Architecture](../images/linux-architecture.svg)

</div>

<table>
<tr>
<td width="50%">

### 🏗️ **Linux Architecture Layers**
- **🖥️ Hardware** - Physical components
- **🔧 Kernel** - Core operating system
- **📚 System Libraries** - Shared functions
- **🐚 Shell** - Command interface
- **📱 Applications** - User programs

### 🎯 **Why Linux for DevOps?**
- 🆓 **Open Source** - Free and customizable
- 🛡️ **Security** - Strong permission model
- ⚡ **Performance** - Efficient resource usage
- 🤖 **Automation** - Script-friendly environment

</td>
<td width="50%">

### 📦 **Popular Linux Distributions**

**🏢 Enterprise:**
- **Red Hat Enterprise Linux** - Commercial support
- **Amazon Linux** - AWS-optimized
- **CentOS** - Community enterprise
- **SUSE Linux** - Enterprise-focused

**👥 Community:**
- **Ubuntu** - User-friendly, popular
- **Debian** - Stable, reliable
- **Fedora** - Cutting-edge features
- **Arch Linux** - Minimalist approach

</td>
</tr>
</table>

### 📈 **Linux Adoption Statistics**
```
Cloud Servers: 90% | Containers: 99% | Supercomputers: 100% | Mobile (Android): 71%
```

---

## 📁 Slide 5: Linux File System & Navigation

<div align="center">

### 🗂️ **Linux File System Hierarchy**

![Linux File System](../images/linux-filesystem.svg)

</div>

<table>
<tr>
<td width="50%">

### 📂 **Key Directories**
- **`/`** - Root directory (everything starts here)
- **`/home`** - User home directories
- **`/etc`** - Configuration files
- **`/var`** - Variable data (logs, databases)
- **`/usr`** - User programs and libraries
- **`/bin`** - Essential user binaries
- **`/sbin`** - System administration binaries
- **`/tmp`** - Temporary files

</td>
<td width="50%">

### 🧭 **Navigation Concepts**
- **Absolute paths** - Start with `/` (e.g., `/home/user/file.txt`)
- **Relative paths** - Relative to current directory
- **Home directory** - `~` represents user's home
- **Parent directory** - `..` goes up one level
- **Current directory** - `.` represents current location
- **Hidden files** - Start with `.` (e.g., `.bashrc`)

**🎯 Hands-on Practice:** [Project-1 File System Lab](./Project-1/#-task-2-file-system-mastery)

</td>
</tr>
</table>

### 💡 **File System Best Practices**
- Use absolute paths in scripts for reliability
- Understand permission inheritance in directories
- Regular cleanup of `/tmp` directory
- Monitor `/var/log` for system health and troubleshooting

---

## ⚡ Slide 6: Essential Linux Commands

<div align="center">

### 🔧 **Command Line Mastery Categories**

</div>

<table>
<tr>
<td width="33%">

### 📁 **File Operations**
**Core Concepts:**
- Creating files and directories
- Copying and moving files
- Viewing file contents
- File permissions management

**Key Commands:**
- `touch`, `mkdir` - Creation
- `cp`, `mv` - Copy/Move
- `cat`, `less`, `head`, `tail` - Viewing
- `chmod`, `chown` - Permissions

</td>
<td width="33%">

### 🔍 **Search & Find**
**Core Concepts:**
- Finding files by name/type/size
- Searching content within files
- Locating system binaries
- Pattern matching with regex

**Key Commands:**
- `find` - Locate files/directories
- `grep` - Search text patterns
- `locate` - Quick file search
- `which`, `whereis` - Find binaries

</td>
<td width="33%">

### 📊 **System Information**
**Core Concepts:**
- Process monitoring
- System resource usage
- Network information
- Service management

**Key Commands:**
- `ps`, `top`, `htop` - Processes
- `df`, `du`, `free` - Resources
- `netstat`, `ss` - Network
- `systemctl` - Services

</td>
</tr>
</table>

### 🎯 **Command Mastery Path**
```
Basic Navigation → File Operations → System Monitoring → Advanced Administration
```

**🛠️ Hands-on Practice:** [Project-1 Command Mastery](./Project-1/#-task-3-command-line-mastery)

---

## 🔧 Slide 7: Advanced Linux Commands

<div align="center">

### 🚀 **System Administration Essentials**

</div>

<table>
<tr>
<td width="50%">

### 📦 **Package Management**
**Concepts:**
- Software installation and removal
- Package dependencies
- System updates and security patches
- Repository management

**Package Managers:**
- **YUM/DNF** - Red Hat/CentOS/Amazon Linux
- **APT** - Ubuntu/Debian
- **Snap** - Universal packages
- **Flatpak** - Sandboxed applications

</td>
<td width="50%">

### ⚙️ **System Services**
**Concepts:**
- Service lifecycle management
- Boot-time service configuration
- Process monitoring and control
- System targets and runlevels

**Service Management:**
- **systemctl** - Modern service control
- **service** - Legacy service control
- **chkconfig** - Boot configuration
- **systemd** - System and service manager

</td>
</tr>
</table>

### 🗜️ **Archive & Compression Concepts**
- **tar** - Tape archive format for bundling files
- **gzip/gunzip** - Compression algorithms
- **zip/unzip** - Cross-platform archive format
- **Backup strategies** - Incremental vs full backups

**🔧 Hands-on Practice:** [Project-1 Advanced Commands](./Project-1/#-task-3-command-line-mastery)

---

## 📝 Slide 8: Text Editors & File Management

<div align="center">

### ✏️ **Text Editor Mastery**

</div>

<table>
<tr>
<td width="50%">

### 🎮 **Vi/Vim Editor Concepts**
**Modal Editing Philosophy:**
- **Normal Mode** - Navigation and commands
- **Insert Mode** - Text editing
- **Visual Mode** - Text selection
- **Command Mode** - File operations

**Why Vim for DevOps:**
- Available on all Linux systems
- Powerful for configuration editing
- Efficient for remote server work
- Extensive customization options

</td>
<td width="50%">

### ⚡ **Editor Alternatives**
**Nano:**
- Beginner-friendly interface
- Simple key combinations
- Good for quick edits

**Emacs:**
- Extensible and customizable
- Built-in features (email, calendar)
- Steep learning curve

**Modern Editors:**
- VS Code with Remote-SSH
- Sublime Text with SFTP
- Atom with remote packages

</td>
</tr>
</table>

### 📋 **File Permission Concepts**
**Permission Model:**
- **Read (r)** - View file contents or list directory
- **Write (w)** - Modify file or create/delete in directory
- **Execute (x)** - Run file or access directory

**Permission Levels:**
- **Owner** - File creator/owner
- **Group** - Users in the same group
- **Others** - All other users

**🎯 Hands-on Practice:** [Project-1 Text Editors Lab](./Project-1/#-task-2-file-system-mastery)

---

## ☁️ Slide 9: Linux on AWS Cloud

<div align="center">

### 🌐 **Cloud Linux Deployment**

![AWS EC2 Linux](../images/aws-ec2-linux.svg)

</div>

<table>
<tr>
<td width="50%">

### 🚀 **EC2 Deployment Concepts**
**Amazon Machine Images (AMI):**
- Pre-configured OS templates
- Amazon Linux 2 - AWS optimized
- Ubuntu Server - Popular choice
- Red Hat Enterprise Linux - Enterprise grade

**Instance Types:**
- **t2.micro** - Burstable performance (Free Tier)
- **t3.small** - Balanced compute
- **m5.large** - General purpose
- **c5.large** - Compute optimized

</td>
<td width="50%">

### 🔒 **Security Best Practices**
**Security Groups:**
- Virtual firewall rules
- Inbound/outbound traffic control
- Port-based access control
- Source IP restrictions

**Key Management:**
- RSA vs ED25519 key types
- Private key security
- Key rotation strategies
- Multi-factor authentication

</td>
</tr>
</table>

### 💰 **Cost Optimization**
- Use appropriate instance sizes
- Stop instances when not needed
- Leverage spot instances for development
- Monitor usage with CloudWatch

**🚀 Hands-on Practice:** [Project-1 AWS Deployment](./Project-1/#️-task-1-aws-linux-deployment)

---

## 🔐 Slide 10: SSH & Secure Access

<div align="center">

### 🛡️ **Secure Shell Mastery**

</div>

<table>
<tr>
<td width="50%">

### 🔑 **SSH Authentication Methods**
**Password Authentication:**
- Simple but less secure
- Vulnerable to brute force
- Not recommended for production

**Key-Based Authentication:**
- Public/private key pairs
- Much more secure
- Industry standard practice
- Supports automation

**Multi-Factor Authentication:**
- Combines multiple methods
- Enhanced security
- Required for compliance

</td>
<td width="50%">

### 📁 **Secure File Transfer Concepts**
**SCP (Secure Copy):**
- Simple file copying
- Uses SSH protocol
- Good for one-time transfers

**SFTP (SSH File Transfer Protocol):**
- Interactive file management
- Directory operations
- Batch file transfers
- Resume capability

**Rsync over SSH:**
- Incremental synchronization
- Bandwidth efficient
- Preserves permissions

</td>
</tr>
</table>

### 🌐 **SSH Tunneling Concepts**
- **Local Port Forwarding** - Access remote services locally
- **Remote Port Forwarding** - Expose local services remotely
- **Dynamic Port Forwarding** - SOCKS proxy functionality
- **Jump Hosts** - Access internal networks securely

**🔐 Hands-on Practice:** [Project-1 SSH Security Lab](./Project-1/#-task-4-ssh--security-setup)

---

## 📜 Slide 11: Shell Scripting Mastery

<div align="center">

### 🤖 **Automation with Shell Scripts**

</div>

<table>
<tr>
<td width="50%">

### 📝 **Scripting Fundamentals**
**Script Structure:**
- Shebang line (`#!/bin/bash`)
- Comments and documentation
- Variable declarations
- Function definitions
- Error handling

**Best Practices:**
- Use meaningful variable names
- Quote variables to prevent issues
- Check command exit codes
- Implement proper error handling
- Add logging and debugging

</td>
<td width="50%">

### 🔄 **Control Structures**
**Conditional Logic:**
- if/elif/else statements
- case statements
- Test conditions and operators

**Loops:**
- for loops for iteration
- while loops for conditions
- until loops for negation

**Functions:**
- Code reusability
- Parameter passing
- Return values
- Local variables

</td>
</tr>
</table>

### 🎯 **Common Automation Tasks**
- **System monitoring** - Resource usage, log analysis
- **Backup automation** - File archiving, rotation
- **User management** - Account creation, permissions
- **Service management** - Health checks, restarts
- **Deployment scripts** - Application updates, configuration

**📜 Hands-on Practice:** [Project-1 Shell Scripting](./Project-1/#-task-5-shell-scripting-automation)

---

## 👥 Slide 12: User & System Administration

<div align="center">

### 🔧 **System Administration Essentials**

</div>

<table>
<tr>
<td width="50%">

### 👤 **User Management Concepts**
**User Account Types:**
- **Regular users** - Standard system access
- **System users** - Service accounts
- **Root user** - Administrative privileges
- **Service accounts** - Application-specific

**Account Management:**
- User creation and deletion
- Password policies
- Account expiration
- Home directory management

</td>
<td width="50%">

### 👥 **Group Management Concepts**
**Group Types:**
- **Primary groups** - Default group membership
- **Secondary groups** - Additional permissions
- **System groups** - Service-related groups
- **Custom groups** - Organization-specific

**Permission Strategy:**
- Principle of least privilege
- Role-based access control
- Group-based permissions
- Regular access reviews

</td>
</tr>
</table>

### 🔐 **Security Administration**
**Access Control:**
- File and directory permissions
- Special permissions (SUID, SGID, Sticky bit)
- Access Control Lists (ACLs)
- SELinux/AppArmor policies

**System Hardening:**
- Disable unnecessary services
- Configure firewalls
- Regular security updates
- Audit logging and monitoring

**👥 Hands-on Practice:** [Project-1 System Administration](./Project-1/#-task-6-system-administration)

---

## 🎓 Slide 13: Next Steps & Takeaways

<div align="center">

### 🌟 **Your Linux Journey Continues**

</div>

<table>
<tr>
<td width="50%">

### 🎯 **Key Takeaways**
1. 🐧 **Linux is Essential** - Foundation for DevOps
2. 📝 **Command Line Power** - Efficiency and automation
3. 🔐 **Security First** - SSH keys and permissions
4. 🤖 **Scripting Skills** - Automate repetitive tasks
5. ☁️ **Cloud Integration** - AWS EC2 deployment
6. 👥 **System Administration** - User and resource management
7. 📚 **Continuous Learning** - Practice makes perfect

</td>
<td width="50%">

### 🛤️ **Learning Path Forward**
- **Next Session:** [Mastering Git](../Session-3_Mastering-Git/)
- **Then:** [Jenkins CI/CD](../Session-4_Jenkins/)
- **Advanced:** [Terraform IaC](../Terraform/)

### 🎯 **Immediate Actions**
- ✅ Complete Linux fundamentals assessment
- 🚀 Launch your first AWS EC2 instance
- 📜 Write your first shell script
- 🔐 Set up SSH key authentication

</td>
</tr>
</table>

---

## 🛠️ Hands-On Activities

<details>
<summary><strong>🔬 Lab 1: Linux System Exploration</strong></summary>

### Objective
Launch and explore a Linux system on AWS EC2

### Tasks
1. **AWS EC2 Setup**
   - Launch Amazon Linux 2 instance
   - Configure security groups
   - Connect via SSH

2. **File System Exploration**
   - Navigate directory hierarchy
   - Understand file permissions
   - Practice basic commands

3. **System Information**
   - Check system resources
   - Monitor processes
   - Explore log files

### Deliverables
- Running EC2 instance
- Command execution screenshots
- System exploration report

</details>

<details>
<summary><strong>⚡ Lab 2: Command Line Mastery</strong></summary>

### Objective
Master essential Linux commands and operations

### Tasks
1. **File Operations**
   - Create, copy, move, delete files
   - Work with directories
   - Manage permissions

2. **Text Processing**
   - Use grep, awk, sed
   - Process log files
   - Search and filter data

3. **System Monitoring**
   - Monitor processes with top/htop
   - Check disk usage
   - Analyze system performance

### Deliverables
- Command reference sheet
- Text processing examples
- System monitoring report

</details>

<details>
<summary><strong>🔐 Lab 3: SSH & Security Configuration</strong></summary>

### Objective
Implement secure remote access and file transfer

### Tasks
1. **SSH Key Setup**
   - Generate SSH key pairs
   - Configure key-based authentication
   - Set up SSH config file

2. **Secure File Transfer**
   - Practice SFTP commands
   - Use SCP for file copying
   - Implement secure workflows

3. **Security Hardening**
   - Configure SSH daemon
   - Set up firewall rules
   - Implement access controls

### Deliverables
- SSH key configuration
- Secure access documentation
- Security checklist

</details>

<details>
<summary><strong>📜 Lab 4: Shell Scripting Project</strong></summary>

### Objective
Create practical automation scripts

### Tasks
1. **System Monitoring Script**
   - Check disk usage
   - Monitor memory and CPU
   - Generate alerts

2. **User Management Script**
   - Automate user creation
   - Set up permissions
   - Generate reports

3. **Backup Automation**
   - Create backup scripts
   - Schedule with cron
   - Implement rotation

### Deliverables
- 3 working shell scripts
- Script documentation
- Automation demonstration

</details>

---

## 📚 Resources & References

<details>
<summary><strong>📖 Essential Reading</strong></summary>

### Books
- 📚 **"The Linux Command Line"** by William Shotts
- 📚 **"Linux Administration: A Beginner's Guide"** by Wale Soyinka
- 📚 **"UNIX and Linux System Administration Handbook"** by Evi Nemeth
- 📚 **"Learning the bash Shell"** by Cameron Newham

### Online Documentation
- 📄 **Linux Documentation Project** - Comprehensive guides
- 📄 **GNU/Linux Command-Line Tools** - Command reference
- 📄 **Bash Guide for Beginners** - Shell scripting basics
- 📄 **Advanced Bash-Scripting Guide** - Advanced techniques

</details>

<details>
<summary><strong>🌐 Online Resources</strong></summary>

### Interactive Learning
- 🌐 [Linux Journey](https://linuxjourney.com/) - Interactive tutorials
- 🌐 [OverTheWire Wargames](https://overthewire.org/wargames/) - Security challenges
- 🌐 [Explainshell](https://explainshell.com/) - Command explanation
- 🌐 [Bash Academy](https://guide.bash.academy/) - Bash scripting guide

### Video Content
- 🎥 **YouTube Channels:** Linux Academy, TechWorld with Nana
- 🎥 **Course Platforms:** Pluralsight, Udemy, Linux Academy
- 🎥 **Conference Talks:** LinuxCon, Open Source Summit

</details>

<details>
<summary><strong>🛠️ Tools & Utilities</strong></summary>

### Essential Tools
- **Terminal Emulators:** iTerm2 (Mac), Windows Terminal, GNOME Terminal
- **SSH Clients:** OpenSSH, PuTTY, MobaXterm
- **Text Editors:** Vim, Nano, Emacs
- **File Managers:** Midnight Commander, Ranger

### Cloud Platforms
- ☁️ **AWS EC2** - Elastic Compute Cloud
- ☁️ **Google Cloud Compute** - Virtual machines
- ☁️ **Azure Virtual Machines** - Cloud computing
- ☁️ **DigitalOcean Droplets** - Simple cloud servers

</details>

---

## 📊 Assessment & Certification

<div align="center">

### 🎯 **Knowledge Validation**

</div>

<table>
<tr>
<td width="50%">

### 📝 **Assessment Methods**
- **Practical Labs:** Command line proficiency (40%)
- **Shell Scripts:** Automation projects (30%)
- **System Admin:** User and permission management (20%)
- **Security:** SSH and access control (10%)

### 🏆 **Passing Criteria**
- Overall score: 80% or higher
- All labs completed successfully
- Working shell scripts demonstrated
- Security best practices implemented

</td>
<td width="50%">

### 🎓 **Certification Preparation**
- **Linux Professional Institute (LPI)** - LPIC-1
- **Red Hat Certified System Administrator** - RHCSA
- **CompTIA Linux+** - Vendor-neutral certification
- **AWS Certified SysOps Administrator** - Cloud focus

### 📈 **Career Benefits**
- Linux skills premium: 15-25% salary increase
- DevOps role preparation
- Cloud platform readiness
- Automation capabilities

</td>
</tr>
</table>

---

<div align="center">

## 🚀 **Ready to Master Linux?**

### *"In the world of DevOps, Linux is not just an option—it's the foundation"*

**Next Session:** [Mastering Git →](../Session-3_Mastering-Git/)

---

**Created by Varun Kumar Manik**  
*AWS Ambassador | Kubernetes Expert | DevOps Specialist*

**Session 2: Linux Fundamentals** | **Section 2: DevOps & Infrastructure as Code**  
*Last Updated: July 2025*

</div>
