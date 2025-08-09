# 🎯 Module 10: Final Project - Java Application CI/CD Pipeline

<div align="center">

![Final Project](https://img.shields.io/badge/Final%20Project-Java%20CI%2FCD-gold?style=for-the-badge&logo=java&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-Deployment-orange?style=for-the-badge&logo=amazon-aws&logoColor=white)
![Jenkins](https://img.shields.io/badge/Jenkins-Pipeline-blue?style=for-the-badge&logo=jenkins&logoColor=white)

**🎯 Complete CI/CD Pipeline | 🚀 AWS Deployment | 📊 Production Ready**

</div>

---

## 📋 Project Overview

**Term Project 2: Setup a Java application CI/CD with Jenkins and deploy application on AWS**

This capstone project demonstrates your mastery of Jenkins CI/CD by building a complete, production-ready pipeline that automatically builds, tests, and deploys a Java application to AWS infrastructure.

### 🎯 **Project Objectives**
- ✅ Build a complete end-to-end CI/CD pipeline
- ✅ Implement automated testing and quality gates
- ✅ Deploy Java application to AWS EC2 automatically
- ✅ Configure monitoring and notifications
- ✅ Demonstrate industry best practices

---

## 🏗️ **Architecture Overview**

<div align="center">

![Jenkins CI/CD Pipeline](../images/jenkins-cicd-pipeline.svg)

</div>

```
Developer → Git Push → GitHub → Webhook → Jenkins Pipeline → AWS Deployment

┌─────────────┐    ┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│   Source    │    │    Build    │    │    Test     │    │   Deploy    │
│             │    │             │    │             │    │             │
│ • Git Repo  │───▶│ • Maven     │───▶│ • JUnit     │───▶│ • AWS EC2   │
│ • Webhook   │    │ • Compile   │    │ • Coverage  │    │ • Tomcat    │
│ • Branches  │    │ • Package   │    │ • Quality   │    │ • Monitoring│
└─────────────┘    └─────────────┘    └─────────────┘    └─────────────┘
```

---

## 🛤️ Project Structure

<table>
<tr>
<th width="10%">Phase</th>
<th width="30%">Component</th>
<th width="40%">Description</th>
<th width="20%">Skills</th>
</tr>

<tr>
<td><strong>10.1</strong></td>
<td><strong><a href="./10.1_java_cicd_aws">Java CI/CD AWS Pipeline</a></strong></td>
<td>Complete Java application CI/CD pipeline with AWS deployment</td>
<td>Full-stack CI/CD, AWS Integration, Production Deployment</td>
</tr>

</table>

---

## 🎯 **Project Requirements**

### **Application Specifications**
- **Technology**: Java Spring Boot web application
- **Build Tool**: Maven 3.6+
- **Testing**: JUnit 5 with minimum 80% code coverage
- **Packaging**: WAR file for Tomcat deployment
- **Database**: MySQL (RDS) for data persistence

### **Pipeline Requirements**
- **Source Control**: Git with feature branch workflow
- **Automated Triggers**: Webhook-based builds
- **Build Process**: Maven clean, compile, test, package
- **Quality Gates**: Tests must pass, coverage threshold
- **Deployment**: Automated deployment to AWS EC2
- **Notifications**: Email alerts for build status

### **AWS Infrastructure**
- **Compute**: EC2 instances with Tomcat
- **Database**: RDS MySQL instance
- **Load Balancer**: Application Load Balancer (ALB)
- **Security**: Security groups, IAM roles
- **Monitoring**: CloudWatch metrics and alarms

---

## 📊 **Pipeline Stages Detailed**

### **Stage 1: Source Code Management**
```groovy
stage('Checkout') {
    steps {
        git branch: 'main', 
            url: 'https://github.com/your-org/java-web-app.git',
            credentialsId: 'github-credentials'
    }
}
```

**Deliverables:**
- ✅ Source code checked out from Git
- ✅ Branch strategy implemented
- ✅ Webhook triggers configured

### **Stage 2: Build & Compile**
```groovy
stage('Build') {
    steps {
        sh 'mvn clean compile'
    }
    post {
        always {
            archiveArtifacts artifacts: 'target/*.jar', 
                           fingerprint: true
        }
    }
}
```

**Deliverables:**
- ✅ Java application compiled successfully
- ✅ Dependencies resolved
- ✅ Build artifacts archived

### **Stage 3: Unit Testing**
```groovy
stage('Test') {
    steps {
        sh 'mvn test'
    }
    post {
        always {
            junit 'target/surefire-reports/*.xml'
            publishHTML([
                allowMissing: false,
                alwaysLinkToLastBuild: true,
                keepAll: true,
                reportDir: 'target/site/jacoco',
                reportFiles: 'index.html',
                reportName: 'Code Coverage Report'
            ])
        }
    }
}
```

**Deliverables:**
- ✅ Unit tests executed
- ✅ Test reports generated
- ✅ Code coverage measured (80%+ required)

### **Stage 4: Package Application**
```groovy
stage('Package') {
    steps {
        sh 'mvn package -DskipTests'
    }
    post {
        success {
            archiveArtifacts artifacts: 'target/*.war', 
                           fingerprint: true
        }
    }
}
```

**Deliverables:**
- ✅ WAR file created
- ✅ Application packaged for deployment
- ✅ Artifacts ready for deployment

### **Stage 5: Deploy to Staging**
```groovy
stage('Deploy to Staging') {
    steps {
        script {
            sshagent(['aws-ec2-key']) {
                sh '''
                    scp target/*.war ec2-user@staging-server:/opt/tomcat/webapps/
                    ssh ec2-user@staging-server "sudo systemctl restart tomcat"
                '''
            }
        }
    }
}
```

**Deliverables:**
- ✅ Application deployed to staging environment
- ✅ Staging tests passed
- ✅ Environment health verified

### **Stage 6: Production Deployment**
```groovy
stage('Deploy to Production') {
    when {
        branch 'main'
    }
    input {
        message "Deploy to production?"
        ok "Deploy"
        parameters {
            choice(name: 'ENVIRONMENT', 
                   choices: ['production'], 
                   description: 'Target environment')
        }
    }
    steps {
        script {
            deployToProduction()
        }
    }
}
```

**Deliverables:**
- ✅ Manual approval gate implemented
- ✅ Production deployment automated
- ✅ Zero-downtime deployment achieved

---

## 🔧 **Technical Implementation**

### **Jenkins Pipeline Configuration**

#### **Jenkinsfile Structure:**
```groovy
pipeline {
    agent any
    
    tools {
        maven 'Maven-3.8.1'
        jdk 'JDK-11'
    }
    
    environment {
        AWS_REGION = 'us-east-1'
        APP_NAME = 'java-web-app'
        STAGING_SERVER = 'staging.example.com'
        PROD_SERVER = 'prod.example.com'
    }
    
    stages {
        // All stages defined above
    }
    
    post {
        always {
            cleanWs()
        }
        success {
            emailext (
                subject: "✅ Build Success: ${env.JOB_NAME} - ${env.BUILD_NUMBER}",
                body: "Build completed successfully!",
                to: "${env.CHANGE_AUTHOR_EMAIL}"
            )
        }
        failure {
            emailext (
                subject: "❌ Build Failed: ${env.JOB_NAME} - ${env.BUILD_NUMBER}",
                body: "Build failed. Please check the logs.",
                to: "${env.CHANGE_AUTHOR_EMAIL}"
            )
        }
    }
}
```

### **AWS Infrastructure as Code**

#### **Terraform Configuration:**
```hcl
# Application Load Balancer
resource "aws_lb" "app_lb" {
  name               = "java-app-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets           = [aws_subnet.public_1.id, aws_subnet.public_2.id]
}

# Auto Scaling Group
resource "aws_autoscaling_group" "app_asg" {
  name                = "java-app-asg"
  vpc_zone_identifier = [aws_subnet.private_1.id, aws_subnet.private_2.id]
  target_group_arns   = [aws_lb_target_group.app_tg.arn]
  health_check_type   = "ELB"
  
  min_size         = 2
  max_size         = 6
  desired_capacity = 2
  
  launch_template {
    id      = aws_launch_template.app_lt.id
    version = "$Latest"
  }
}

# RDS Database
resource "aws_db_instance" "app_db" {
  identifier = "java-app-db"
  
  engine         = "mysql"
  engine_version = "8.0"
  instance_class = "db.t3.micro"
  
  allocated_storage = 20
  storage_type      = "gp2"
  
  db_name  = "javaapp"
  username = "admin"
  password = var.db_password
  
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.app_db_subnet_group.name
  
  skip_final_snapshot = true
}
```

---

## 📊 **Quality Gates & Metrics**

### **Build Quality Requirements**
- ✅ **Code Coverage**: Minimum 80%
- ✅ **Unit Tests**: All tests must pass
- ✅ **Build Time**: Under 10 minutes
- ✅ **Security Scan**: No critical vulnerabilities

### **Deployment Metrics**
- ✅ **Deployment Time**: Under 5 minutes
- ✅ **Success Rate**: 95%+ deployment success
- ✅ **Rollback Time**: Under 2 minutes if needed
- ✅ **Zero Downtime**: No service interruption

### **Monitoring & Alerting**
- 📊 **Application Metrics**: Response time, error rate
- 📊 **Infrastructure Metrics**: CPU, memory, disk usage
- 📧 **Alerts**: Email/Slack notifications for issues
- 📈 **Dashboards**: Real-time monitoring displays

---

## 🚀 Getting Started

### **Prerequisites**
- ✅ Completed Modules 01-09
- ✅ AWS account with appropriate permissions
- ✅ GitHub repository with sample Java application
- ✅ Jenkins server with all required plugins

### **Setup Steps**
1. **Fork Sample Application** - Get the Java web app template
2. **Configure AWS Infrastructure** - Deploy using Terraform
3. **Set up Jenkins Pipeline** - Create multi-branch pipeline
4. **Configure Webhooks** - Enable automatic triggers
5. **Test End-to-End** - Verify complete pipeline flow

---

## 📈 **Success Criteria**

### **Technical Requirements**
- [ ] Pipeline builds successfully from Git webhook
- [ ] All unit tests pass with 80%+ coverage
- [ ] Application deploys to staging automatically
- [ ] Production deployment requires manual approval
- [ ] Email notifications work for all build states
- [ ] Application is accessible via load balancer
- [ ] Database connectivity is established
- [ ] Monitoring and logging are functional

### **Documentation Requirements**
- [ ] Pipeline documentation complete
- [ ] Deployment runbook created
- [ ] Troubleshooting guide written
- [ ] Architecture diagram updated
- [ ] Security review completed

---

## 🎓 **Learning Outcomes**

Upon completion, you will have demonstrated:

### **Technical Mastery**
- ✅ **End-to-End CI/CD** - Complete pipeline implementation
- ✅ **AWS Integration** - Cloud deployment automation
- ✅ **Quality Assurance** - Testing and coverage implementation
- ✅ **Production Readiness** - Monitoring and alerting setup

### **Professional Skills**
- ✅ **Project Management** - Complex project delivery
- ✅ **Problem Solving** - Troubleshooting and optimization
- ✅ **Documentation** - Technical writing and communication
- ✅ **Best Practices** - Industry-standard implementations

---

## 🏆 **Portfolio Value**

This project serves as a comprehensive portfolio piece demonstrating:

- 🎯 **Full-Stack DevOps Skills**
- 🎯 **Cloud Architecture Design**
- 🎯 **Automation Expertise**
- 🎯 **Production System Management**

---

<div align="center">

### 🎯 **Ready to Build Your Capstone Project?**

**Start Building: [10.1 Java CI/CD AWS Pipeline](./10.1_java_cicd_aws/README.md)**

*Demonstrate your complete mastery of Jenkins CI/CD and AWS deployment!*

---

### 🏆 **Congratulations!**
*Upon completion, you'll have built a production-ready CI/CD pipeline that showcases enterprise-level DevOps skills.*

</div>
