# 🚀 Project 1: Git Fundamentals & Team Collaboration
## *Master Version Control Through Hands-On Practice*

<div align="center">

![Git](https://img.shields.io/badge/Git-F05032?style=for-the-badge&logo=git&logoColor=white)
![GitHub](https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white)
![Collaboration](https://img.shields.io/badge/Team_Collaboration-4CAF50?style=for-the-badge&logo=git&logoColor=white)
![Hands-On](https://img.shields.io/badge/Hands--On_Project-FF6B35?style=for-the-badge&logo=terminal&logoColor=white)

**Duration:** 1 Week | **Level:** Beginner to Intermediate | **Type:** Practical Implementation

---

### 📊 **Project Status**
<table>
<tr>
<td align="center" width="20%">
<img src="https://img.shields.io/badge/📅-Active-green?style=for-the-badge" alt="Status"/>
</td>
<td align="center" width="20%">
<img src="https://img.shields.io/badge/🎯-8_Tasks-blue?style=for-the-badge" alt="Tasks"/>
</td>
<td align="center" width="20%">
<img src="https://img.shields.io/badge/⏱️-40_Hours-orange?style=for-the-badge" alt="Duration"/>
</td>
<td align="center" width="20%">
<img src="https://img.shields.io/badge/🏆-Certification-purple?style=for-the-badge" alt="Certification"/>
</td>
<td align="center" width="20%">
<img src="https://img.shields.io/badge/👥-Team_Ready-success?style=for-the-badge" alt="Team"/>
</td>
</tr>
</table>

<img src="./images/git-fundamentals-workflow.svg" alt="Git Fundamentals Workflow" width="700"/>

</div>

---

## 🎯 Project Overview

<div align="center">

> **Mission:** Master Git version control through comprehensive hands-on practice, from basic repository operations to advanced team collaboration workflows.

</div>

This project provides a complete practical journey through Git fundamentals, designed to transform you from a Git beginner to a confident version control practitioner. You'll work with real repositories, simulate team collaboration scenarios, and master the essential Git skills needed in professional development environments.

### 🌟 **What Makes This Project Special**

<table>
<tr>
<td align="center" width="25%">
<strong>🎓 Progressive Learning</strong><br/>
Start with basics, advance to complex scenarios
</td>
<td align="center" width="25%">
<strong>🔄 Real-World Scenarios</strong><br/>
Simulate actual development workflows
</td>
<td align="center" width="25%">
<strong>🤝 Team Collaboration</strong><br/>
Practice multi-developer workflows
</td>
<td align="center" width="25%">
<strong>🛠️ Practical Skills</strong><br/>
Build immediately applicable expertise
</td>
</tr>
</table>

---

## 📋 Learning Objectives

<div align="center">

### 🎓 **By Completing This Project, You Will:**

<table>
<tr>
<td align="center" width="50%">

### 🧠 **Core Git Mastery**
- ✅ **Install and configure** Git for professional use
- ✅ **Create and manage** repositories effectively
- ✅ **Master staging and committing** with best practices
- ✅ **Navigate Git history** and understand commit graphs

</td>
<td align="center" width="50%">

### 🌿 **Advanced Operations**
- ✅ **Implement branching strategies** (GitFlow, Feature branches)
- ✅ **Resolve merge conflicts** confidently
- ✅ **Use rebase operations** for clean history
- ✅ **Manage remote repositories** and team workflows

</td>
</tr>
</table>

### 🎯 **Success Metrics**

<table>
<tr>
<td align="center" width="25%">**Git Commands:** 25+ mastered</td>
<td align="center" width="25%">**Workflows:** 3 strategies implemented</td>
<td align="center" width="25%">**Conflicts:** 5+ resolved successfully</td>
<td align="center" width="25%">**Team Skills:** Collaboration ready</td>
</tr>
</table>

</div>

---

## 📚 Project Navigation

<div align="center">

| [🔧 Setup](#-task-1-git-setup--configuration) | [📁 Repository](#-task-2-repository-creation--management) | [🌿 Branching](#-task-3-branching-strategies) | [🔀 Merging](#-task-4-merge-operations--conflict-resolution) |
|:---:|:---:|:---:|:---:|
| [🔄 Rebase](#-task-5-rebase--history-management) | [📤 Stashing](#-task-6-stashing--temporary-changes) | [🌐 Remote](#-task-7-remote-repositories) | [🤝 Collaboration](#-task-8-team-collaboration-workflows) |

</div>

---
<details>
<summary><h2>🔧 Task 1: Git Setup & Configuration</h2></summary>

<div align="center">

### 🎯 **Objective:** Install Git and configure it for professional development

</div>

### 📋 **Task Overview**
Set up Git on your system with proper configuration for professional development work. This includes installation, global configuration, and understanding Git's internal structure.

### 🛠️ **Implementation Steps**

#### 1.1 Git Installation

<details>
<summary><strong>📦 Installation Commands</strong></summary>

```bash
# Amazon Linux / CentOS / RHEL
sudo yum update -y
sudo yum install git -y

# Ubuntu / Debian
sudo apt update
sudo apt install git -y

# macOS (using Homebrew)
brew install git

# Windows (using Chocolatey)
choco install git

# Verify installation
git --version
```

</details>

#### 1.2 Global Configuration

<details>
<summary><strong>⚙️ Configuration Setup</strong></summary>

```bash
# Essential configuration
git config --global user.name "Your Full Name"
git config --global user.email "your.email@company.com"
git config --global init.defaultBranch main

# Enhanced configuration for productivity
git config --global core.editor "code --wait"  # VS Code
git config --global merge.tool vimdiff
git config --global color.ui auto
git config --global push.default simple
git config --global pull.rebase false

# Useful aliases
git config --global alias.st status
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.unstage 'reset HEAD --'
git config --global alias.last 'log -1 HEAD'
git config --global alias.visual '!gitk'

# View all configuration
git config --list
git config --global --list
```

</details>

#### 1.3 Understanding Git Structure

<details>
<summary><strong>🏗️ Git Architecture Exploration</strong></summary>

```bash
# Create a test directory
mkdir ~/git-learning-lab
cd ~/git-learning-lab

# Initialize repository
git init

# Explore .git directory structure
ls -la .git/
tree .git/ || find .git/ -type f | head -15

# Understanding key directories
echo "Exploring Git internals:"
echo "- .git/objects/: Git object database"
echo "- .git/refs/: References (branches, tags)"
echo "- .git/HEAD: Current branch pointer"
echo "- .git/config: Repository-specific config"
echo "- .git/hooks/: Git hooks for automation"
```

</details>

### ✅ **Completion Checklist**
- [ ] Git installed and version verified
- [ ] Global user configuration set
- [ ] Editor and merge tool configured
- [ ] Useful aliases created
- [ ] Git directory structure understood

---

</details>

<details>
<summary><h2>📁 Task 2: Repository Creation & Management</h2></summary>

<div align="center">

### 🎯 **Objective:** Master repository initialization, file tracking, and commit operations

</div>

### 📋 **Task Overview**
Learn to create repositories, understand the three-tree architecture, and master the fundamental Git workflow of staging and committing changes.

### 🛠️ **Implementation Steps**

#### 2.1 Repository Initialization

<details>
<summary><strong>🚀 Creating Your First Repository</strong></summary>

```bash
# Create project directory
mkdir ~/git-fundamentals-project
cd ~/git-fundamentals-project

# Initialize Git repository
git init

# Check repository status
git status

# Create initial project structure
mkdir -p {src,docs,tests,config,scripts}
echo "# Git Fundamentals Project" > README.md
echo "A comprehensive project to master Git fundamentals" >> README.md
echo "" >> README.md
echo "## Project Structure" >> README.md
echo "- src/: Source code files" >> README.md
echo "- docs/: Documentation" >> README.md
echo "- tests/: Test files" >> README.md
echo "- config/: Configuration files" >> README.md
echo "- scripts/: Utility scripts" >> README.md

# Create sample files
echo "print('Hello, Git World!')" > src/main.py
echo "def test_main(): pass" > tests/test_main.py
echo "# Project Documentation" > docs/README.md
echo "app.debug = True" > config/settings.py
echo "#!/bin/bash\necho 'Build script'" > scripts/build.sh
chmod +x scripts/build.sh
```

</details>

#### 2.2 Understanding Git States

<details>
<summary><strong>📊 Three-Tree Architecture Practice</strong></summary>

```bash
# Check current status
git status

# Understand file states
echo "=== Git File States ==="
echo "1. Untracked: New files Git doesn't know about"
echo "2. Modified: Changed files in working directory"
echo "3. Staged: Files ready for commit"
echo "4. Committed: Files saved in Git history"

# Stage files individually
git add README.md
git status

# Stage multiple files
git add src/main.py tests/test_main.py
git status

# Stage all files
git add .
git status

# Unstage a file
git reset HEAD config/settings.py
git status

# Stage it back
git add config/settings.py
git status
```

</details>

#### 2.3 Commit Operations

<details>
<summary><strong>💾 Creating Meaningful Commits</strong></summary>

```bash
# First commit
git commit -m "Initial commit: Add project structure and core files

- Add README with project description
- Create source code structure (src/, tests/, docs/)
- Add sample Python files and configuration
- Include build script for automation"

# Check commit history
git log
git log --oneline
git log --graph --oneline --all

# Make additional changes
echo "# Installation Guide" > docs/INSTALL.md
echo "pip install -r requirements.txt" >> docs/INSTALL.md
echo "requests==2.28.1" > requirements.txt

# Stage and commit with different methods
git add docs/INSTALL.md
git commit -m "docs: Add installation guide"

# Commit with automatic staging of modified files
echo "flask==2.3.2" >> requirements.txt
git commit -am "deps: Add Flask dependency to requirements"

# View detailed commit information
git show HEAD
git show HEAD~1
git show --stat HEAD
```

</details>

#### 2.4 Working Directory Operations

<details>
<summary><strong>🔍 File Management and Status</strong></summary>

```bash
# Create and modify files
echo "# API Documentation" > docs/API.md
echo "import requests" >> src/main.py
echo "# TODO: Add error handling" >> src/main.py

# Check detailed status
git status
git status --short
git status --porcelain

# View differences
git diff                    # Working directory vs staging
git diff --staged          # Staging vs last commit
git diff HEAD              # Working directory vs last commit

# Add and check differences
git add docs/API.md
git diff --staged

# Commit changes
git add src/main.py
git commit -m "feat: Add API documentation and enhance main.py

- Add API documentation template
- Import requests library in main.py
- Add TODO for error handling"

# View commit history with details
git log --stat
git log --patch -2
git log --graph --pretty=format:'%h -%d %s (%cr) <%an>' --abbrev-commit
```

</details>

### ✅ **Completion Checklist**
- [ ] Repository initialized successfully
- [ ] Project structure created
- [ ] File staging operations mastered
- [ ] Multiple commits created with good messages
- [ ] Git status and diff commands understood
- [ ] Commit history navigation practiced

---

</details>
