# Session 4: Jenkins - CI/CD Automation

## 🎯 Module Overview

This module covers the fundamentals of Continuous Integration and Continuous Deployment using Jenkins. You'll learn to create automated pipelines, integrate with various tools, and implement CI/CD best practices for modern software delivery.

## 📚 Learning Objectives

By the end of this session, you will be able to:
- ✅ **Install and configure Jenkins** on various platforms
- ✅ **Set up master-slave architecture** for distributed builds
- ✅ **Create and manage Jenkins jobs** and pipelines
- ✅ **Implement CI/CD pipelines** for different applications
- ✅ **Use Pipeline as Code** with Jenkinsfile
- ✅ **Integrate Jenkins** with Git, AWS, and GCP
- ✅ **Deploy applications** automatically using Jenkins
- ✅ **Monitor and troubleshoot** pipeline executions

## 📖 Module Content

### 1. Jenkins and Installation

#### What is Jenkins?

Jenkins is an open-source automation server that enables developers to build, test, and deploy their applications continuously. It's the leading CI/CD tool in the DevOps ecosystem.

**Key Features:**
- **Open Source**: Free and community-driven
- **Extensible**: 1800+ plugins available
- **Distributed**: Master-slave architecture
- **Platform Independent**: Java-based, runs anywhere
- **Easy Configuration**: Web-based interface
- **Pipeline Support**: Code-based pipeline definitions

#### CI/CD Concepts

**Continuous Integration (CI):**
- Frequent code integration
- Automated builds and tests
- Early bug detection
- Consistent build environment

**Continuous Delivery (CD):**
- Automated deployment to staging
- Manual approval for production
- Consistent deployment process
- Rollback capabilities

**Continuous Deployment:**
- Fully automated deployment
- No manual intervention
- High confidence in automation
- Rapid feature delivery

#### Jenkins Installation

**Prerequisites:**
- Java 8 or 11 (OpenJDK recommended)
- Minimum 256MB RAM (1GB+ recommended)
- 1GB+ disk space

**Installation on Linux (Ubuntu/Debian):**
```bash
# Update system
sudo apt update

# Install Java
sudo apt install openjdk-11-jdk -y

# Add Jenkins repository
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'

# Install Jenkins
sudo apt update
sudo apt install jenkins -y

# Start Jenkins service
sudo systemctl start jenkins
sudo systemctl enable jenkins

# Check status
sudo systemctl status jenkins
```

**Installation on CentOS/RHEL:**
```bash
# Install Java
sudo yum install java-11-openjdk-devel -y

# Add Jenkins repository
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key

# Install Jenkins
sudo yum install jenkins -y

# Start Jenkins
sudo systemctl start jenkins
sudo systemctl enable jenkins

# Configure firewall
sudo firewall-cmd --permanent --add-port=8080/tcp
sudo firewall-cmd --reload
```

**Installation using Docker:**
```bash
# Pull Jenkins image
docker pull jenkins/jenkins:lts

# Run Jenkins container
docker run -d \
  --name jenkins \
  -p 8080:8080 \
  -p 50000:50000 \
  -v jenkins_home:/var/jenkins_home \
  jenkins/jenkins:lts

# Get initial admin password
docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword
```

**Installation on AWS EC2:**
```bash
#!/bin/bash
# User data script for EC2 instance

# Update system
yum update -y

# Install Java
amazon-linux-extras install java-openjdk11 -y

# Add Jenkins repository
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key

# Install Jenkins
yum install jenkins -y

# Start Jenkins
systemctl start jenkins
systemctl enable jenkins

# Install Git and Docker
yum install git docker -y
systemctl start docker
systemctl enable docker

# Add jenkins user to docker group
usermod -a -G docker jenkins
```

#### Initial Setup

**First-Time Setup:**
1. Access Jenkins at `http://your-server:8080`
2. Get initial admin password:
   ```bash
   sudo cat /var/jenkins_home/secrets/initialAdminPassword
   ```
3. Install suggested plugins
4. Create admin user
5. Configure Jenkins URL

**Essential Plugins:**
- **Git Plugin**: Git integration
- **Pipeline Plugin**: Pipeline support
- **Blue Ocean**: Modern UI
- **AWS Pipeline Plugin**: AWS integration
- **Docker Plugin**: Docker integration
- **Slack Notification**: Team notifications

### 2. Configuring Master, Slave and Multimode

#### Jenkins Architecture

**Master Node:**
- Schedules builds
- Dispatches builds to slaves
- Monitors slaves
- Records and presents build results
- Serves Jenkins UI

**Slave/Agent Nodes:**
- Execute builds dispatched by master
- Can run on different operating systems
- Specialized for specific tasks
- Scalable build capacity

#### Setting Up Slave Nodes

**Prerequisites for Slave:**
- Java installed
- Network connectivity to master
- SSH access (for SSH slaves)
- Appropriate tools installed

**Adding SSH Slave:**
1. **Generate SSH Key on Master:**
   ```bash
   ssh-keygen -t rsa -b 4096 -f ~/.ssh/jenkins_slave_key
   ```

2. **Copy Public Key to Slave:**
   ```bash
   ssh-copy-id -i ~/.ssh/jenkins_slave_key.pub user@slave-ip
   ```

3. **Configure in Jenkins:**
   - Go to "Manage Jenkins" → "Manage Nodes"
   - Click "New Node"
   - Enter node name and select "Permanent Agent"
   - Configure:
     - Remote root directory: `/home/jenkins`
     - Launch method: "Launch agents via SSH"
     - Host: slave IP address
     - Credentials: SSH private key

**JNLP Slave Setup:**
1. **Download agent.jar on slave:**
   ```bash
   wget http://jenkins-master:8080/jnlpJars/agent.jar
   ```

2. **Run agent:**
   ```bash
   java -jar agent.jar -jnlpUrl http://jenkins-master:8080/computer/slave-name/slave-agent.jnlp -secret <secret-key>
   ```

**Docker Slave Configuration:**
```yaml
# docker-compose.yml for Jenkins slave
version: '3'
services:
  jenkins-slave:
    image: jenkins/ssh-slave
    environment:
      - JENKINS_SLAVE_SSH_PUBKEY=<public-key>
    ports:
      - "22:22"
    volumes:
      - slave_workspace:/home/jenkins
```

#### Multi-Mode Configuration

**Node Labels:**
- Assign labels to nodes for specific tasks
- Examples: `linux`, `windows`, `docker`, `aws`

**Build Restrictions:**
```groovy
// Restrict build to specific nodes
node('linux && docker') {
    // Build steps here
}
```

**Load Balancing:**
- **Fair Share**: Equal distribution
- **Load Balancing**: Based on current load
- **Fastest First**: Prefer faster nodes

### 3. Set Up a Job and Pipeline

#### Creating Freestyle Jobs

**Basic Freestyle Job:**
1. **New Item** → **Freestyle project**
2. **Source Code Management:**
   - Git repository URL
   - Credentials
   - Branch specification

3. **Build Triggers:**
   - Poll SCM: `H/5 * * * *` (every 5 minutes)
   - GitHub hook trigger
   - Build periodically: `H 2 * * *` (daily at 2 AM)

4. **Build Environment:**
   - Delete workspace before build
   - Use secret text/files
   - Set environment variables

5. **Build Steps:**
   ```bash
   # Example build steps
   echo "Starting build..."
   mvn clean compile
   mvn test
   mvn package
   ```

6. **Post-build Actions:**
   - Archive artifacts
   - Publish test results
   - Send notifications

#### Pipeline Jobs

**Pipeline vs Freestyle:**
| Pipeline | Freestyle |
|----------|-----------|
| Code-based | GUI-based |
| Version controlled | Configuration in Jenkins |
| Complex workflows | Simple linear builds |
| Reusable | Job-specific |

**Creating Pipeline Job:**
1. **New Item** → **Pipeline**
2. **Pipeline Definition:**
   - Pipeline script (inline)
   - Pipeline script from SCM (Jenkinsfile)

**Simple Pipeline Script:**
```groovy
pipeline {
    agent any
    
    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/user/repo.git'
            }
        }
        
        stage('Build') {
            steps {
                sh 'mvn clean compile'
            }
        }
        
        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }
        
        stage('Package') {
            steps {
                sh 'mvn package'
            }
        }
    }
    
    post {
        always {
            cleanWs()
        }
        success {
            echo 'Build succeeded!'
        }
        failure {
            echo 'Build failed!'
        }
    }
}
```

### 4. Build, Integrate and Delivery Pipeline

#### Build Pipeline Components

**Source Code Management:**
```groovy
stage('Checkout') {
    steps {
        checkout scm
        // Or specific repository
        git branch: 'main', 
            url: 'https://github.com/user/repo.git',
            credentialsId: 'github-credentials'
    }
}
```

**Build Stage:**
```groovy
stage('Build') {
    steps {
        script {
            if (fileExists('pom.xml')) {
                sh 'mvn clean compile'
            } else if (fileExists('package.json')) {
                sh 'npm install && npm run build'
            } else if (fileExists('Dockerfile')) {
                sh 'docker build -t myapp:${BUILD_NUMBER} .'
            }
        }
    }
}
```

**Testing Stages:**
```groovy
stage('Unit Tests') {
    steps {
        sh 'mvn test'
    }
    post {
        always {
            publishTestResults testResultsPattern: 'target/surefire-reports/*.xml'
        }
    }
}

stage('Integration Tests') {
    steps {
        sh 'mvn verify -P integration-tests'
    }
}

stage('Code Quality') {
    steps {
        script {
            def scannerHome = tool 'SonarQubeScanner'
            withSonarQubeEnv('SonarQube') {
                sh "${scannerHome}/bin/sonar-scanner"
            }
        }
    }
}
```

**Artifact Management:**
```groovy
stage('Archive Artifacts') {
    steps {
        archiveArtifacts artifacts: 'target/*.jar', 
                        fingerprint: true
    }
}

stage('Docker Image') {
    steps {
        script {
            def image = docker.build("myapp:${BUILD_NUMBER}")
            docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
                image.push()
                image.push('latest')
            }
        }
    }
}
```

#### Integration Pipeline

**Multi-Branch Pipeline:**
```groovy
pipeline {
    agent any
    
    stages {
        stage('Build') {
            steps {
                sh 'mvn clean compile'
            }
        }
        
        stage('Test') {
            parallel {
                stage('Unit Tests') {
                    steps {
                        sh 'mvn test'
                    }
                }
                stage('Integration Tests') {
                    steps {
                        sh 'mvn verify -P integration'
                    }
                }
            }
        }
        
        stage('Deploy to Staging') {
            when {
                branch 'develop'
            }
            steps {
                sh 'deploy-to-staging.sh'
            }
        }
        
        stage('Deploy to Production') {
            when {
                branch 'main'
            }
            steps {
                input message: 'Deploy to production?', ok: 'Deploy'
                sh 'deploy-to-production.sh'
            }
        }
    }
}
```

#### Delivery Pipeline

**Environment Promotion:**
```groovy
pipeline {
    agent any
    
    parameters {
        choice(
            name: 'ENVIRONMENT',
            choices: ['dev', 'staging', 'production'],
            description: 'Target environment'
        )
    }
    
    stages {
        stage('Deploy') {
            steps {
                script {
                    switch(params.ENVIRONMENT) {
                        case 'dev':
                            sh 'deploy-to-dev.sh'
                            break
                        case 'staging':
                            sh 'deploy-to-staging.sh'
                            break
                        case 'production':
                            input message: 'Confirm production deployment'
                            sh 'deploy-to-production.sh'
                            break
                    }
                }
            }
        }
    }
}
```

### 5. Pipeline as Code

#### Jenkinsfile Fundamentals

**Jenkinsfile Benefits:**
- **Version Control**: Pipeline definition in Git
- **Code Review**: Changes reviewed like code
- **Reusability**: Shared across projects
- **Consistency**: Standardized pipelines

**Jenkinsfile Structure:**
```groovy
pipeline {
    agent any  // or specific agent
    
    environment {
        // Environment variables
        MAVEN_OPTS = '-Xmx1024m'
    }
    
    parameters {
        // Build parameters
        string(name: 'BRANCH', defaultValue: 'main', description: 'Branch to build')
    }
    
    stages {
        // Build stages
    }
    
    post {
        // Post-build actions
    }
}
```

#### Advanced Pipeline Features

**Parallel Execution:**
```groovy
stage('Parallel Tests') {
    parallel {
        stage('Unit Tests') {
            steps {
                sh 'mvn test'
            }
        }
        stage('Integration Tests') {
            steps {
                sh 'mvn verify -P integration'
            }
        }
        stage('Security Scan') {
            steps {
                sh 'security-scan.sh'
            }
        }
    }
}
```

**Conditional Execution:**
```groovy
stage('Deploy') {
    when {
        anyOf {
            branch 'main'
            branch 'release/*'
        }
    }
    steps {
        sh 'deploy.sh'
    }
}
```

**Error Handling:**
```groovy
stage('Risky Operation') {
    steps {
        script {
            try {
                sh 'risky-command.sh'
            } catch (Exception e) {
                echo "Command failed: ${e.getMessage()}"
                currentBuild.result = 'UNSTABLE'
            }
        }
    }
}
```

**Shared Libraries:**
```groovy
// vars/deployApp.groovy
def call(String environment) {
    echo "Deploying to ${environment}"
    sh "deploy-to-${environment}.sh"
}

// Jenkinsfile
@Library('my-shared-library') _

pipeline {
    agent any
    stages {
        stage('Deploy') {
            steps {
                deployApp('staging')
            }
        }
    }
}
```

## 💻 Term Projects

### Term Project 2: Java Application CI/CD with Jenkins and AWS

#### Project Overview
Set up a complete CI/CD pipeline for a Java application using Jenkins and deploy to AWS.

#### Architecture
```
GitHub → Jenkins → Build → Test → Deploy to AWS EC2/ECS
```

#### Requirements

**1. Application Setup:**
- Spring Boot Java application
- Maven build system
- Unit and integration tests
- Dockerfile for containerization

**2. Jenkins Pipeline:**
```groovy
pipeline {
    agent any
    
    environment {
        AWS_REGION = 'us-east-1'
        ECR_REPOSITORY = 'my-java-app'
        ECS_CLUSTER = 'production'
        ECS_SERVICE = 'java-app-service'
    }
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Build') {
            steps {
                sh 'mvn clean compile'
            }
        }
        
        stage('Test') {
            parallel {
                stage('Unit Tests') {
                    steps {
                        sh 'mvn test'
                    }
                    post {
                        always {
                            publishTestResults testResultsPattern: 'target/surefire-reports/*.xml'
                        }
                    }
                }
                stage('Integration Tests') {
                    steps {
                        sh 'mvn verify -P integration-tests'
                    }
                }
            }
        }
        
        stage('Package') {
            steps {
                sh 'mvn package -DskipTests'
                archiveArtifacts artifacts: 'target/*.jar'
            }
        }
        
        stage('Docker Build') {
            steps {
                script {
                    def image = docker.build("${ECR_REPOSITORY}:${BUILD_NUMBER}")
                    
                    // Push to ECR
                    docker.withRegistry("https://${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com", "ecr:${AWS_REGION}:aws-credentials") {
                        image.push()
                        image.push('latest')
                    }
                }
            }
        }
        
        stage('Deploy to Staging') {
            steps {
                script {
                    sh """
                        aws ecs update-service \
                            --cluster ${ECS_CLUSTER}-staging \
                            --service ${ECS_SERVICE} \
                            --force-new-deployment \
                            --region ${AWS_REGION}
                    """
                }
            }
        }
        
        stage('Deploy to Production') {
            when {
                branch 'main'
            }
            steps {
                input message: 'Deploy to production?', ok: 'Deploy'
                script {
                    sh """
                        aws ecs update-service \
                            --cluster ${ECS_CLUSTER} \
                            --service ${ECS_SERVICE} \
                            --force-new-deployment \
                            --region ${AWS_REGION}
                    """
                }
            }
        }
    }
    
    post {
        always {
            cleanWs()
        }
        success {
            slackSend channel: '#deployments',
                     color: 'good',
                     message: "✅ ${env.JOB_NAME} - ${env.BUILD_NUMBER} deployed successfully"
        }
        failure {
            slackSend channel: '#deployments',
                     color: 'danger',
                     message: "❌ ${env.JOB_NAME} - ${env.BUILD_NUMBER} failed"
        }
    }
}
```

**3. AWS Infrastructure:**
- ECS Cluster for container orchestration
- ECR for Docker image registry
- Application Load Balancer
- RDS for database
- CloudWatch for monitoring

### Term Project 3: Web Application CI/CD with Jenkins and GCP

#### Project Overview
Set up CI/CD pipeline for a Node.js web application using Jenkins and deploy to Google Cloud Platform.

#### Architecture
```
GitLab → Jenkins → Build → Test → Deploy to GCP GKE
```

#### Requirements

**1. Application Setup:**
- Node.js/React web application
- npm/yarn package management
- Jest unit tests
- Dockerfile and Kubernetes manifests

**2. Jenkins Pipeline:**
```groovy
pipeline {
    agent any
    
    environment {
        GCP_PROJECT = 'my-gcp-project'
        GKE_CLUSTER = 'web-app-cluster'
        GKE_ZONE = 'us-central1-a'
        IMAGE_NAME = 'web-app'
    }
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Install Dependencies') {
            steps {
                sh 'npm install'
            }
        }
        
        stage('Lint and Test') {
            parallel {
                stage('Lint') {
                    steps {
                        sh 'npm run lint'
                    }
                }
                stage('Unit Tests') {
                    steps {
                        sh 'npm test -- --coverage --watchAll=false'
                    }
                    post {
                        always {
                            publishHTML([
                                allowMissing: false,
                                alwaysLinkToLastBuild: true,
                                keepAll: true,
                                reportDir: 'coverage/lcov-report',
                                reportFiles: 'index.html',
                                reportName: 'Coverage Report'
                            ])
                        }
                    }
                }
            }
        }
        
        stage('Build') {
            steps {
                sh 'npm run build'
            }
        }
        
        stage('Docker Build and Push') {
            steps {
                script {
                    def image = docker.build("gcr.io/${GCP_PROJECT}/${IMAGE_NAME}:${BUILD_NUMBER}")
                    
                    docker.withRegistry('https://gcr.io', 'gcr:gcp-service-account') {
                        image.push()
                        image.push('latest')
                    }
                }
            }
        }
        
        stage('Deploy to Staging') {
            steps {
                script {
                    sh """
                        gcloud container clusters get-credentials ${GKE_CLUSTER} --zone ${GKE_ZONE} --project ${GCP_PROJECT}
                        
                        sed -i 's|IMAGE_TAG|${BUILD_NUMBER}|g' k8s/staging/deployment.yaml
                        
                        kubectl apply -f k8s/staging/
                        kubectl rollout status deployment/web-app-staging
                    """
                }
            }
        }
        
        stage('Integration Tests') {
            steps {
                sh 'npm run test:integration'
            }
        }
        
        stage('Deploy to Production') {
            when {
                branch 'main'
            }
            steps {
                input message: 'Deploy to production?', ok: 'Deploy'
                script {
                    sh """
                        sed -i 's|IMAGE_TAG|${BUILD_NUMBER}|g' k8s/production/deployment.yaml
                        
                        kubectl apply -f k8s/production/
                        kubectl rollout status deployment/web-app-production
                    """
                }
            }
        }
    }
    
    post {
        always {
            cleanWs()
        }
        success {
            emailext (
                subject: "✅ Deployment Successful: ${env.JOB_NAME} - ${env.BUILD_NUMBER}",
                body: "The deployment was successful. Check the application at: https://myapp.example.com",
                to: "${env.CHANGE_AUTHOR_EMAIL}"
            )
        }
        failure {
            emailext (
                subject: "❌ Deployment Failed: ${env.JOB_NAME} - ${env.BUILD_NUMBER}",
                body: "The deployment failed. Please check the Jenkins logs for details.",
                to: "${env.CHANGE_AUTHOR_EMAIL}"
            )
        }
    }
}
```

**3. GCP Infrastructure:**
- GKE cluster for Kubernetes orchestration
- Container Registry for Docker images
- Cloud Load Balancer
- Cloud SQL for database
- Stackdriver for monitoring

## 🛠️ Hands-On Labs

### Lab 1: Jenkins Installation and Setup
- Install Jenkins on EC2 instance
- Configure initial settings
- Install essential plugins
- Set up user authentication

### Lab 2: Master-Slave Configuration
- Set up Jenkins slave nodes
- Configure different node types
- Test distributed builds
- Monitor node performance

### Lab 3: Pipeline Creation
- Create freestyle jobs
- Build declarative pipelines
- Implement pipeline as code
- Use shared libraries

### Lab 4: Integration and Deployment
- Integrate with Git repositories
- Set up automated testing
- Deploy to cloud platforms
- Implement monitoring and notifications

## 📊 Assessment Methods

### Practical Assessments
- Jenkins installation and configuration
- Pipeline creation and management
- CI/CD implementation
- Troubleshooting and optimization

### Project Evaluation
- Pipeline design and implementation
- Code quality and testing integration
- Deployment automation
- Monitoring and alerting setup
- Documentation and best practices

## 📚 Additional Resources

### Documentation
- [Jenkins Official Documentation](https://www.jenkins.io/doc/)
- [Pipeline Syntax Reference](https://www.jenkins.io/doc/book/pipeline/syntax/)
- [Plugin Index](https://plugins.jenkins.io/)
- [Best Practices Guide](https://www.jenkins.io/doc/book/pipeline/pipeline-best-practices/)

### Learning Resources
- [Jenkins Handbook](https://www.jenkins.io/doc/book/)
- [Pipeline Examples](https://github.com/jenkinsci/pipeline-examples)
- [CloudBees Jenkins Resources](https://www.cloudbees.com/jenkins/resources)
- [Jenkins Community](https://www.jenkins.io/participate/)

### Tools and Integrations
- **Version Control**: Git, SVN, Mercurial
- **Build Tools**: Maven, Gradle, npm, yarn
- **Testing**: JUnit, TestNG, Jest, Selenium
- **Cloud Platforms**: AWS, GCP, Azure
- **Monitoring**: Prometheus, Grafana, ELK Stack

## 🎯 Next Steps

After mastering Jenkins, you'll be prepared for:
- **Advanced CI/CD**: GitOps, ArgoCD, Tekton
- **Container Orchestration**: Kubernetes, Docker Swarm
- **Infrastructure as Code**: Terraform, Ansible
- **Monitoring and Observability**: Prometheus, Grafana

## 💡 Key Takeaways

1. **Jenkins automates** the entire software delivery process
2. **Pipeline as Code** enables version-controlled CI/CD
3. **Master-slave architecture** provides scalability
4. **Integration capabilities** connect all DevOps tools
5. **Automation reduces** manual errors and deployment time
6. **Monitoring and notifications** ensure pipeline reliability
7. **Security considerations** are crucial for production pipelines
8. **Continuous improvement** optimizes pipeline performance

---

**Created by Varun Kumar**

*Session 4: Jenkins - Section 2: DevOps & Infrastructure as Code*
