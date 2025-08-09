# Git SSH Connectivity Guide

Simple step-by-step guide for setting up SSH with Git repositories.

## 🔑 **GitHub SSH Setup Steps**

### **Step 1: Generate SSH Key**
```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
```
- Press **Enter** for default location (`~/.ssh/id_ed25519`)
- Press **Enter** for no passphrase (or create one)

### **Step 2: Copy Public Key**
```bash
cat ~/.ssh/id_ed25519.pub
```
**Copy the entire output** (starts with `ssh-ed25519` and ends with your email)

### **Step 3: Add to GitHub**
1. Go to **GitHub.com** → Sign in
2. Click your **profile picture** (top right)
3. Click **Settings**
4. In left sidebar, click **SSH and GPG keys**
5. Click **New SSH key** (green button)
6. **Title**: Give it a name (e.g., "My Laptop")
7. **Key**: **Paste** your copied public key
8. Click **Add SSH key**
9. Enter your GitHub password if prompted

### **Step 4: Test Connection**
```bash
ssh -T git@github.com
```
**Expected output**: `Hi username! You've successfully authenticated, but GitHub does not provide shell access.`

### **Step 5: Use SSH for Git Operations**
```bash
# Clone new repo
git clone git@github.com:username/repository.git

# Change existing repo from HTTPS to SSH
git remote set-url origin git@github.com:username/repository.git
```

## ✅ **That's It!**
Now you can push/pull without entering passwords every time.

## Quick Setup Steps

### Step 1: Generate SSH Key
```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
```
- Press Enter for default location
- Press Enter for no passphrase (or add one for security)

### Step 2: Copy Public Key
```bash
cat ~/.ssh/id_ed25519.pub
```
Copy the entire output.

### Step 3: Add to GitHub
1. Go to GitHub → Settings → SSH and GPG keys
2. Click "New SSH key"
3. Paste your public key
4. Click "Add SSH key"

### Step 4: Test Connection
```bash
ssh -T git@github.com
```
You should see: `Hi username! You've successfully authenticated...`

### Step 5: Clone with SSH
```bash
git clone git@github.com:username/repository.git
```

### Step 6: Change Existing Repo to SSH
```bash
git remote set-url origin git@github.com:username/repository.git
```

## Other Git Platforms

### GitLab
- Add key at: GitLab → Preferences → SSH Keys
- Test: `ssh -T git@gitlab.com`

### Bitbucket  
- Add key at: Bitbucket → Personal settings → SSH keys
- Test: `ssh -T git@bitbucket.org`

## 🔧 **Quick Troubleshoot**
If you get "Permission denied":
```bash
# Check if key exists
ls ~/.ssh/id_ed25519*

# Test with verbose output
ssh -vT git@github.com
```

## Troubleshooting

### Permission Denied?
```bash
# Check if key exists
ls ~/.ssh/

# Regenerate if needed
ssh-keygen -t ed25519 -C "your_email@example.com"
```

### Wrong Key?
```bash
# Use specific key
ssh -i ~/.ssh/id_ed25519 -T git@github.com
```

## File Permissions (if needed)
```bash
chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_ed25519
chmod 644 ~/.ssh/id_ed25519.pub
```
