# Project 1: Git Version Control & Collaboration Workflow

## 🎯 Project Overview

This comprehensive hands-on project covers the complete Git mastery syllabus through practical implementation. You'll create repositories, implement branching strategies, resolve conflicts, work with remote repositories, and set up GitLab CI/CD pipelines.

## 📋 Project Objectives

By completing this project, you will:
- ✅ **Master Git fundamentals** and version control concepts
- ✅ **Create and manage repositories** effectively
- ✅ **Implement branching strategies** and workflows
- ✅ **Resolve merge conflicts** and fix common mistakes
- ✅ **Work with remote repositories** and collaboration
- ✅ **Use Git rebase** and advanced operations
- ✅ **Set up GitLab CI/CD** pipelines
- ✅ **Implement merge request workflows**

## 🛠️ Project Tasks

### Task 1: Introduction to Source Code Control Systems

#### 1.1 Git Installation and Configuration
```bash
# Install Git (if not already installed)
# On Amazon Linux
sudo yum install git -y

# On Ubuntu/Debian
sudo apt update && sudo apt install git -y

# Verify installation
git --version

# Global configuration
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
git config --global init.defaultBranch main

# Additional useful configurations
git config --global core.editor vim
git config --global merge.tool vimdiff
git config --global color.ui auto

# View configuration
git config --list
```

#### 1.2 Understanding Version Control Concepts
```bash
# Create demonstration directory
mkdir ~/git-learning-project
cd ~/git-learning-project

# Create a simple project structure
mkdir -p {src,docs,tests,config}
echo "# Git Learning Project" > README.md
echo "print('Hello, Git!')" > src/main.py
echo "# Documentation" > docs/README.md
echo "# Configuration files" > config/app.conf
```

### Task 2: Creating/Cloning/Committing a New Repo

#### 2.1 Repository Initialization
```bash
# Initialize Git repository
git init

# Check repository status
git status

# View hidden .git directory
ls -la .git/

# Understand Git directory structure
tree .git/ || find .git/ -type f | head -10
```

#### 2.2 First Commits and History
```bash
# Stage files for commit
git add README.md
git status

# First commit
git commit -m "Initial commit: Add README"

# Add more files
git add src/main.py docs/README.md config/app.conf
git commit -m "Add project structure with source, docs, and config"

# View commit history
git log
git log --oneline
git log --graph --oneline --all

# View specific commit details
git show HEAD
git show HEAD~1
```

#### 2.3 Working with Staging Area
```bash
# Modify multiple files
echo "## Project Description" >> README.md
echo "def greet(name): return f'Hello, {name}!'" >> src/main.py
echo "server.port=8080" >> config/app.conf

# Check differences
git diff
git diff --staged

# Stage files selectively
git add README.md
git status

# Stage parts of a file
git add -p src/main.py

# Commit staged changes
git commit -m "Update README and add greeting function"

# Stage and commit remaining changes
git add .
git commit -m "Add server configuration"
```

### Task 3: Cloning Existing Repository

#### 3.1 Clone from Remote Repository
```bash
# Clone a public repository for practice
cd ~/
git clone https://github.com/octocat/Hello-World.git
cd Hello-World

# Examine cloned repository
git log --oneline
git remote -v
git branch -a

# Create your own repository to clone
cd ~/git-learning-project
```

#### 3.2 Working with Remote Origins
```bash
# Add remote origin (you'll need to create a repository on GitHub/GitLab first)
git remote add origin https://github.com/yourusername/git-learning-project.git

# Verify remote
git remote -v

# Push to remote repository
git push -u origin main

# Check remote branches
git branch -r
```

### Task 4: Branching & Merging in Git

#### 4.1 Basic Branching Operations
```bash
# List branches
git branch

# Create new branch
git branch feature/user-authentication
git branch feature/database-setup
git branch bugfix/login-issue

# List all branches
git branch -a

# Switch to branch
git checkout feature/user-authentication

# Create and switch in one command
git checkout -b feature/api-endpoints

# Modern Git syntax (Git 2.23+)
git switch main
git switch -c feature/payment-system
```

#### 4.2 Branch Development Workflow
```bash
# Switch to feature branch
git switch feature/user-authentication

# Create authentication module
mkdir -p src/auth
cat > src/auth/login.py << 'EOF'
class AuthenticationSystem:
    def __init__(self):
        self.users = {}
    
    def register_user(self, username, password):
        if username in self.users:
            return False
        self.users[username] = password
        return True
    
    def authenticate(self, username, password):
        return self.users.get(username) == password
    
    def get_user_count(self):
        return len(self.users)
EOF

# Add and commit changes
git add src/auth/
git commit -m "Add user authentication system"

# Add tests for authentication
mkdir -p tests
cat > tests/test_auth.py << 'EOF'
import sys
import os
sys.path.append(os.path.join(os.path.dirname(__file__), '..', 'src'))

from auth.login import AuthenticationSystem

def test_user_registration():
    auth = AuthenticationSystem()
    assert auth.register_user("john", "password123") == True
    assert auth.register_user("john", "password456") == False  # Duplicate user

def test_user_authentication():
    auth = AuthenticationSystem()
    auth.register_user("alice", "secret")
    assert auth.authenticate("alice", "secret") == True
    assert auth.authenticate("alice", "wrong") == False

if __name__ == "__main__":
    test_user_registration()
    test_user_authentication()
    print("All tests passed!")
EOF

git add tests/
git commit -m "Add authentication tests"
```

#### 4.3 Merging Strategies
```bash
# Switch back to main branch
git switch main

# Fast-forward merge
git merge feature/user-authentication

# Check merge result
git log --oneline --graph

# Create another feature branch for merge commit example
git switch -c feature/database-setup

# Add database module
mkdir -p src/database
cat > src/database/db.py << 'EOF'
import json
import os

class SimpleDatabase:
    def __init__(self, filename="data.json"):
        self.filename = filename
        self.data = self.load_data()
    
    def load_data(self):
        if os.path.exists(self.filename):
            with open(self.filename, 'r') as f:
                return json.load(f)
        return {}
    
    def save_data(self):
        with open(self.filename, 'w') as f:
            json.dump(self.data, f, indent=2)
    
    def set(self, key, value):
        self.data[key] = value
        self.save_data()
    
    def get(self, key):
        return self.data.get(key)
    
    def delete(self, key):
        if key in self.data:
            del self.data[key]
            self.save_data()
            return True
        return False
EOF

git add src/database/
git commit -m "Add simple database module"

# Meanwhile, make changes to main branch
git switch main
echo "## Installation Instructions" >> README.md
echo "pip install -r requirements.txt" >> README.md
git add README.md
git commit -m "Add installation instructions to README"

# Now merge with no-fast-forward to create merge commit
git merge --no-ff feature/database-setup -m "Merge database feature into main"

# View merge history
git log --oneline --graph
```

### Task 5: Fix Merge Conflicts and Mistakes

#### 5.1 Creating and Resolving Merge Conflicts
```bash
# Create two branches that will conflict
git switch -c feature/config-update
echo "# Application Configuration" > config/app.conf
echo "server.port=3000" >> config/app.conf
echo "database.host=localhost" >> config/app.conf
echo "database.port=5432" >> config/app.conf
git add config/app.conf
git commit -m "Update application configuration for development"

# Switch to main and make conflicting changes
git switch main
echo "# Production Configuration" > config/app.conf
echo "server.port=8080" >> config/app.conf
echo "database.host=prod-db.example.com" >> config/app.conf
echo "database.port=5432" >> config/app.conf
git add config/app.conf
git commit -m "Update configuration for production"

# Attempt merge (this will create conflict)
git merge feature/config-update
```

#### 5.2 Conflict Resolution Process
```bash
# Check conflict status
git status

# View conflicted file
cat config/app.conf

# Resolve conflict manually
cat > config/app.conf << 'EOF'
# Application Configuration
# Supports both development and production environments

server.port=8080
database.host=localhost
database.port=5432

# Environment-specific overrides
# Development: server.port=3000
# Production: database.host=prod-db.example.com
EOF

# Stage resolved file
git add config/app.conf

# Complete merge
git commit -m "Resolve configuration conflict: merge dev and prod settings"

# View merge result
git log --oneline --graph -5
```

#### 5.3 Fixing Common Mistakes
```bash
# Undo last commit (keep changes)
git reset --soft HEAD~1
git status

# Recommit with better message
git commit -m "Merge feature/config-update: Resolve configuration conflicts between dev and prod environments"

# Undo changes to a specific file
echo "Wrong content" > src/main.py
git checkout HEAD -- src/main.py
cat src/main.py

# Amend last commit
echo "# Additional notes" >> README.md
git add README.md
git commit --amend -m "Merge feature/config-update: Resolve configuration conflicts and update README"

# Revert a commit (safe for shared history)
git revert HEAD --no-edit
git log --oneline -3
```

### Task 6: Remote and Rebase Operations

#### 6.1 Working with Remote Repositories
```bash
# Add multiple remotes
git remote add upstream https://github.com/original/repo.git
git remote add backup https://github.com/backup/repo.git

# List remotes
git remote -v

# Fetch from remote
git fetch origin
git fetch --all

# View remote branches
git branch -r

# Track remote branch
git switch -c feature/remote-work origin/main
```

#### 6.2 Git Rebase Operations
```bash
# Create feature branch for rebase practice
git switch main
git switch -c feature/rebase-practice

# Make several commits
echo "Feature work 1" >> src/feature.py
git add src/feature.py
git commit -m "Add feature work part 1"

echo "Feature work 2" >> src/feature.py
git add src/feature.py
git commit -m "Add feature work part 2"

echo "Feature work 3" >> src/feature.py
git add src/feature.py
git commit -m "Add feature work part 3"

# Interactive rebase to clean up history
git rebase -i HEAD~3
```

#### 6.3 Rebase vs Merge Comparison
```bash
# Create branch for merge example
git switch main
git switch -c feature/merge-example
echo "Merge feature content" > merge-feature.txt
git add merge-feature.txt
git commit -m "Add merge feature"

# Create branch for rebase example
git switch main
git switch -c feature/rebase-example
echo "Rebase feature content" > rebase-feature.txt
git add rebase-feature.txt
git commit -m "Add rebase feature"

# Merge example
git switch main
git merge feature/merge-example

# Rebase example
git rebase main feature/rebase-example
git switch main
git merge feature/rebase-example

# Compare history
git log --oneline --graph -10
```

### Task 7: GitLab CI/CD Implementation

#### 7.1 GitLab Repository Setup
```bash
# Create .gitlab-ci.yml file
cat > .gitlab-ci.yml << 'EOF'
# GitLab CI/CD Pipeline Configuration

stages:
  - validate
  - test
  - build
  - deploy

variables:
  PYTHON_VERSION: "3.9"

# Validate code style and syntax
validate:
  stage: validate
  image: python:$PYTHON_VERSION
  script:
    - pip install flake8
    - flake8 src/ --max-line-length=88 --ignore=E203,W503
  only:
    - merge_requests
    - main

# Run unit tests
test:
  stage: test
  image: python:$PYTHON_VERSION
  script:
    - pip install pytest pytest-cov
    - python -m pytest tests/ --cov=src/ --cov-report=xml
  artifacts:
    reports:
      coverage_report:
        coverage_format: cobertura
        path: coverage.xml
  only:
    - merge_requests
    - main

# Build application
build:
  stage: build
  image: python:$PYTHON_VERSION
  script:
    - echo "Building application..."
    - mkdir -p dist/
    - cp -r src/ dist/
    - cp -r config/ dist/
    - echo "Build completed successfully"
  artifacts:
    paths:
      - dist/
    expire_in: 1 hour
  only:
    - main

# Deploy to staging
deploy_staging:
  stage: deploy
  image: alpine:latest
  script:
    - echo "Deploying to staging environment..."
    - echo "Application deployed to staging"
  environment:
    name: staging
    url: https://staging.example.com
  only:
    - main

# Deploy to production (manual)
deploy_production:
  stage: deploy
  image: alpine:latest
  script:
    - echo "Deploying to production environment..."
    - echo "Application deployed to production"
  environment:
    name: production
    url: https://production.example.com
  when: manual
  only:
    - main
EOF

git add .gitlab-ci.yml
git commit -m "Add GitLab CI/CD pipeline configuration"
```

#### 7.2 GitLab Workflow Implementation
```bash
# Create feature branch following GitLab Flow
git switch -c feature/gitlab-integration

# Add GitLab-specific files
mkdir -p .gitlab/issue_templates
cat > .gitlab/issue_templates/Bug.md << 'EOF'
## Bug Report

### Description
A clear and concise description of what the bug is.

### Steps to Reproduce
1. Go to '...'
2. Click on '....'
3. Scroll down to '....'
4. See error

### Expected Behavior
A clear and concise description of what you expected to happen.

### Screenshots
If applicable, add screenshots to help explain your problem.

### Environment
- OS: [e.g. iOS]
- Browser [e.g. chrome, safari]
- Version [e.g. 22]
EOF

mkdir -p .gitlab/merge_request_templates
cat > .gitlab/merge_request_templates/Default.md << 'EOF'
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Testing
- [ ] Unit tests pass
- [ ] Integration tests pass
- [ ] Manual testing completed

## Checklist
- [ ] Code follows style guidelines
- [ ] Self-review completed
- [ ] Documentation updated
- [ ] No new warnings introduced
EOF

git add .gitlab/
git commit -m "Add GitLab issue and MR templates"
```

### Task 8: Merge Requests/Pull Requests Workflow

#### 8.1 Branch Strategy Implementation
```bash
# Implement GitLab Flow branch strategy
git switch main

# Create development branch
git switch -c develop
git push -u origin develop

# Create feature branch from develop
git switch -c feature/user-profile
echo "User profile functionality" > src/profile.py
git add src/profile.py
git commit -m "Add user profile module"

# Add comprehensive tests
cat > tests/test_profile.py << 'EOF'
import sys
import os
sys.path.append(os.path.join(os.path.dirname(__file__), '..', 'src'))

def test_profile_creation():
    # Test profile creation functionality
    assert True  # Placeholder test

def test_profile_update():
    # Test profile update functionality
    assert True  # Placeholder test

if __name__ == "__main__":
    test_profile_creation()
    test_profile_update()
    print("Profile tests passed!")
EOF

git add tests/test_profile.py
git commit -m "Add comprehensive tests for user profile module"

# Push feature branch
git push -u origin feature/user-profile
```

#### 8.2 Merge Request Process
```bash
# Create merge request preparation
echo "## User Profile Feature" >> README.md
echo "" >> README.md
echo "This feature adds user profile management capabilities:" >> README.md
echo "- Create user profiles" >> README.md
echo "- Update profile information" >> README.md
echo "- Validate profile data" >> README.md

git add README.md
git commit -m "Update README with user profile feature documentation"

# Push changes
git push origin feature/user-profile

# Create release branch
git switch develop
git switch -c release/v1.0.0

# Prepare release
echo "version = '1.0.0'" > src/version.py
git add src/version.py
git commit -m "Bump version to 1.0.0"

# Create changelog
cat > CHANGELOG.md << 'EOF'
# Changelog

## [1.0.0] - 2024-01-15

### Added
- User authentication system
- Simple database module
- User profile management
- Comprehensive test suite
- GitLab CI/CD pipeline

### Changed
- Updated configuration system
- Improved error handling

### Fixed
- Configuration conflicts between environments
EOF

git add CHANGELOG.md
git commit -m "Add changelog for version 1.0.0"
```

### Task 9: Advanced Git Operations

#### 9.1 Git Hooks Implementation
```bash
# Create pre-commit hook
mkdir -p .git/hooks
cat > .git/hooks/pre-commit << 'EOF'
#!/bin/bash
# Pre-commit hook to run tests

echo "Running pre-commit checks..."

# Run Python syntax check
python -m py_compile src/*.py
if [ $? -ne 0 ]; then
    echo "Python syntax errors found. Commit aborted."
    exit 1
fi

# Run tests
python -m pytest tests/ -q
if [ $? -ne 0 ]; then
    echo "Tests failed. Commit aborted."
    exit 1
fi

echo "Pre-commit checks passed!"
EOF

chmod +x .git/hooks/pre-commit

# Test the hook
echo "# Test change" >> README.md
git add README.md
git commit -m "Test pre-commit hook"
```

#### 9.2 Git Stash Operations
```bash
# Make some temporary changes
echo "Temporary work in progress" >> src/temp.py
echo "More temporary changes" >> config/temp.conf

# Stash changes
git stash push -m "Work in progress on temporary features"

# List stashes
git stash list

# Apply stash
git stash apply

# Create named stash
git stash push -m "Experimental feature work" src/temp.py

# Pop specific stash
git stash pop stash@{0}
```

#### 9.3 Git Submodules (Advanced)
```bash
# Add submodule
git submodule add https://github.com/example/shared-library.git lib/shared

# Initialize submodules
git submodule init
git submodule update

# Update submodules
git submodule update --remote

# Commit submodule changes
git add .gitmodules lib/shared
git commit -m "Add shared library as submodule"
```

## 📊 Project Deliverables

### 1. Repository Structure
```
git-learning-project/
├── .gitlab-ci.yml
├── .gitlab/
│   ├── issue_templates/
│   └── merge_request_templates/
├── README.md
├── CHANGELOG.md
├── src/
│   ├── main.py
│   ├── auth/
│   ├── database/
│   ├── profile.py
│   └── version.py
├── tests/
│   ├── test_auth.py
│   ├── test_profile.py
│   └── test_database.py
├── config/
│   └── app.conf
└── docs/
    └── README.md
```

### 2. Git History Documentation
```bash
# Generate comprehensive git log
git log --oneline --graph --all > git-history.txt

# Branch information
git branch -a > branches.txt

# Remote information
git remote -v > remotes.txt

# Configuration
git config --list > git-config.txt
```

### 3. Workflow Documentation
- Branch strategy implementation
- Merge request process
- Conflict resolution examples
- CI/CD pipeline configuration

### 4. Scripts and Automation
- Pre-commit hooks
- Automated testing setup
- Deployment scripts
- Backup and recovery procedures

## 🧪 Testing and Validation

### Validation Checklist
- [ ] Repository initialized and configured
- [ ] Multiple branches created and managed
- [ ] Merge conflicts resolved successfully
- [ ] Remote repository operations working
- [ ] Rebase operations completed
- [ ] GitLab CI/CD pipeline functional
- [ ] Merge request workflow implemented
- [ ] Git hooks working properly

### Testing Commands
```bash
# Validate repository structure
git status
git log --oneline --graph --all

# Test remote operations
git fetch --all
git push --dry-run

# Validate CI/CD pipeline
git push origin main  # Triggers pipeline

# Test branch operations
git branch -a
git remote -v
```

## 📚 Advanced Challenges

### Challenge 1: Complex Merge Scenario
```bash
# Create complex branching scenario
git switch -c feature/complex-merge
# Make multiple commits with conflicts
# Practice advanced conflict resolution
```

### Challenge 2: Git Bisect for Bug Finding
```bash
# Use git bisect to find problematic commit
git bisect start
git bisect bad HEAD
git bisect good HEAD~10
# Follow bisect process
```

### Challenge 3: Custom Git Aliases
```bash
# Create useful Git aliases
git config --global alias.st status
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.unstage 'reset HEAD --'
git config --global alias.visual '!gitk'
```

## 🎯 Learning Outcomes

Upon completion of this project, you will have:
- ✅ **Mastered Git fundamentals** and advanced operations
- ✅ **Implemented professional workflows** with branching strategies
- ✅ **Resolved complex merge conflicts** effectively
- ✅ **Set up automated CI/CD pipelines** with GitLab
- ✅ **Collaborated using merge requests** and code review
- ✅ **Applied Git best practices** for team development
- ✅ **Automated quality checks** with Git hooks

## 💡 Best Practices Learned

1. **Commit Often**: Small, focused commits are easier to manage
2. **Meaningful Messages**: Clear commit messages help team collaboration
3. **Branch Strategy**: Consistent branching improves workflow
4. **Code Review**: Merge requests ensure code quality
5. **Automation**: CI/CD pipelines catch issues early
6. **Documentation**: Good documentation supports team onboarding
7. **Security**: Protect sensitive information in repositories
8. **Backup**: Multiple remotes provide redundancy

---

**Created by Varun Kumar**

*Project 1: Git Version Control & Collaboration Workflow - Session 3: Mastering Git*
