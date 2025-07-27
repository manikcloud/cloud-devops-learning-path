# 🚀 Project 2: GitLab CI/CD Pipeline Integration
## *Automate Your Development Workflow with GitLab DevOps Platform*

<div align="center">

![GitLab](https://img.shields.io/badge/GitLab-FC6D26?style=for-the-badge&logo=gitlab&logoColor=white)
![CI/CD](https://img.shields.io/badge/CI%2FCD-Pipeline-blue?style=for-the-badge&logo=gitlab&logoColor=white)
![DevOps](https://img.shields.io/badge/DevOps-Automation-green?style=for-the-badge&logo=devops&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)

**Duration:** 1 Week | **Level:** Intermediate | **Type:** CI/CD Implementation

---

### 📊 **Project Status**
<table>
<tr>
<td align="center" width="20%">
<img src="https://img.shields.io/badge/📅-Active-green?style=for-the-badge" alt="Status"/>
</td>
<td align="center" width="20%">
<img src="https://img.shields.io/badge/🎯-4_Tasks-blue?style=for-the-badge" alt="Tasks"/>
</td>
<td align="center" width="20%">
<img src="https://img.shields.io/badge/⏱️-30_Hours-orange?style=for-the-badge" alt="Duration"/>
</td>
<td align="center" width="20%">
<img src="https://img.shields.io/badge/🔧-Automation-purple?style=for-the-badge" alt="Automation"/>
</td>
<td align="center" width="20%">
<img src="https://img.shields.io/badge/🚀-Production_Ready-success?style=for-the-badge" alt="Production"/>
</td>
</tr>
</table>

<img src="./images/gitlab-cicd-workflow.svg" alt="GitLab CI/CD Workflow" width="700"/>

</div>

---

## 🎯 Project Overview

<div align="center">

> **Mission:** Build a complete CI/CD pipeline using GitLab's integrated DevOps platform, automating testing, building, and deployment processes.

</div>

This project focuses on implementing a production-ready CI/CD pipeline using GitLab's comprehensive DevOps platform. You'll create automated workflows that handle code integration, testing, security scanning, and deployment, following industry best practices for continuous delivery.

### 🌟 **What Makes This Project Special**

<table>
<tr>
<td align="center" width="25%">
<strong>🔄 Full Automation</strong><br/>
Complete pipeline from code to production
</td>
<td align="center" width="25%">
<strong>🛡️ Security First</strong><br/>
Integrated security scanning and compliance
</td>
<td align="center" width="25%">
<strong>📊 Monitoring</strong><br/>
Built-in metrics and pipeline visibility
</td>
<td align="center" width="25%">
<strong>🚀 Production Ready</strong><br/>
Enterprise-grade deployment strategies
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

### 🔧 **CI/CD Mastery**
- ✅ **Design and implement** complete CI/CD pipelines
- ✅ **Configure GitLab Runners** for automated execution
- ✅ **Create multi-stage pipelines** with dependencies
- ✅ **Implement automated testing** and quality gates

</td>
<td align="center" width="50%">

### 🚀 **DevOps Excellence**
- ✅ **Deploy to multiple environments** (staging, production)
- ✅ **Implement security scanning** and compliance checks
- ✅ **Configure monitoring and alerting** for pipelines
- ✅ **Master GitLab's DevOps features** comprehensively

</td>
</tr>
</table>

### 🎯 **Success Metrics**

<table>
<tr>
<td align="center" width="25%">**Pipeline Stages:** 4+ implemented</td>
<td align="center" width="25%">**Automation:** 100% hands-off deployment</td>
<td align="center" width="25%">**Security:** Vulnerability scanning active</td>
<td align="center" width="25%">**Monitoring:** Full pipeline visibility</td>
</tr>
</table>

</div>

---

## 📚 Project Navigation

<div align="center">

| [🏗️ Setup](#-task-1-gitlab-repository--runner-setup) | [⚙️ Pipeline](#-task-2-cicd-pipeline-configuration) | [🧪 Testing](#-task-3-automated-testing--quality-gates) | [🚀 Deployment](#-task-4-deployment-automation--monitoring) |
|:---:|:---:|:---:|:---:|

</div>

---

<details>
<summary><h2>🏗️ Task 1: GitLab Repository & Runner Setup</h2></summary>

<div align="center">

### 🎯 **Objective:** Set up GitLab project with proper configuration and runners

</div>

### 📋 **Task Overview**
Create a GitLab project, configure repository settings, set up GitLab Runners, and prepare the foundation for CI/CD pipeline implementation.

### 🛠️ **Implementation Steps**

#### 1.1 GitLab Project Creation

<details>
<summary><strong>🏗️ Repository Setup</strong></summary>

```bash
# Create a new GitLab project (via GitLab UI or API)
# Project name: "devops-cicd-pipeline"
# Visibility: Private
# Initialize with README: Yes

# Clone the repository locally
git clone https://gitlab.com/your-username/devops-cicd-pipeline.git
cd devops-cicd-pipeline

# Create project structure
mkdir -p {src,tests,docker,scripts,docs,.gitlab}
echo "# DevOps CI/CD Pipeline Project" > README.md
echo "Automated CI/CD pipeline implementation using GitLab" >> README.md

# Create a sample Python application
cat > src/app.py << 'EOF'
from flask import Flask, jsonify
import os

app = Flask(__name__)

@app.route('/')
def hello():
    return jsonify({
        'message': 'Hello from DevOps CI/CD Pipeline!',
        'version': '1.0.0',
        'environment': os.getenv('ENVIRONMENT', 'development')
    })

@app.route('/health')
def health():
    return jsonify({'status': 'healthy'}), 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
EOF

# Create requirements file
cat > requirements.txt << 'EOF'
Flask==2.3.2
pytest==7.4.0
pytest-cov==4.1.0
requests==2.31.0
gunicorn==21.2.0
EOF

# Create test file
cat > tests/test_app.py << 'EOF'
import pytest
import sys
import os
sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..', 'src'))

from app import app

@pytest.fixture
def client():
    app.config['TESTING'] = True
    with app.test_client() as client:
        yield client

def test_hello_endpoint(client):
    response = client.get('/')
    assert response.status_code == 200
    data = response.get_json()
    assert 'message' in data
    assert data['version'] == '1.0.0'

def test_health_endpoint(client):
    response = client.get('/health')
    assert response.status_code == 200
    data = response.get_json()
    assert data['status'] == 'healthy'
EOF

# Commit initial structure
git add .
git commit -m "Initial commit: Add Flask application with tests

- Add Flask web application with health endpoint
- Include comprehensive test suite
- Set up project structure for CI/CD pipeline
- Add requirements.txt with dependencies"

git push origin main
```

</details>

#### 1.2 GitLab Runner Configuration

<details>
<summary><strong>🏃 Runner Setup</strong></summary>

```bash
# Install GitLab Runner (on your server or use shared runners)
# For Ubuntu/Debian:
curl -L "https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh" | sudo bash
sudo apt-get install gitlab-runner

# For CentOS/RHEL:
curl -L "https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.rpm.sh" | sudo bash
sudo yum install gitlab-runner

# Register the runner (get token from GitLab project settings)
sudo gitlab-runner register \
  --url "https://gitlab.com/" \
  --registration-token "YOUR_REGISTRATION_TOKEN" \
  --description "DevOps CI/CD Runner" \
  --tag-list "docker,python,deployment" \
  --executor "docker" \
  --docker-image "python:3.9"

# Verify runner registration
sudo gitlab-runner list
sudo gitlab-runner verify
```

</details>

#### 1.3 Project Configuration

<details>
<summary><strong>⚙️ Repository Settings</strong></summary>

```bash
# Create .gitignore file
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

# Docker
.dockerignore
EOF

# Create Docker configuration
cat > docker/Dockerfile << 'EOF'
FROM python:3.9-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements and install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY src/ .

# Create non-root user
RUN useradd --create-home --shell /bin/bash app \
    && chown -R app:app /app
USER app

# Expose port
EXPOSE 5000

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:5000/health || exit 1

# Run application
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]
EOF

# Commit configuration files
git add .
git commit -m "config: Add Docker and project configuration

- Add comprehensive .gitignore for Python projects
- Create Dockerfile for containerized deployment
- Configure health checks and security best practices
- Set up non-root user for container security"

git push origin main
```

</details>

### ✅ **Completion Checklist**
- [ ] GitLab project created and configured
- [ ] Repository cloned locally with proper structure
- [ ] Sample Flask application implemented
- [ ] Test suite created and verified
- [ ] GitLab Runner installed and registered
- [ ] Project settings optimized for CI/CD

### 📁 **Project Files**
- **[🌐 app.py](./files/app.py)** - Simple Flask web application
- **[🧪 test_app.py](./files/test_app.py)** - Basic test suite for the application
- **[📦 requirements.txt](./files/requirements.txt)** - Python dependencies
- **[⚙️ .gitlab-ci.yml](./files/.gitlab-ci.yml)** - GitLab CI/CD pipeline configuration

### 🚀 **Quick Start**
```bash
# Download the files and set up locally
mkdir gitlab-cicd-demo && cd gitlab-cicd-demo

# Copy the files from the links above, then:
pip install -r requirements.txt
python app.py

# Test the application
pytest test_app.py -v
```

---

</details>

<details>
<summary><h2>⚙️ Task 2: CI/CD Pipeline Configuration</h2></summary>

<div align="center">

### 🎯 **Objective:** Create comprehensive .gitlab-ci.yml pipeline configuration

</div>

### 📋 **Task Overview**
Design and implement a multi-stage CI/CD pipeline that handles building, testing, and deployment with proper stage dependencies.

### 🛠️ **Implementation Steps**

#### 2.1 Basic Pipeline Structure

<details>
<summary><strong>🏗️ Pipeline Foundation</strong></summary>

**Use the provided [.gitlab-ci.yml](./files/.gitlab-ci.yml) file as your starting point.**

```yaml
# Basic pipeline structure
stages:
  - test
  - deploy

variables:
  PYTHON_VERSION: "3.9"

# Test stage
test-app:
  stage: test
  image: python:$PYTHON_VERSION
  script:
    - pip install -r requirements.txt
    - pytest test_app.py -v
  only:
    - main
    - develop
```

**Key Pipeline Features:**
- ✅ Multi-stage pipeline (test → deploy)
- ✅ Python environment setup
- ✅ Automated testing
- ✅ Branch-specific deployments
- ✅ Manual production deployment

</details>

#### 2.2 Testing Integration

<details>
<summary><strong>🧪 Automated Testing Setup</strong></summary>

**The pipeline automatically:**

1. **Installs Dependencies**
   ```bash
   pip install -r requirements.txt
   ```

2. **Runs Tests**
   ```bash
   pytest test_app.py -v
   ```

3. **Validates Application**
   - Tests all endpoints
   - Verifies response formats
   - Checks application health

**Test Coverage:**
- ✅ Home endpoint functionality
- ✅ Health check endpoint
- ✅ API information endpoint
- ✅ Response format validation

</details>

#### 2.3 Deployment Automation

<details>
<summary><strong>🚀 Deployment Configuration</strong></summary>

**Staging Deployment (Automatic):**
- Triggers on `develop` branch
- Simulates staging environment deployment
- Provides deployment feedback

**Production Deployment (Manual):**
- Triggers on `main` branch
- Requires manual approval
- Ensures production safety

```yaml
deploy-production:
  stage: deploy
  script:
    - echo "Deploying to production environment..."
    - echo "Production deployment complete!"
  only:
    - main
  when: manual  # Requires manual trigger
```

</details>

### ✅ **Completion Checklist**
- [ ] Pipeline configuration created
- [ ] Test automation implemented
- [ ] Staging deployment configured
- [ ] Production deployment set up
- [ ] Manual approval process established
- [ ] Pipeline tested successfully

---

</details>

## 🎉 Project Completion

<div align="center">

### 🏆 **Congratulations!**

You've successfully implemented a comprehensive GitLab CI/CD pipeline that automates your entire development workflow from code commit to production deployment.

### 📊 **What You've Achieved**

<table>
<tr>
<td align="center" width="25%">
<strong>🔄 Full Automation</strong><br/>
Complete CI/CD pipeline
</td>
<td align="center" width="25%">
<strong>🛡️ Security Integration</strong><br/>
Automated security scanning
</td>
<td align="center" width="25%">
<strong>📈 Quality Assurance</strong><br/>
Comprehensive testing
</td>
<td align="center" width="25%">
<strong>🚀 Production Ready</strong><br/>
Enterprise deployment
</td>
</tr>
</table>

### 🎯 **Next Steps**
- Explore GitLab's advanced features (Auto DevOps, Security Dashboard)
- Implement infrastructure as code with Terraform
- Set up monitoring and observability
- Scale your pipeline for microservices

</div>

---

**Created by Varun Kumar Manik**  
*AWS Ambassador | Kubernetes Expert | DevOps Specialist*

**Project 2: GitLab CI/CD Pipeline Integration** | **Section 2: DevOps & Infrastructure as Code**  
*Last Updated: July 2025*
