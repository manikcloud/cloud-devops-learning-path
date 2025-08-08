# Git SSH Connectivity Guide

This guide provides step-by-step instructions for setting up SSH connectivity with Git repositories for secure pull and push operations.

## Table of Contents
- [Prerequisites](#prerequisites)
- [Step 1: Generate SSH Key Pair](#step-1-generate-ssh-key-pair)
- [Step 2: Add SSH Key to SSH Agent](#step-2-add-ssh-key-to-ssh-agent)
- [Step 3: Add SSH Key to Git Platform](#step-3-add-ssh-key-to-git-platform)
- [Step 4: Configure Git](#step-4-configure-git)
- [Step 5: Test SSH Connection](#step-5-test-ssh-connection)
- [Step 6: Clone Repository with SSH](#step-6-clone-repository-with-ssh)
- [Step 7: Push and Pull Operations](#step-7-push-and-pull-operations)
- [Troubleshooting](#troubleshooting)
- [Security Best Practices](#security-best-practices)

## Prerequisites

- Git installed on your system
- Access to terminal/command line
- Account on Git platform (GitHub, GitLab, Bitbucket, etc.)

## Step 1: Generate SSH Key Pair

### 1.1 Check for Existing SSH Keys
```bash
ls -la ~/.ssh
```

Look for files like:
- `id_rsa` and `id_rsa.pub` (RSA keys)
- `id_ed25519` and `id_ed25519.pub` (Ed25519 keys)

### 1.2 Generate New SSH Key (if needed)

**Option A: Ed25519 Key (Recommended)**
```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
```

**Option B: RSA Key (Legacy)**
```bash
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```

### 1.3 Key Generation Process
1. **Save location**: Press Enter to use default location (`~/.ssh/id_ed25519`)
2. **Passphrase**: Enter a secure passphrase (recommended) or press Enter for no passphrase
3. **Confirm passphrase**: Re-enter the passphrase

### 1.4 Verify Key Generation
```bash
ls -la ~/.ssh/
cat ~/.ssh/id_ed25519.pub  # Display public key
```

## Step 2: Add SSH Key to SSH Agent

### 2.1 Start SSH Agent
```bash
eval "$(ssh-agent -s)"
```

### 2.2 Add SSH Key to Agent
```bash
ssh-add ~/.ssh/id_ed25519
```

### 2.3 Verify Key is Added
```bash
ssh-add -l
```

## Step 3: Add SSH Key to Git Platform

### 3.1 Copy Public Key to Clipboard

**Linux:**
```bash
cat ~/.ssh/id_ed25519.pub | xclip -selection clipboard
```

**macOS:**
```bash
pbcopy < ~/.ssh/id_ed25519.pub
```

**Manual Copy:**
```bash
cat ~/.ssh/id_ed25519.pub
# Copy the output manually
```

### 3.2 Add Key to GitHub
1. Go to GitHub → Settings → SSH and GPG keys
2. Click "New SSH key"
3. Title: Give it a descriptive name (e.g., "My Laptop")
4. Key: Paste your public key
5. Click "Add SSH key"

### 3.3 Add Key to GitLab
1. Go to GitLab → Preferences → SSH Keys
2. Paste your public key in the "Key" field
3. Title: Give it a descriptive name
4. Click "Add key"

### 3.4 Add Key to Bitbucket
1. Go to Bitbucket → Personal settings → SSH keys
2. Click "Add key"
3. Label: Give it a descriptive name
4. Key: Paste your public key
5. Click "Add key"

## Step 4: Configure Git

### 4.1 Set Global Git Configuration
```bash
git config --global user.name "Your Name"
git config --global user.email "your_email@example.com"
```

### 4.2 Configure SSH for Git (Optional)
Create or edit `~/.ssh/config`:
```bash
nano ~/.ssh/config
```

Add configuration:
```
# GitHub
Host github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_ed25519

# GitLab
Host gitlab.com
    HostName gitlab.com
    User git
    IdentityFile ~/.ssh/id_ed25519

# Custom Git Server
Host myserver.com
    HostName myserver.com
    User git
    Port 22
    IdentityFile ~/.ssh/id_ed25519
```

## Step 5: Test SSH Connection

### 5.1 Test GitHub Connection
```bash
ssh -T git@github.com
```
Expected output: `Hi username! You've successfully authenticated...`

### 5.2 Test GitLab Connection
```bash
ssh -T git@gitlab.com
```
Expected output: `Welcome to GitLab, @username!`

### 5.3 Test Bitbucket Connection
```bash
ssh -T git@bitbucket.org
```
Expected output: `authenticated via ssh key.`

## Step 6: Clone Repository with SSH

### 6.1 Get SSH Clone URL
- GitHub: `git@github.com:username/repository.git`
- GitLab: `git@gitlab.com:username/repository.git`
- Bitbucket: `git@bitbucket.org:username/repository.git`

### 6.2 Clone Repository
```bash
git clone git@github.com:username/repository.git
cd repository
```

## Step 7: Push and Pull Operations

### 7.1 Basic Git Operations
```bash
# Check remote URLs
git remote -v

# Pull latest changes
git pull origin main

# Make changes and commit
echo "New content" >> file.txt
git add .
git commit -m "Add new content"

# Push changes
git push origin main
```

### 7.2 Change Remote URL from HTTPS to SSH
```bash
# Check current remote
git remote -v

# Change to SSH
git remote set-url origin git@github.com:username/repository.git

# Verify change
git remote -v
```

## Troubleshooting

### Common Issues and Solutions

#### 1. Permission Denied (publickey)
```bash
# Check SSH agent
ssh-add -l

# Add key if not listed
ssh-add ~/.ssh/id_ed25519

# Test connection with verbose output
ssh -vT git@github.com
```

#### 2. SSH Key Not Found
```bash
# Verify key exists
ls -la ~/.ssh/

# Check key permissions
chmod 600 ~/.ssh/id_ed25519
chmod 644 ~/.ssh/id_ed25519.pub
```

#### 3. Wrong SSH Key Being Used
```bash
# Specify key explicitly
ssh -i ~/.ssh/id_ed25519 -T git@github.com

# Or update ~/.ssh/config with correct IdentityFile
```

#### 4. SSH Agent Not Running
```bash
# Start SSH agent
eval "$(ssh-agent -s)"

# Add key
ssh-add ~/.ssh/id_ed25519
```

#### 5. Firewall/Network Issues
```bash
# Test SSH on different port (if available)
ssh -T -p 443 git@ssh.github.com

# Test HTTPS connectivity
curl -I https://github.com
```

### Debug Commands
```bash
# Verbose SSH connection
ssh -vvv git@github.com

# Check SSH configuration
ssh -F ~/.ssh/config -T git@github.com

# List SSH agent keys
ssh-add -L

# Remove all keys from agent
ssh-add -D
```

## Security Best Practices

### 1. SSH Key Security
- **Use strong passphrases** for SSH keys
- **Use Ed25519 keys** instead of RSA when possible
- **Rotate keys regularly** (annually or bi-annually)
- **Use different keys** for different services/environments

### 2. SSH Agent Security
```bash
# Set SSH agent timeout (in seconds)
ssh-add -t 3600 ~/.ssh/id_ed25519  # 1 hour timeout

# Lock SSH agent
ssh-add -x

# Unlock SSH agent
ssh-add -X
```

### 3. File Permissions
```bash
# Secure SSH directory
chmod 700 ~/.ssh

# Secure private key
chmod 600 ~/.ssh/id_ed25519

# Secure public key
chmod 644 ~/.ssh/id_ed25519.pub

# Secure config file
chmod 600 ~/.ssh/config
```

### 4. Key Management
```bash
# List all SSH keys
find ~/.ssh -name "*.pub" -exec basename {} .pub \;

# Remove old/unused keys from platforms
# Regularly audit SSH keys in your Git platform settings
```

### 5. Monitoring and Auditing
- **Monitor SSH key usage** in your Git platform
- **Review authorized keys** regularly
- **Enable two-factor authentication** on Git platforms
- **Use signed commits** for additional security

## Advanced Configuration

### Multiple SSH Keys for Different Accounts
```bash
# ~/.ssh/config
Host github-work
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_work

Host github-personal
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_personal
```

Usage:
```bash
# Clone with specific key
git clone git@github-work:company/repo.git
git clone git@github-personal:username/repo.git
```

### SSH Key with Custom Port
```bash
# ~/.ssh/config
Host custom-git
    HostName git.company.com
    User git
    Port 2222
    IdentityFile ~/.ssh/id_company
```

### Conditional Git Configuration
```bash
# ~/.gitconfig
[includeIf "gitdir:~/work/"]
    path = ~/.gitconfig-work
[includeIf "gitdir:~/personal/"]
    path = ~/.gitconfig-personal
```

## Useful Commands Reference

```bash
# SSH Key Management
ssh-keygen -t ed25519 -C "email@example.com"  # Generate key
ssh-add ~/.ssh/id_ed25519                      # Add to agent
ssh-add -l                                     # List agent keys
ssh-add -D                                     # Remove all keys

# Connection Testing
ssh -T git@github.com                          # Test GitHub
ssh -T git@gitlab.com                          # Test GitLab
ssh -vT git@github.com                         # Verbose test

# Git Remote Management
git remote -v                                  # Show remotes
git remote set-url origin git@github.com:user/repo.git  # Change to SSH
git clone git@github.com:user/repo.git        # Clone with SSH

# File Permissions
chmod 700 ~/.ssh                               # SSH directory
chmod 600 ~/.ssh/id_ed25519                    # Private key
chmod 644 ~/.ssh/id_ed25519.pub                # Public key
```

## Conclusion

Following this guide ensures secure and efficient Git operations using SSH. Remember to:
- Keep your SSH keys secure and use passphrases
- Regularly rotate your keys
- Monitor key usage on your Git platforms
- Use appropriate file permissions
- Test connections after setup

For additional help, consult your Git platform's documentation or reach out to your system administrator.
