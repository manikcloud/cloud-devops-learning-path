# 🌍 Module 08: Real-World Projects

<div align="center">

![Python](https://img.shields.io/badge/Python-Flask-blue?style=for-the-badge&logo=python&logoColor=white)
![PHP](https://img.shields.io/badge/PHP-Docker-purple?style=for-the-badge&logo=php&logoColor=white)

**🎯 Multi-Language Support | 🐳 Docker Integration | 🌐 Real Applications**

</div>

---

## 📋 Module Overview

This module applies Jenkins CI/CD concepts to real-world applications using different technologies. You'll work with Python Flask applications and PHP applications with Docker containerization.

### 🎯 **Learning Objectives**
- ✅ Deploy Python Flask applications with Jenkins
- ✅ Containerize PHP applications using Docker
- ✅ Implement multi-language CI/CD pipelines
- ✅ Handle different deployment strategies
- ✅ Manage application dependencies and environments

---

## 🛤️ Module Structure

<table>
<tr>
<th width="10%">Project</th>
<th width="30%">Name</th>
<th width="40%">Description</th>
<th width="20%">Skills</th>
</tr>

<tr>
<td><strong>8.1</strong></td>
<td><strong><a href="./8.1_python_flask_app">Python Flask Application</a></strong></td>
<td>Build and deploy Python Flask web application with automated testing and deployment</td>
<td>Python, Flask, Virtual Environments, Python Testing</td>
</tr>

<tr>
<td><strong>8.2</strong></td>
<td><strong><a href="./8.2_php_docker">PHP Docker Application</a></strong></td>
<td>Containerize PHP application using Docker with automated build and deployment pipeline</td>
<td>PHP, Docker, Containerization, Multi-stage Builds</td>
</tr>

</table>

---

## 🐍 **Python Flask Pipeline**

### **Flask Application Structure**
```
flask-app/
├── app.py              # Main Flask application
├── requirements.txt    # Python dependencies
├── tests/
│   └── test_app.py    # Unit tests
├── Dockerfile         # Container definition
└── Jenkinsfile        # Pipeline definition
```

### **Sample Pipeline**
```groovy
pipeline {
    agent any
    
    environment {
        PYTHON_VERSION = '3.9'
    }
    
    stages {
        stage('Setup Python Environment') {
            steps {
                sh '''
                    python3 -m venv venv
                    source venv/bin/activate
                    pip install --upgrade pip
                    pip install -r requirements.txt
                '''
            }
        }
        
        stage('Run Tests') {
            steps {
                sh '''
                    source venv/bin/activate
                    python -m pytest tests/ --junitxml=test-results.xml
                '''
            }
            post {
                always {
                    junit 'test-results.xml'
                }
            }
        }
        
        stage('Deploy') {
            steps {
                sh '''
                    source venv/bin/activate
                    gunicorn --bind 0.0.0.0:5000 app:app &
                '''
            }
        }
    }
}
```

---

## 🐳 **PHP Docker Pipeline**

### **Docker Multi-stage Build**
```dockerfile
# Build stage
FROM php:8.1-cli AS builder
WORKDIR /app
COPY composer.json composer.lock ./
RUN composer install --no-dev --optimize-autoloader

# Production stage
FROM php:8.1-apache
WORKDIR /var/www/html
COPY --from=builder /app/vendor ./vendor
COPY . .
RUN chown -R www-data:www-data /var/www/html
EXPOSE 80
```

### **Docker Pipeline**
```groovy
pipeline {
    agent any
    
    environment {
        DOCKER_IMAGE = 'php-app'
        DOCKER_TAG = "${BUILD_NUMBER}"
    }
    
    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${DOCKER_IMAGE}:${DOCKER_TAG}")
                }
            }
        }
        
        stage('Test Container') {
            steps {
                script {
                    docker.image("${DOCKER_IMAGE}:${DOCKER_TAG}").inside {
                        sh 'php -v'
                        sh 'composer test'
                    }
                }
            }
        }
        
        stage('Deploy Container') {
            steps {
                script {
                    sh "docker run -d -p 8080:80 --name php-app-${BUILD_NUMBER} ${DOCKER_IMAGE}:${DOCKER_TAG}"
                }
            }
        }
    }
}
```

---

## ➡️ Next Steps

**Proceed to Module 09** - [Master-Slave Architecture](../09_master_slave_architecture/README.md)

---

<div align="center">

### 🎯 **Build Real Applications with Jenkins!**

**Start Building: [8.1 Python Flask App](./8.1_python_flask_app/README.md)**

</div>
