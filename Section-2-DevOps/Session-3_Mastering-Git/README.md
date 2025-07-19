# Session 3: Mastering Git

## 🎯 Module Overview

This module covers the fundamentals of Git version control system and enables participants to use Git effectively for project management. You'll learn to collaborate efficiently using modern Git workflows and platforms like GitLab and Bitbucket.

## 📚 Learning Objectives

By the end of this session, you will be able to:
- ✅ **Understand version control concepts** and Git architecture
- ✅ **Create, clone, and manage Git repositories** effectively
- ✅ **Implement branching strategies** and merge workflows
- ✅ **Resolve merge conflicts** and fix common mistakes
- ✅ **Use remote repositories** and collaboration features
- ✅ **Master Git rebase** and advanced operations
- ✅ **Work with GitLab and Bitbucket** platforms
- ✅ **Implement CI/CD** with GitLab CI

## 📖 Module Content

### 1. Introduction to Source Code Control Systems

#### What is Version Control?
Version control is a system that records changes to files over time so you can recall specific versions later. It allows multiple developers to work on the same project simultaneously.

**Key Benefits:**
- **Track Changes**: Complete history of modifications
- **Collaboration**: Multiple developers working together
- **Backup**: Distributed copies of code
- **Branching**: Parallel development streams
- **Rollback**: Revert to previous versions
- **Accountability**: Who changed what and when

#### Types of Version Control Systems

**Local Version Control:**
- Files stored locally with version history
- Simple but limited collaboration
- Example: RCS (Revision Control System)

**Centralized Version Control:**
- Single server stores all versions
- Clients check out files from central location
- Examples: CVS, Subversion (SVN), Perforce

**Distributed Version Control:**
- Every client has complete repository copy
- No single point of failure
- Examples: Git, Mercurial, Bazaar

#### Why Git?

**Advantages:**
- **Distributed**: Every clone is a full backup
- **Fast**: Local operations are lightning fast
- **Flexible**: Supports various workflows
- **Secure**: Cryptographic integrity
- **Popular**: Industry standard
- **Open Source**: Free and community-driven

### 2. Overview of Git and Workflow

#### Git Architecture

```
Working Directory  →  Staging Area  →  Local Repository  →  Remote Repository
     (Modified)         (Staged)         (Committed)         (Pushed)
```

**Components:**
- **Working Directory**: Your current files
- **Staging Area (Index)**: Prepared changes for commit
- **Local Repository**: Your local Git database
- **Remote Repository**: Shared repository (GitHub, GitLab)

#### Git Object Model

**Git Objects:**
- **Blob**: File content
- **Tree**: Directory structure
- **Commit**: Snapshot with metadata
- **Tag**: Named reference to commit

#### Basic Git Workflow

```bash
# 1. Modify files in working directory
echo "Hello World" > file.txt

# 2. Stage changes
git add file.txt

# 3. Commit changes
git commit -m "Add hello world file"

# 4. Push to remote
git push origin main
```

#### Git States

**File States:**
- **Untracked**: New files not in Git
- **Modified**: Changed but not staged
- **Staged**: Ready for commit
- **Committed**: Stored in local repository

### 3. Creating/Cloning/Committing a New Repo

#### Creating a New Repository

**Initialize Local Repository:**
```bash
# Create new directory
mkdir my-project
cd my-project

# Initialize Git repository
git init

# Check repository status
git status

# Configure user information
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

# Check configuration
git config --list
```

**First Commit:**
```bash
# Create initial file
echo "# My Project" > README.md

# Add file to staging area
git add README.md

# Create first commit
git commit -m "Initial commit: Add README"

# View commit history
git log
git log --oneline
```

#### Cloning Existing Repository

**Clone Repository:**
```bash
# Clone from remote repository
git clone https://github.com/user/repo.git
git clone git@github.com:user/repo.git  # SSH

# Clone to specific directory
git clone https://github.com/user/repo.git my-local-name

# Clone specific branch
git clone -b branch-name https://github.com/user/repo.git

# Shallow clone (recent history only)
git clone --depth 1 https://github.com/user/repo.git
```

#### Working with Files

**Adding Files:**
```bash
# Add specific file
git add filename.txt

# Add multiple files
git add file1.txt file2.txt

# Add all files in directory
git add .

# Add all modified files
git add -A

# Add files interactively
git add -i

# Add parts of file
git add -p filename.txt
```

**Committing Changes:**
```bash
# Commit with message
git commit -m "Commit message"

# Commit with detailed message
git commit -m "Short description" -m "Detailed explanation"

# Commit all modified files (skip staging)
git commit -a -m "Commit message"

# Amend last commit
git commit --amend -m "Updated commit message"

# Empty commit (for triggering CI)
git commit --allow-empty -m "Trigger CI"
```

**Viewing History:**
```bash
# View commit history
git log
git log --oneline
git log --graph
git log --stat

# View specific file history
git log filename.txt

# View changes in commits
git show commit-hash
git show HEAD~1  # Previous commit

# Compare commits
git diff commit1 commit2
git diff HEAD~1 HEAD
```

### 4. Branching & Merging in Git

#### Understanding Branches

**What are Branches?**
Branches are lightweight, movable pointers to specific commits. They allow parallel development without affecting the main codebase.

**Default Branch:**
- **main/master**: Primary development branch
- **HEAD**: Pointer to current branch

#### Branch Operations

**Creating and Switching Branches:**
```bash
# List branches
git branch
git branch -a  # Include remote branches

# Create new branch
git branch feature-branch

# Switch to branch
git checkout feature-branch

# Create and switch in one command
git checkout -b feature-branch

# Modern syntax (Git 2.23+)
git switch feature-branch
git switch -c feature-branch  # Create and switch
```

**Branch Management:**
```bash
# Rename branch
git branch -m old-name new-name

# Delete branch
git branch -d branch-name      # Safe delete
git branch -D branch-name      # Force delete

# Delete remote branch
git push origin --delete branch-name

# Track remote branch
git branch -u origin/branch-name
```

#### Merging Strategies

**Fast-Forward Merge:**
```bash
# Switch to target branch
git checkout main

# Merge feature branch
git merge feature-branch

# Result: Linear history
```

**Three-Way Merge:**
```bash
# When branches have diverged
git checkout main
git merge feature-branch

# Creates merge commit
```

**Merge Options:**
```bash
# No fast-forward (always create merge commit)
git merge --no-ff feature-branch

# Squash merge (combine all commits)
git merge --squash feature-branch

# Abort merge
git merge --abort
```

#### Common Branching Strategies

**Git Flow:**
- **main**: Production-ready code
- **develop**: Integration branch
- **feature/***: New features
- **release/***: Release preparation
- **hotfix/***: Emergency fixes

**GitHub Flow:**
- **main**: Always deployable
- **feature branches**: Short-lived for features
- **Pull requests**: Code review and merge

**GitLab Flow:**
- **main**: Development branch
- **production**: Production branch
- **environment branches**: Staging, testing

### 5. Fix Merge Conflicts and Mistakes

#### Understanding Merge Conflicts

**When Conflicts Occur:**
- Same file modified in different branches
- Same lines changed differently
- File deleted in one branch, modified in another

**Conflict Markers:**
```
<<<<<<< HEAD
Current branch content
=======
Incoming branch content
>>>>>>> feature-branch
```

#### Resolving Conflicts

**Manual Resolution:**
```bash
# Start merge
git merge feature-branch

# Git shows conflict files
# Edit files to resolve conflicts
# Remove conflict markers

# Stage resolved files
git add resolved-file.txt

# Complete merge
git commit
```

**Using Merge Tools:**
```bash
# Configure merge tool
git config --global merge.tool vimdiff

# Launch merge tool
git mergetool

# Available tools: vimdiff, meld, kdiff3, etc.
```

#### Fixing Common Mistakes

**Undo Last Commit (Keep Changes):**
```bash
git reset --soft HEAD~1
```

**Undo Last Commit (Discard Changes):**
```bash
git reset --hard HEAD~1
```

**Undo Specific File:**
```bash
git checkout HEAD -- filename.txt
```

**Revert Commit (Safe for Shared History):**
```bash
git revert commit-hash
```

**Fix Commit Message:**
```bash
git commit --amend -m "Corrected message"
```

**Unstage Files:**
```bash
git reset HEAD filename.txt
```

**Discard Local Changes:**
```bash
git checkout -- filename.txt
git restore filename.txt  # Modern syntax
```

### 6. Merge Requests/Pull Requests

#### Understanding Pull Requests

**What is a Pull Request?**
A pull request (GitHub) or merge request (GitLab) is a method of submitting contributions to a project. It allows code review before merging.

**Benefits:**
- **Code Review**: Quality assurance
- **Discussion**: Collaborative feedback
- **Testing**: Automated checks
- **Documentation**: Change tracking

#### Creating Pull Requests

**GitHub Workflow:**
```bash
# 1. Fork repository (on GitHub)
# 2. Clone your fork
git clone https://github.com/yourusername/repo.git

# 3. Create feature branch
git checkout -b feature-branch

# 4. Make changes and commit
git add .
git commit -m "Add new feature"

# 5. Push to your fork
git push origin feature-branch

# 6. Create pull request on GitHub
```

**GitLab Workflow:**
```bash
# 1. Clone repository
git clone https://gitlab.com/project/repo.git

# 2. Create feature branch
git checkout -b feature-branch

# 3. Make changes and commit
git add .
git commit -m "Add new feature"

# 4. Push branch
git push origin feature-branch

# 5. Create merge request on GitLab
```

#### Pull Request Best Practices

**Good Pull Request:**
- **Small and Focused**: Single feature or fix
- **Clear Title**: Descriptive summary
- **Detailed Description**: What, why, and how
- **Tests Included**: Verify functionality
- **Documentation Updated**: Keep docs current

**Review Process:**
- **Code Review**: Check logic and style
- **Testing**: Verify functionality
- **Discussion**: Address feedback
- **Approval**: Maintainer approval
- **Merge**: Integration to main branch

### 7. Remote and Rebase in Git

#### Working with Remotes

**Remote Repository Management:**
```bash
# List remotes
git remote -v

# Add remote
git remote add origin https://github.com/user/repo.git

# Change remote URL
git remote set-url origin https://github.com/user/new-repo.git

# Remove remote
git remote remove origin

# Rename remote
git remote rename origin upstream
```

**Fetching and Pulling:**
```bash
# Fetch changes (don't merge)
git fetch origin

# Pull changes (fetch + merge)
git pull origin main

# Pull with rebase
git pull --rebase origin main

# Fetch all branches
git fetch --all
```

**Pushing Changes:**
```bash
# Push to remote
git push origin main

# Push new branch
git push -u origin feature-branch

# Force push (dangerous)
git push --force origin main

# Safer force push
git push --force-with-lease origin main
```

#### Git Rebase

**What is Rebase?**
Rebase moves or combines commits to create a linear history. It "replays" commits on top of another branch.

**Interactive Rebase:**
```bash
# Rebase last 3 commits
git rebase -i HEAD~3

# Rebase onto another branch
git rebase main

# Continue after resolving conflicts
git rebase --continue

# Abort rebase
git rebase --abort
```

**Rebase Options:**
- **pick**: Use commit as-is
- **reword**: Change commit message
- **edit**: Modify commit
- **squash**: Combine with previous commit
- **drop**: Remove commit

**Rebase vs Merge:**

| Rebase | Merge |
|--------|-------|
| Linear history | Preserves branch history |
| Cleaner log | Shows actual development |
| Rewrites history | Safe for shared branches |
| Good for feature branches | Good for integration |

### 8. Bitbucket, GitLab CI

#### GitLab Features

**GitLab Components:**
- **Repository**: Git hosting
- **Issues**: Bug tracking
- **Merge Requests**: Code review
- **CI/CD**: Automated pipelines
- **Wiki**: Documentation
- **Snippets**: Code sharing

**GitLab Workflow:**
```bash
# Clone GitLab repository
git clone https://gitlab.com/group/project.git

# Create feature branch
git checkout -b feature/new-functionality

# Make changes and commit
git add .
git commit -m "Implement new functionality"

# Push to GitLab
git push origin feature/new-functionality

# Create merge request via GitLab UI
```

#### GitLab CI/CD

**GitLab CI Configuration (.gitlab-ci.yml):**
```yaml
# Define stages
stages:
  - build
  - test
  - deploy

# Define variables
variables:
  NODE_VERSION: "16"

# Build job
build:
  stage: build
  image: node:$NODE_VERSION
  script:
    - npm install
    - npm run build
  artifacts:
    paths:
      - dist/
    expire_in: 1 hour

# Test job
test:
  stage: test
  image: node:$NODE_VERSION
  script:
    - npm install
    - npm run test
  coverage: '/Coverage: \d+\.\d+%/'

# Deploy job
deploy:
  stage: deploy
  script:
    - echo "Deploying application..."
    - ./deploy.sh
  only:
    - main
  when: manual
```

**Pipeline Features:**
- **Stages**: Sequential execution phases
- **Jobs**: Individual tasks within stages
- **Artifacts**: Files passed between jobs
- **Cache**: Speed up builds
- **Variables**: Configuration values
- **Conditions**: Control job execution

#### Bitbucket Features

**Bitbucket Components:**
- **Repositories**: Git hosting
- **Pull Requests**: Code review
- **Pipelines**: CI/CD automation
- **Issues**: Bug tracking
- **Wiki**: Documentation

**Bitbucket Pipelines (bitbucket-pipelines.yml):**
```yaml
image: node:16

pipelines:
  default:
    - step:
        name: Build and Test
        caches:
          - node
        script:
          - npm install
          - npm run build
          - npm run test
        artifacts:
          - dist/**

  branches:
    main:
      - step:
          name: Deploy to Production
          deployment: production
          script:
            - echo "Deploying to production..."
            - ./deploy-prod.sh
```

## 💻 Term Project 1: GitLab Project Setup

### Project Overview
Set up a GitLab project with proper branch strategy and implement merge request workflow.

### Project Requirements

#### 1. Repository Setup
- Create new GitLab project
- Initialize with README, .gitignore, and LICENSE
- Set up project description and visibility

#### 2. Branch Strategy Implementation
```bash
# Create development branch
git checkout -b develop

# Create feature branch from develop
git checkout -b feature/user-authentication

# Create release branch
git checkout -b release/v1.0.0

# Create hotfix branch from main
git checkout -b hotfix/security-patch
```

#### 3. Branch Protection Rules
- Protect main branch
- Require merge requests
- Require approvals
- Enable merge request discussions

#### 4. Merge Request Workflow
- Create feature branch
- Implement functionality
- Write tests
- Create merge request
- Code review process
- Merge to develop

#### 5. CI/CD Pipeline Setup
```yaml
# .gitlab-ci.yml
stages:
  - validate
  - build
  - test
  - deploy

validate:
  stage: validate
  script:
    - echo "Validating code style..."
    - npm run lint

build:
  stage: build
  script:
    - echo "Building application..."
    - npm run build

test:
  stage: test
  script:
    - echo "Running tests..."
    - npm run test

deploy_staging:
  stage: deploy
  script:
    - echo "Deploying to staging..."
  only:
    - develop

deploy_production:
  stage: deploy
  script:
    - echo "Deploying to production..."
  only:
    - main
  when: manual
```

### Deliverables
1. **GitLab Project**: Configured repository
2. **Branch Strategy Document**: Workflow documentation
3. **Merge Request Examples**: Sample MRs with reviews
4. **CI/CD Pipeline**: Working automation
5. **Documentation**: Setup and usage guide

## 🛠️ Hands-On Labs

### Lab 1: Git Fundamentals
- Initialize repository
- Practice basic commands
- Create commits and view history
- Configure Git settings

### Lab 2: Branching and Merging
- Create and manage branches
- Practice merge strategies
- Resolve merge conflicts
- Implement Git Flow workflow

### Lab 3: Remote Collaboration
- Set up remote repositories
- Practice push/pull operations
- Fork and clone repositories
- Create pull requests

### Lab 4: Advanced Git Operations
- Interactive rebase
- Cherry-picking commits
- Git hooks implementation
- Repository maintenance

## 📊 Assessment Methods

### Practical Assessments
- Git command proficiency test
- Branch management scenarios
- Conflict resolution exercises
- Collaboration workflow implementation

### Project Evaluation
- Repository structure and organization
- Commit message quality
- Branch strategy implementation
- Merge request process
- CI/CD pipeline functionality

## 📚 Additional Resources

### Documentation
- [Git Official Documentation](https://git-scm.com/doc)
- [Pro Git Book](https://git-scm.com/book)
- [GitLab Documentation](https://docs.gitlab.com/)
- [Bitbucket Documentation](https://support.atlassian.com/bitbucket-cloud/)

### Interactive Learning
- [Learn Git Branching](https://learngitbranching.js.org/)
- [Git Immersion](http://gitimmersion.com/)
- [GitHub Learning Lab](https://lab.github.com/)
- [Atlassian Git Tutorials](https://www.atlassian.com/git/tutorials)

### Tools and Clients
- **Command Line**: Git CLI
- **GUI Clients**: GitKraken, SourceTree, GitHub Desktop
- **IDE Integration**: VS Code, IntelliJ, Eclipse
- **Web Interfaces**: GitHub, GitLab, Bitbucket

## 🎯 Next Steps

After mastering Git, you'll be prepared for:
- **Session 4**: Jenkins - CI/CD automation
- **Advanced Git**: Hooks, submodules, and workflows
- **DevOps Pipelines**: Automated testing and deployment
- **Collaboration**: Team development practices

## 💡 Key Takeaways

1. **Git is essential** for modern software development
2. **Branching strategies** enable parallel development
3. **Merge requests** ensure code quality
4. **Rebase creates** clean, linear history
5. **Remote collaboration** requires proper workflows
6. **CI/CD integration** automates quality checks
7. **Practice regularly** to build Git proficiency
8. **Documentation** is crucial for team collaboration

---

**Created by Varun Kumar**

*Session 3: Mastering Git - Section 2: DevOps & Infrastructure as Code*
