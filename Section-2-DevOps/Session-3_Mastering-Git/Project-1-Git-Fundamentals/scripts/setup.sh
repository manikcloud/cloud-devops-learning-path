#!/bin/bash

# Git Fundamentals Project Setup Script
# This script demonstrates automation in Git workflows

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Project configuration
PROJECT_NAME="git-fundamentals-project"
PYTHON_VERSION="3.9"
VENV_NAME="venv"

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to check Python version
check_python_version() {
    print_status "Checking Python version..."
    
    if command_exists python3; then
        PYTHON_CMD="python3"
    elif command_exists python; then
        PYTHON_CMD="python"
    else
        print_error "Python is not installed. Please install Python $PYTHON_VERSION or higher."
        exit 1
    fi
    
    CURRENT_VERSION=$($PYTHON_CMD --version 2>&1 | cut -d' ' -f2)
    print_success "Found Python $CURRENT_VERSION"
    
    # Check if version is sufficient (basic check)
    if [[ "$CURRENT_VERSION" < "3.8" ]]; then
        print_warning "Python version might be too old. Recommended: $PYTHON_VERSION+"
    fi
}

# Function to check Git installation
check_git_installation() {
    print_status "Checking Git installation..."
    
    if ! command_exists git; then
        print_error "Git is not installed. Please install Git first."
        echo "Installation instructions:"
        echo "  Ubuntu/Debian: sudo apt install git"
        echo "  CentOS/RHEL: sudo yum install git"
        echo "  macOS: brew install git"
        exit 1
    fi
    
    GIT_VERSION=$(git --version | cut -d' ' -f3)
    print_success "Found Git $GIT_VERSION"
}

# Function to create project directory structure
create_project_structure() {
    print_status "Creating project directory structure..."
    
    # Create main project directory
    mkdir -p "$PROJECT_NAME"
    cd "$PROJECT_NAME"
    
    # Create subdirectories
    mkdir -p {src,tests,docs,config,scripts,data}
    
    # Create essential files
    touch README.md
    touch .gitignore
    touch requirements.txt
    
    print_success "Project structure created"
}

# Function to initialize Git repository
initialize_git_repo() {
    print_status "Initializing Git repository..."
    
    # Initialize Git repository
    git init
    
    # Set default branch to main
    git config init.defaultBranch main
    git checkout -b main 2>/dev/null || git branch -m main
    
    # Configure Git (if not already configured)
    if [[ -z "$(git config user.name)" ]]; then
        print_warning "Git user.name not configured. Please run:"
        echo "  git config --global user.name 'Your Name'"
    fi
    
    if [[ -z "$(git config user.email)" ]]; then
        print_warning "Git user.email not configured. Please run:"
        echo "  git config --global user.email 'your.email@example.com'"
    fi
    
    print_success "Git repository initialized"
}

# Function to create Python virtual environment
create_virtual_environment() {
    print_status "Creating Python virtual environment..."
    
    # Create virtual environment
    $PYTHON_CMD -m venv $VENV_NAME
    
    # Activate virtual environment
    source $VENV_NAME/bin/activate
    
    # Upgrade pip
    pip install --upgrade pip
    
    print_success "Virtual environment created and activated"
}

# Function to create .gitignore file
create_gitignore() {
    print_status "Creating .gitignore file..."
    
    cat > .gitignore << 'EOF'
# Python
__pycache__/
*.py[cod]
*$py.class
*.so
.Python
build/
develop-eggs/
dist/
downloads/
eggs/
.eggs/
lib/
lib64/
parts/
sdist/
var/
wheels/
*.egg-info/
.installed.cfg
*.egg

# Virtual Environment
venv/
env/
ENV/

# IDE
.vscode/
.idea/
*.swp
*.swo

# OS
.DS_Store
Thumbs.db

# Logs
*.log

# Coverage
htmlcov/
.coverage
.coverage.*
coverage.xml
*.cover

# pytest
.pytest_cache/

# mypy
.mypy_cache/

# Jupyter Notebook
.ipynb_checkpoints

# pyenv
.python-version

# Environment variables
.env
.env.local
.env.development
.env.test
.env.production

# Database
*.db
*.sqlite3

# Temporary files
*.tmp
*.temp
*~

# Documentation builds
docs/_build/
EOF
    
    print_success ".gitignore file created"
}

# Function to create README.md
create_readme() {
    print_status "Creating README.md file..."
    
    cat > README.md << EOF
# Git Fundamentals Project

A comprehensive hands-on project for mastering Git version control and team collaboration workflows.

## 🎯 Project Overview

This project provides practical experience with:
- Git repository management
- Branching strategies
- Merge conflict resolution
- Remote repository operations
- Team collaboration workflows

## 🚀 Quick Start

1. **Clone the repository:**
   \`\`\`bash
   git clone <repository-url>
   cd $PROJECT_NAME
   \`\`\`

2. **Set up the environment:**
   \`\`\`bash
   ./scripts/setup.sh
   \`\`\`

3. **Activate virtual environment:**
   \`\`\`bash
   source venv/bin/activate
   \`\`\`

4. **Install dependencies:**
   \`\`\`bash
   pip install -r requirements.txt
   \`\`\`

5. **Run the application:**
   \`\`\`bash
   python src/main.py
   \`\`\`

## 📁 Project Structure

\`\`\`
$PROJECT_NAME/
├── src/                 # Source code
├── tests/              # Test files
├── docs/               # Documentation
├── config/             # Configuration files
├── scripts/            # Utility scripts
├── data/               # Data files
├── venv/               # Virtual environment
├── README.md           # This file
├── requirements.txt    # Python dependencies
└── .gitignore         # Git ignore rules
\`\`\`

## 🔧 Development Workflow

1. **Create feature branch:**
   \`\`\`bash
   git checkout -b feature/your-feature-name
   \`\`\`

2. **Make changes and commit:**
   \`\`\`bash
   git add .
   git commit -m "feat: add your feature description"
   \`\`\`

3. **Push to remote:**
   \`\`\`bash
   git push origin feature/your-feature-name
   \`\`\`

4. **Create pull request and merge**

## 🧪 Testing

Run tests with:
\`\`\`bash
python -m pytest tests/
\`\`\`

## 📚 Learning Resources

- [Git Documentation](https://git-scm.com/doc)
- [GitHub Flow](https://guides.github.com/introduction/flow/)
- [GitLab Flow](https://docs.gitlab.com/ee/topics/gitlab_flow.html)

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## 📄 License

This project is for educational purposes.

---

**Created for Git Fundamentals Learning**  
*Practice makes perfect! 🚀*
EOF
    
    print_success "README.md file created"
}

# Function to create sample requirements.txt
create_requirements() {
    print_status "Creating requirements.txt file..."
    
    cat > requirements.txt << 'EOF'
# Core dependencies
click==8.1.7
colorama==0.4.6
python-dateutil==2.8.2

# Development dependencies
black==23.7.0
flake8==6.0.0
isort==5.12.0

# Testing dependencies
pytest==7.4.0
pytest-cov==4.1.0

# Git utilities
gitpython==3.1.32
EOF
    
    print_success "requirements.txt file created"
}

# Function to create initial commit
create_initial_commit() {
    print_status "Creating initial commit..."
    
    # Add all files to staging
    git add .
    
    # Create initial commit
    git commit -m "Initial commit: Add project structure and configuration

- Add project directory structure
- Create virtual environment setup
- Add .gitignore for Python projects
- Include README with project documentation
- Set up requirements.txt with dependencies"
    
    print_success "Initial commit created"
}

# Function to display next steps
display_next_steps() {
    echo ""
    echo "🎉 Project setup completed successfully!"
    echo ""
    echo "📋 Next steps:"
    echo "1. Navigate to project directory: cd $PROJECT_NAME"
    echo "2. Activate virtual environment: source $VENV_NAME/bin/activate"
    echo "3. Install dependencies: pip install -r requirements.txt"
    echo "4. Start coding and practicing Git workflows!"
    echo ""
    echo "🔧 Useful Git commands to practice:"
    echo "  git status          # Check repository status"
    echo "  git log --oneline   # View commit history"
    echo "  git branch          # List branches"
    echo "  git checkout -b feature/new-feature  # Create new branch"
    echo ""
    echo "📚 Happy learning! 🚀"
}

# Main execution
main() {
    echo "🚀 Git Fundamentals Project Setup"
    echo "=================================="
    echo ""
    
    # Run setup steps
    check_python_version
    check_git_installation
    create_project_structure
    initialize_git_repo
    create_virtual_environment
    create_gitignore
    create_readme
    create_requirements
    create_initial_commit
    
    # Display completion message
    display_next_steps
}

# Run main function
main "$@"
