# 🎯 Project 10.1: Java CI/CD AWS Pipeline

<div align="center">

![Final Project](https://img.shields.io/badge/Final%20Project-Java%20CI%2FCD-gold?style=for-the-badge&logo=java&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-Deployment-orange?style=for-the-badge&logo=amazon-aws&logoColor=white)
![Production](https://img.shields.io/badge/Production-Ready-red?style=for-the-badge&logo=jenkins&logoColor=white)

**🎯 Complete CI/CD Pipeline | ☁️ AWS Deployment | 📊 Production Ready**

</div>

---

## 📋 Project Overview

**Term Project 2: Setup a Java application CI/CD with Jenkins and deploy application on AWS**

This capstone project demonstrates your complete mastery of Jenkins CI/CD by building an end-to-end pipeline that automatically builds, tests, and deploys a Java Spring Boot application to AWS infrastructure.

### 🎯 **Project Objectives**
- ✅ Build a complete production-ready CI/CD pipeline
- ✅ Implement comprehensive testing and quality gates
- ✅ Deploy Java application to AWS EC2 automatically
- ✅ Configure monitoring, logging, and notifications
- ✅ Demonstrate enterprise-level DevOps practices

---

## 🏗️ **Architecture Overview**

<div align="center">

![Jenkins CI/CD Pipeline](../../images/jenkins-cicd-pipeline.svg)

</div>

### **Complete Pipeline Flow:**
```
Developer → Git Push → GitHub → Webhook → Jenkins Pipeline → Quality Gates → AWS Deployment → Monitoring
```

---

## 📊 **Project Requirements**

### **Application Specifications**
- **Technology Stack:** Java 11 + Spring Boot 2.7+
- **Build Tool:** Maven 3.8+
- **Testing Framework:** JUnit 5 + Mockito
- **Database:** MySQL 8.0 (AWS RDS)
- **Containerization:** Docker (optional)
- **Deployment Target:** AWS EC2 with Tomcat

### **Pipeline Requirements**
- **Source Control:** Git with feature branch workflow
- **Automated Triggers:** GitHub webhook integration
- **Build Process:** Maven clean, compile, test, package
- **Quality Gates:** 80%+ test coverage, all tests pass
- **Security Scanning:** Basic vulnerability checks
- **Deployment:** Blue-green or rolling deployment
- **Monitoring:** Application health checks
- **Notifications:** Email and Slack integration

### **AWS Infrastructure**
- **Compute:** EC2 instances (t3.medium for production)
- **Database:** RDS MySQL instance
- **Load Balancer:** Application Load Balancer (ALB)
- **Storage:** S3 for artifacts and logs
- **Monitoring:** CloudWatch metrics and alarms
- **Security:** IAM roles, Security Groups, VPC

---

## 🚀 **Implementation Guide**

### **Phase 1: Application Setup**

#### **Sample Spring Boot Application Structure:**
```
java-web-app/
├── pom.xml
├── Jenkinsfile
├── Dockerfile
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/
│   │   │       └── example/
│   │   │           ├── Application.java
│   │   │           ├── controller/
│   │   │           │   └── HomeController.java
│   │   │           ├── service/
│   │   │           │   └── UserService.java
│   │   │           └── repository/
│   │   │               └── UserRepository.java
│   │   └── resources/
│   │       ├── application.yml
│   │       └── static/
│   └── test/
│       └── java/
│           └── com/
│               └── example/
│                   ├── ApplicationTests.java
│                   ├── controller/
│                   │   └── HomeControllerTest.java
│                   └── service/
│                       └── UserServiceTest.java
├── scripts/
│   ├── deploy.sh
│   ├── health-check.sh
│   └── rollback.sh
└── infrastructure/
    ├── terraform/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    └── ansible/
        └── playbook.yml
```

#### **Sample pom.xml Configuration:**
```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0">
    <modelVersion>4.0.0</modelVersion>
    
    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>2.7.8</version>
        <relativePath/>
    </parent>
    
    <groupId>com.example</groupId>
    <artifactId>java-web-app</artifactId>
    <version>1.0.0</version>
    <packaging>jar</packaging>
    
    <name>Java Web Application</name>
    <description>Sample Java web application for CI/CD pipeline</description>
    
    <properties>
        <java.version>11</java.version>
        <maven.compiler.source>11</maven.compiler.source>
        <maven.compiler.target>11</maven.compiler.target>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    </properties>
    
    <dependencies>
        <!-- Spring Boot Starters -->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
        
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-data-jpa</artifactId>
        </dependency>
        
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-actuator</artifactId>
        </dependency>
        
        <!-- Database -->
        <dependency>
            <groupId>mysql</groupId>
            <artifactId>mysql-connector-java</artifactId>
            <scope>runtime</scope>
        </dependency>
        
        <!-- Testing -->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-test</artifactId>
            <scope>test</scope>
        </dependency>
    </dependencies>
    
    <build>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
            </plugin>
            
            <!-- Surefire for unit tests -->
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-surefire-plugin</artifactId>
                <version>3.0.0-M9</version>
            </plugin>
            
            <!-- JaCoCo for code coverage -->
            <plugin>
                <groupId>org.jacoco</groupId>
                <artifactId>jacoco-maven-plugin</artifactId>
                <version>0.8.8</version>
                <executions>
                    <execution>
                        <goals>
                            <goal>prepare-agent</goal>
                        </goals>
                    </execution>
                    <execution>
                        <id>report</id>
                        <phase>test</phase>
                        <goals>
                            <goal>report</goal>
                        </goals>
                    </execution>
                </executions>
            </plugin>
        </plugins>
    </build>
</project>
```

### **Phase 2: Complete Jenkinsfile**

```groovy
pipeline {
    agent any
    
    tools {
        maven 'Maven-3.8.1'
        jdk 'JDK-11'
    }
    
    environment {
        // Application Configuration
        APP_NAME = 'java-web-app'
        APP_VERSION = "${BUILD_NUMBER}"
        
        // AWS Configuration
        AWS_REGION = 'us-east-1'
        AWS_ACCOUNT_ID = credentials('aws-account-id')
        
        // Deployment Configuration
        STAGING_SERVER = 'staging.example.com'
        PROD_SERVER = 'prod.example.com'
        
        // Database Configuration
        DB_HOST = credentials('db-host')
        DB_NAME = 'webapp'
        DB_USER = credentials('db-user')
        DB_PASSWORD = credentials('db-password')
        
        // Notification Configuration
        SLACK_CHANNEL = '#devops'
        EMAIL_RECIPIENTS = 'dev-team@company.com'
    }
    
    stages {
        stage('🔍 Checkout') {
            steps {
                echo '🔍 Checking out source code...'
                checkout scm
                
                script {
                    env.GIT_COMMIT_SHORT = sh(
                        script: "git rev-parse --short HEAD",
                        returnStdout: true
                    ).trim()
                    
                    env.GIT_BRANCH = sh(
                        script: "git rev-parse --abbrev-ref HEAD",
                        returnStdout: true
                    ).trim()
                }
                
                echo "📋 Build Info:"
                echo "  - Branch: ${env.GIT_BRANCH}"
                echo "  - Commit: ${env.GIT_COMMIT_SHORT}"
                echo "  - Build: ${env.BUILD_NUMBER}"
            }
        }
        
        stage('🔧 Build') {
            steps {
                echo '🔧 Building application...'
                sh '''
                    mvn clean compile -DskipTests=true
                    echo "✅ Build completed successfully"
                '''
            }
        }
        
        stage('🧪 Test') {
            parallel {
                stage('Unit Tests') {
                    steps {
                        echo '🧪 Running unit tests...'
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
                
                stage('Integration Tests') {
                    steps {
                        echo '🔗 Running integration tests...'
                        sh '''
                            # Start test database
                            docker run -d --name test-mysql -p 3307:3306 \
                                -e MYSQL_ROOT_PASSWORD=testpass \
                                -e MYSQL_DATABASE=testdb \
                                mysql:8.0
                            
                            # Wait for database to be ready
                            sleep 30
                            
                            # Run integration tests
                            mvn integration-test -Dspring.profiles.active=test
                            
                            # Cleanup
                            docker stop test-mysql
                            docker rm test-mysql
                        '''
                    }
                }
            }
        }
        
        stage('📊 Quality Gate') {
            steps {
                echo '📊 Checking quality gates...'
                script {
                    // Check test coverage
                    def coverage = sh(
                        script: "grep -o 'Total.*[0-9]\\+%' target/site/jacoco/index.html | grep -o '[0-9]\\+' | tail -1",
                        returnStdout: true
                    ).trim() as Integer
                    
                    echo "Code Coverage: ${coverage}%"
                    
                    if (coverage < 80) {
                        error("❌ Quality Gate Failed: Coverage ${coverage}% < 80%")
                    }
                    
                    // Check test results
                    def testResults = currentBuild.rawBuild.getAction(hudson.tasks.junit.TestResultAction.class)
                    if (testResults && testResults.failCount > 0) {
                        error("❌ Quality Gate Failed: ${testResults.failCount} test(s) failed")
                    }
                    
                    echo "✅ Quality Gate Passed"
                }
            }
        }
        
        stage('📦 Package') {
            steps {
                echo '📦 Packaging application...'
                sh '''
                    mvn package -DskipTests=true
                    
                    # Create deployment package
                    mkdir -p deployment
                    cp target/*.jar deployment/
                    cp scripts/*.sh deployment/
                    
                    # Create version file
                    echo "${BUILD_NUMBER}" > deployment/VERSION
                    echo "${GIT_COMMIT_SHORT}" >> deployment/VERSION
                    
                    ls -la deployment/
                '''
                
                archiveArtifacts artifacts: 'deployment/**', fingerprint: true
            }
        }
        
        stage('🔒 Security Scan') {
            steps {
                echo '🔒 Running security scans...'
                sh '''
                    # OWASP Dependency Check
                    mvn org.owasp:dependency-check-maven:check
                    
                    # Docker security scan (if using Docker)
                    # docker run --rm -v $(pwd):/app clair-scanner
                '''
            }
            post {
                always {
                    publishHTML([
                        allowMissing: true,
                        alwaysLinkToLastBuild: true,
                        keepAll: true,
                        reportDir: 'target',
                        reportFiles: 'dependency-check-report.html',
                        reportName: 'Security Report'
                    ])
                }
            }
        }
        
        stage('🚀 Deploy to Staging') {
            when {
                anyOf {
                    branch 'develop'
                    branch 'main'
                }
            }
            steps {
                echo '🚀 Deploying to staging environment...'
                script {
                    sshagent(['aws-ec2-key']) {
                        sh '''
                            # Copy deployment package
                            scp -o StrictHostKeyChecking=no deployment/*.jar ec2-user@${STAGING_SERVER}:/opt/app/
                            scp -o StrictHostKeyChecking=no deployment/*.sh ec2-user@${STAGING_SERVER}:/opt/app/
                            
                            # Deploy application
                            ssh -o StrictHostKeyChecking=no ec2-user@${STAGING_SERVER} '
                                cd /opt/app
                                chmod +x *.sh
                                ./deploy.sh staging
                            '
                            
                            # Health check
                            sleep 30
                            curl -f http://${STAGING_SERVER}:8080/actuator/health || exit 1
                            
                            echo "✅ Staging deployment successful"
                        '''
                    }
                }
            }
        }
        
        stage('🎯 Production Deployment') {
            when {
                branch 'main'
            }
            input {
                message "Deploy to production?"
                ok "Deploy"
                parameters {
                    choice(
                        name: 'DEPLOYMENT_STRATEGY',
                        choices: ['blue-green', 'rolling', 'canary'],
                        description: 'Deployment strategy'
                    )
                }
            }
            steps {
                echo "🎯 Deploying to production using ${DEPLOYMENT_STRATEGY} strategy..."
                script {
                    sshagent(['aws-ec2-key']) {
                        sh '''
                            # Production deployment with chosen strategy
                            scp -o StrictHostKeyChecking=no deployment/*.jar ec2-user@${PROD_SERVER}:/opt/app/
                            scp -o StrictHostKeyChecking=no deployment/*.sh ec2-user@${PROD_SERVER}:/opt/app/
                            
                            ssh -o StrictHostKeyChecking=no ec2-user@${PROD_SERVER} "
                                cd /opt/app
                                chmod +x *.sh
                                ./deploy.sh production ${DEPLOYMENT_STRATEGY}
                            "
                            
                            # Production health check
                            sleep 60
                            for i in {1..5}; do
                                if curl -f http://${PROD_SERVER}/actuator/health; then
                                    echo "✅ Production deployment successful"
                                    break
                                fi
                                echo "⏳ Waiting for application to start... ($i/5)"
                                sleep 30
                            done
                        '''
                    }
                }
            }
        }
        
        stage('📊 Post-Deployment Tests') {
            when {
                branch 'main'
            }
            parallel {
                stage('Smoke Tests') {
                    steps {
                        echo '🔥 Running smoke tests...'
                        sh '''
                            # Basic functionality tests
                            curl -f http://${PROD_SERVER}/actuator/health
                            curl -f http://${PROD_SERVER}/api/status
                            
                            # Database connectivity test
                            curl -f http://${PROD_SERVER}/api/health/db
                        '''
                    }
                }
                
                stage('Performance Tests') {
                    steps {
                        echo '⚡ Running performance tests...'
                        sh '''
                            # Simple load test
                            for i in {1..100}; do
                                curl -s http://${PROD_SERVER}/ > /dev/null &
                            done
                            wait
                            
                            echo "✅ Performance test completed"
                        '''
                    }
                }
            }
        }
    }
    
    post {
        always {
            echo '🧹 Cleaning up...'
            cleanWs()
        }
        
        success {
            echo '✅ Pipeline completed successfully!'
            
            emailext (
                subject: "✅ Deployment Success: ${env.JOB_NAME} - ${env.BUILD_NUMBER}",
                body: """
                    <h2>🎉 Deployment Successful!</h2>
                    <p><strong>Application:</strong> ${env.APP_NAME}</p>
                    <p><strong>Version:</strong> ${env.APP_VERSION}</p>
                    <p><strong>Branch:</strong> ${env.GIT_BRANCH}</p>
                    <p><strong>Commit:</strong> ${env.GIT_COMMIT_SHORT}</p>
                    <p><strong>Build URL:</strong> <a href="${env.BUILD_URL}">${env.BUILD_URL}</a></p>
                    <p><strong>Duration:</strong> ${currentBuild.durationString}</p>
                    
                    <h3>🔗 Application URLs:</h3>
                    <ul>
                        <li><strong>Staging:</strong> http://${env.STAGING_SERVER}</li>
                        <li><strong>Production:</strong> http://${env.PROD_SERVER}</li>
                    </ul>
                """,
                to: "${env.EMAIL_RECIPIENTS}",
                mimeType: 'text/html'
            )
            
            // Slack notification
            slackSend(
                channel: "${env.SLACK_CHANNEL}",
                color: 'good',
                message: "✅ *Deployment Success* - ${env.APP_NAME} v${env.APP_VERSION} deployed to production"
            )
        }
        
        failure {
            echo '❌ Pipeline failed!'
            
            emailext (
                subject: "❌ Deployment Failed: ${env.JOB_NAME} - ${env.BUILD_NUMBER}",
                body: """
                    <h2>❌ Deployment Failed!</h2>
                    <p><strong>Application:</strong> ${env.APP_NAME}</p>
                    <p><strong>Branch:</strong> ${env.GIT_BRANCH}</p>
                    <p><strong>Build URL:</strong> <a href="${env.BUILD_URL}">${env.BUILD_URL}</a></p>
                    <p><strong>Console Output:</strong> <a href="${env.BUILD_URL}console">View Logs</a></p>
                    
                    <p>Please check the build logs for details.</p>
                """,
                to: "${env.EMAIL_RECIPIENTS}",
                mimeType: 'text/html'
            )
            
            // Slack notification
            slackSend(
                channel: "${env.SLACK_CHANNEL}",
                color: 'danger',
                message: "❌ *Deployment Failed* - ${env.APP_NAME} build ${env.BUILD_NUMBER} failed"
            )
        }
        
        unstable {
            echo '⚠️ Pipeline completed with warnings'
            
            slackSend(
                channel: "${env.SLACK_CHANNEL}",
                color: 'warning',
                message: "⚠️ *Deployment Warning* - ${env.APP_NAME} build ${env.BUILD_NUMBER} completed with warnings"
            )
        }
    }
}
```

---

## 📊 **Expected Deliverables**

### **Technical Deliverables**
- ✅ **Complete Java Spring Boot Application** with REST APIs
- ✅ **Comprehensive Test Suite** (Unit + Integration tests)
- ✅ **Production-Ready Jenkinsfile** with all stages
- ✅ **AWS Infrastructure** (EC2, RDS, ALB, S3)
- ✅ **Deployment Scripts** for staging and production
- ✅ **Monitoring & Alerting** setup
- ✅ **Documentation** (README, API docs, runbooks)

### **Quality Metrics**
- ✅ **Test Coverage:** 80%+ code coverage
- ✅ **Build Success Rate:** 95%+ successful builds
- ✅ **Deployment Time:** < 10 minutes end-to-end
- ✅ **Zero Downtime:** Blue-green deployment capability
- ✅ **Security:** No critical vulnerabilities
- ✅ **Performance:** < 2 second response time

---

## 🎯 **Success Criteria**

### **Functional Requirements**
- [ ] Pipeline builds successfully from Git webhook
- [ ] All unit and integration tests pass
- [ ] Code coverage meets 80% threshold
- [ ] Application deploys to staging automatically
- [ ] Production deployment requires manual approval
- [ ] Health checks pass after deployment
- [ ] Rollback capability is functional
- [ ] Notifications work for all scenarios

### **Non-Functional Requirements**
- [ ] Pipeline completes in under 15 minutes
- [ ] Zero-downtime deployment achieved
- [ ] Security scans show no critical issues
- [ ] Monitoring dashboards are functional
- [ ] Documentation is complete and accurate

---

## 🏆 **Portfolio Value**

This project demonstrates:

### **Technical Excellence**
- 🎯 **Full-Stack DevOps** - Complete CI/CD implementation
- 🎯 **Cloud Architecture** - AWS infrastructure design
- 🎯 **Quality Engineering** - Comprehensive testing strategy
- 🎯 **Production Operations** - Monitoring and maintenance

### **Professional Skills**
- 🎯 **Project Management** - Complex project delivery
- 🎯 **Problem Solving** - End-to-end troubleshooting
- 🎯 **Documentation** - Professional technical writing
- 🎯 **Best Practices** - Industry-standard implementations

---

<div align="center">

### 🎯 **Ready to Build Your Masterpiece?**

*This project showcases enterprise-level DevOps skills and serves as a comprehensive portfolio piece demonstrating your mastery of Jenkins CI/CD and AWS deployment.*

---

### 🏆 **Upon Completion**
*You'll have built a production-ready CI/CD pipeline that demonstrates professional-level DevOps expertise and can be showcased to potential employers or clients.*

**🚀 Start Building Your Future!**

</div>
