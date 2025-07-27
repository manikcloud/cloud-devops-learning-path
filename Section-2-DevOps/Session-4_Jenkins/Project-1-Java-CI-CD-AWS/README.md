# 🚀 Project 1: Java Application CI/CD with Jenkins and AWS

![Java CI/CD Architecture](./images/java-cicd-architecture.svg)

## 🎯 Project Overview

Build a complete CI/CD pipeline for a Spring Boot Java application using Jenkins and deploy to AWS infrastructure. This project demonstrates enterprise-grade DevOps practices with automated testing, security scanning, and multi-environment deployments.

### 🏗️ Architecture Components

```
GitHub → Jenkins → Build → Test → Security Scan → Deploy to AWS ECS → Monitor
```

## 📋 Prerequisites

### 🛠️ Required Tools
- **Jenkins Server** (2.400+)
- **Java 11+** and **Maven 3.6+**
- **Docker** and **Docker Compose**
- **AWS CLI** configured with appropriate permissions
- **Git** for version control

### ☁️ AWS Services Used
- **Amazon ECS** - Container orchestration
- **Amazon ECR** - Docker image registry
- **Application Load Balancer** - Traffic distribution
- **Amazon RDS** - Database service
- **CloudWatch** - Monitoring and logging
- **IAM** - Security and access management

### 🔑 Required AWS Permissions
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ecr:*",
        "ecs:*",
        "iam:PassRole",
        "logs:*",
        "cloudwatch:*"
      ],
      "Resource": "*"
    }
  ]
}
```

## 🏃‍♂️ Quick Start

### Step 1: Clone the Repository
```bash
git clone https://github.com/your-org/spring-boot-demo.git
cd spring-boot-demo
```

### Step 2: Set Up Jenkins Pipeline
```bash
# Create new Pipeline job in Jenkins
# Point to your repository
# Use Jenkinsfile from repository root
```

### Step 3: Configure AWS Credentials
```bash
# In Jenkins, go to Manage Jenkins > Manage Credentials
# Add AWS credentials with ID: 'aws-credentials'
```

## 📁 Project Structure

```
spring-boot-demo/
├── src/
│   ├── main/java/com/example/demo/
│   │   ├── DemoApplication.java
│   │   ├── controller/
│   │   ├── service/
│   │   └── repository/
│   └── test/java/com/example/demo/
├── Dockerfile
├── docker-compose.yml
├── Jenkinsfile
├── pom.xml
├── k8s/
│   ├── deployment.yaml
│   ├── service.yaml
│   └── ingress.yaml
└── scripts/
    ├── deploy-staging.sh
    └── deploy-production.sh
```

## 🔧 Jenkins Pipeline Configuration

### Complete Jenkinsfile
```groovy
pipeline {
    agent any
    
    environment {
        AWS_REGION = 'us-east-1'
        ECR_REPOSITORY = 'spring-boot-demo'
        ECS_CLUSTER = 'production-cluster'
        ECS_SERVICE = 'spring-boot-service'
        AWS_ACCOUNT_ID = credentials('aws-account-id')
        SONAR_TOKEN = credentials('sonar-token')
    }
    
    tools {
        maven 'Maven-3.8.6'
        jdk 'OpenJDK-11'
    }
    
    stages {
        stage('🔍 Checkout') {
            steps {
                checkout scm
                script {
                    env.GIT_COMMIT_SHORT = sh(
                        script: "git rev-parse --short HEAD",
                        returnStdout: true
                    ).trim()
                }
            }
        }
        
        stage('🏗️ Build') {
            steps {
                sh '''
                    echo "Building Spring Boot application..."
                    mvn clean compile -DskipTests
                '''
            }
        }
        
        stage('🧪 Test') {
            parallel {
                stage('Unit Tests') {
                    steps {
                        sh 'mvn test'
                    }
                    post {
                        always {
                            publishTestResults testResultsPattern: 'target/surefire-reports/*.xml'
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
                        sh '''
                            echo "Running integration tests..."
                            mvn verify -P integration-tests
                        '''
                    }
                }
                
                stage('Security Scan') {
                    steps {
                        script {
                            sh '''
                                echo "Running OWASP dependency check..."
                                mvn org.owasp:dependency-check-maven:check
                            '''
                        }
                    }
                    post {
                        always {
                            publishHTML([
                                allowMissing: false,
                                alwaysLinkToLastBuild: true,
                                keepAll: true,
                                reportDir: 'target',
                                reportFiles: 'dependency-check-report.html',
                                reportName: 'Security Scan Report'
                            ])
                        }
                    }
                }
            }
        }
        
        stage('📊 Code Quality') {
            steps {
                script {
                    def scannerHome = tool 'SonarQubeScanner'
                    withSonarQubeEnv('SonarQube') {
                        sh """
                            ${scannerHome}/bin/sonar-scanner \
                                -Dsonar.projectKey=spring-boot-demo \
                                -Dsonar.sources=src/main/java \
                                -Dsonar.tests=src/test/java \
                                -Dsonar.java.binaries=target/classes \
                                -Dsonar.junit.reportPaths=target/surefire-reports \
                                -Dsonar.jacoco.reportPaths=target/site/jacoco/jacoco.xml
                        """
                    }
                }
            }
        }
        
        stage('📦 Package') {
            steps {
                sh '''
                    echo "Packaging application..."
                    mvn package -DskipTests
                '''
                archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
            }
        }
        
        stage('🐳 Docker Build & Push') {
            steps {
                script {
                    // Login to ECR
                    sh '''
                        aws ecr get-login-password --region ${AWS_REGION} | \
                        docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com
                    '''
                    
                    // Build and tag image
                    def image = docker.build("${ECR_REPOSITORY}:${BUILD_NUMBER}")
                    
                    // Push to ECR
                    docker.withRegistry("https://${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com") {
                        image.push("${BUILD_NUMBER}")
                        image.push("latest")
                        image.push("${GIT_COMMIT_SHORT}")
                    }
                }
            }
        }
        
        stage('🚀 Deploy to Staging') {
            steps {
                script {
                    sh '''
                        echo "Deploying to staging environment..."
                        aws ecs update-service \
                            --cluster ${ECS_CLUSTER}-staging \
                            --service ${ECS_SERVICE} \
                            --task-definition spring-boot-demo:${BUILD_NUMBER} \
                            --force-new-deployment \
                            --region ${AWS_REGION}
                        
                        echo "Waiting for deployment to complete..."
                        aws ecs wait services-stable \
                            --cluster ${ECS_CLUSTER}-staging \
                            --services ${ECS_SERVICE} \
                            --region ${AWS_REGION}
                    '''
                }
            }
        }
        
        stage('🔍 Smoke Tests') {
            steps {
                script {
                    sh '''
                        echo "Running smoke tests against staging..."
                        # Get the staging URL
                        STAGING_URL=$(aws elbv2 describe-load-balancers \
                            --names staging-alb \
                            --query 'LoadBalancers[0].DNSName' \
                            --output text \
                            --region ${AWS_REGION})
                        
                        # Health check
                        curl -f http://${STAGING_URL}/actuator/health || exit 1
                        
                        # Basic functionality test
                        curl -f http://${STAGING_URL}/api/users || exit 1
                        
                        echo "Smoke tests passed!"
                    '''
                }
            }
        }
        
        stage('🎯 Deploy to Production') {
            when {
                branch 'main'
            }
            steps {
                input message: 'Deploy to production?', ok: 'Deploy',
                      submitterParameter: 'DEPLOYER'
                
                script {
                    sh '''
                        echo "Deploying to production environment..."
                        echo "Deployed by: ${DEPLOYER}"
                        
                        # Blue-Green deployment strategy
                        aws ecs update-service \
                            --cluster ${ECS_CLUSTER} \
                            --service ${ECS_SERVICE} \
                            --task-definition spring-boot-demo:${BUILD_NUMBER} \
                            --deployment-configuration maximumPercent=200,minimumHealthyPercent=50 \
                            --region ${AWS_REGION}
                        
                        echo "Waiting for production deployment..."
                        aws ecs wait services-stable \
                            --cluster ${ECS_CLUSTER} \
                            --services ${ECS_SERVICE} \
                            --region ${AWS_REGION}
                    '''
                }
            }
        }
    }
    
    post {
        always {
            cleanWs()
        }
        
        success {
            slackSend(
                channel: '#deployments',
                color: 'good',
                message: """
                ✅ *Deployment Successful*
                *Project:* ${env.JOB_NAME}
                *Build:* ${env.BUILD_NUMBER}
                *Branch:* ${env.BRANCH_NAME}
                *Commit:* ${env.GIT_COMMIT_SHORT}
                *Duration:* ${currentBuild.durationString}
                """.stripIndent()
            )
        }
        
        failure {
            slackSend(
                channel: '#deployments',
                color: 'danger',
                message: """
                ❌ *Deployment Failed*
                *Project:* ${env.JOB_NAME}
                *Build:* ${env.BUILD_NUMBER}
                *Branch:* ${env.BRANCH_NAME}
                *Commit:* ${env.GIT_COMMIT_SHORT}
                *Check:* ${env.BUILD_URL}
                """.stripIndent()
            )
        }
        
        unstable {
            slackSend(
                channel: '#deployments',
                color: 'warning',
                message: """
                ⚠️ *Build Unstable*
                *Project:* ${env.JOB_NAME}
                *Build:* ${env.BUILD_NUMBER}
                *Issues:* Check test results
                """.stripIndent()
            )
        }
    }
}
```

## 🐳 Docker Configuration

### Dockerfile
```dockerfile
FROM openjdk:11-jre-slim

# Set working directory
WORKDIR /app

# Copy the JAR file
COPY target/spring-boot-demo-*.jar app.jar

# Create non-root user
RUN groupadd -r appuser && useradd -r -g appuser appuser
RUN chown -R appuser:appuser /app
USER appuser

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:8080/actuator/health || exit 1

# Expose port
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
```

### docker-compose.yml (for local development)
```yaml
version: '3.8'

services:
  app:
    build: .
    ports:
      - "8080:8080"
    environment:
      - SPRING_PROFILES_ACTIVE=local
      - DB_HOST=db
      - DB_PORT=5432
      - DB_NAME=demo
      - DB_USER=demo
      - DB_PASSWORD=demo123
    depends_on:
      - db
    networks:
      - app-network

  db:
    image: postgres:13
    environment:
      - POSTGRES_DB=demo
      - POSTGRES_USER=demo
      - POSTGRES_PASSWORD=demo123
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data
    networks:
      - app-network

volumes:
  postgres_data:

networks:
  app-network:
    driver: bridge
```

## ☁️ AWS Infrastructure Setup

### ECS Task Definition
```json
{
  "family": "spring-boot-demo",
  "networkMode": "awsvpc",
  "requiresCompatibilities": ["FARGATE"],
  "cpu": "512",
  "memory": "1024",
  "executionRoleArn": "arn:aws:iam::ACCOUNT:role/ecsTaskExecutionRole",
  "taskRoleArn": "arn:aws:iam::ACCOUNT:role/ecsTaskRole",
  "containerDefinitions": [
    {
      "name": "spring-boot-demo",
      "image": "ACCOUNT.dkr.ecr.us-east-1.amazonaws.com/spring-boot-demo:latest",
      "portMappings": [
        {
          "containerPort": 8080,
          "protocol": "tcp"
        }
      ],
      "essential": true,
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "/ecs/spring-boot-demo",
          "awslogs-region": "us-east-1",
          "awslogs-stream-prefix": "ecs"
        }
      },
      "environment": [
        {
          "name": "SPRING_PROFILES_ACTIVE",
          "value": "production"
        }
      ],
      "healthCheck": {
        "command": [
          "CMD-SHELL",
          "curl -f http://localhost:8080/actuator/health || exit 1"
        ],
        "interval": 30,
        "timeout": 5,
        "retries": 3,
        "startPeriod": 60
      }
    }
  ]
}
```

## 📊 Monitoring and Observability

### CloudWatch Dashboard
```json
{
  "widgets": [
    {
      "type": "metric",
      "properties": {
        "metrics": [
          ["AWS/ECS", "CPUUtilization", "ServiceName", "spring-boot-service"],
          [".", "MemoryUtilization", ".", "."]
        ],
        "period": 300,
        "stat": "Average",
        "region": "us-east-1",
        "title": "ECS Service Metrics"
      }
    },
    {
      "type": "log",
      "properties": {
        "query": "SOURCE '/ecs/spring-boot-demo' | fields @timestamp, @message | filter @message like /ERROR/ | sort @timestamp desc | limit 20",
        "region": "us-east-1",
        "title": "Application Errors"
      }
    }
  ]
}
```

## 🧪 Testing Strategy

### Unit Tests
```java
@SpringBootTest
class UserServiceTest {
    
    @MockBean
    private UserRepository userRepository;
    
    @Autowired
    private UserService userService;
    
    @Test
    void shouldCreateUser() {
        // Given
        User user = new User("john@example.com", "John Doe");
        when(userRepository.save(any(User.class))).thenReturn(user);
        
        // When
        User result = userService.createUser("john@example.com", "John Doe");
        
        // Then
        assertThat(result.getEmail()).isEqualTo("john@example.com");
        assertThat(result.getName()).isEqualTo("John Doe");
    }
}
```

### Integration Tests
```java
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
@Testcontainers
class UserControllerIntegrationTest {
    
    @Container
    static PostgreSQLContainer<?> postgres = new PostgreSQLContainer<>("postgres:13")
            .withDatabaseName("testdb")
            .withUsername("test")
            .withPassword("test");
    
    @Autowired
    private TestRestTemplate restTemplate;
    
    @Test
    void shouldCreateAndRetrieveUser() {
        // Create user
        User user = new User("jane@example.com", "Jane Doe");
        ResponseEntity<User> createResponse = restTemplate.postForEntity("/api/users", user, User.class);
        
        assertThat(createResponse.getStatusCode()).isEqualTo(HttpStatus.CREATED);
        
        // Retrieve user
        ResponseEntity<User> getResponse = restTemplate.getForEntity(
            "/api/users/" + createResponse.getBody().getId(), User.class);
        
        assertThat(getResponse.getStatusCode()).isEqualTo(HttpStatus.OK);
        assertThat(getResponse.getBody().getEmail()).isEqualTo("jane@example.com");
    }
}
```

## 🚀 Deployment Strategies

### Blue-Green Deployment
```bash
#!/bin/bash
# Blue-Green deployment script

CLUSTER_NAME="production-cluster"
SERVICE_NAME="spring-boot-service"
NEW_TASK_DEFINITION="spring-boot-demo:${BUILD_NUMBER}"

echo "Starting Blue-Green deployment..."

# Update service with new task definition
aws ecs update-service \
    --cluster $CLUSTER_NAME \
    --service $SERVICE_NAME \
    --task-definition $NEW_TASK_DEFINITION \
    --deployment-configuration maximumPercent=200,minimumHealthyPercent=50

# Wait for deployment to stabilize
aws ecs wait services-stable \
    --cluster $CLUSTER_NAME \
    --services $SERVICE_NAME

echo "Blue-Green deployment completed successfully!"
```

## 📈 Performance Optimization

### JVM Tuning
```dockerfile
# Optimized JVM settings for containerized Spring Boot
ENV JAVA_OPTS="-XX:+UseContainerSupport \
               -XX:MaxRAMPercentage=75.0 \
               -XX:+UseG1GC \
               -XX:+UseStringDeduplication \
               -XX:+PrintGCDetails \
               -XX:+PrintGCTimeStamps"

ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]
```

## 🔒 Security Best Practices

### Security Scanning Integration
```groovy
stage('Security Scan') {
    parallel {
        stage('Dependency Check') {
            steps {
                sh 'mvn org.owasp:dependency-check-maven:check'
            }
        }
        stage('Container Scan') {
            steps {
                script {
                    sh '''
                        # Scan Docker image for vulnerabilities
                        docker run --rm -v /var/run/docker.sock:/var/run/docker.sock \
                            aquasec/trivy image ${ECR_REPOSITORY}:${BUILD_NUMBER}
                    '''
                }
            }
        }
        stage('Code Security') {
            steps {
                sh '''
                    # Static code analysis for security issues
                    mvn spotbugs:check
                '''
            }
        }
    }
}
```

## 🎯 Success Metrics

### Key Performance Indicators
- **Build Success Rate**: > 95%
- **Deployment Frequency**: Multiple times per day
- **Lead Time**: < 2 hours from commit to production
- **Mean Time to Recovery**: < 30 minutes
- **Test Coverage**: > 80%

### Monitoring Alerts
```yaml
# CloudWatch Alarms
ApplicationErrorRate:
  Type: AWS::CloudWatch::Alarm
  Properties:
    AlarmName: SpringBootDemo-HighErrorRate
    MetricName: 4XXError
    Namespace: AWS/ApplicationELB
    Statistic: Sum
    Period: 300
    EvaluationPeriods: 2
    Threshold: 10
    ComparisonOperator: GreaterThanThreshold

ResponseTimeAlarm:
  Type: AWS::CloudWatch::Alarm
  Properties:
    AlarmName: SpringBootDemo-HighResponseTime
    MetricName: TargetResponseTime
    Namespace: AWS/ApplicationELB
    Statistic: Average
    Period: 300
    EvaluationPeriods: 2
    Threshold: 2.0
    ComparisonOperator: GreaterThanThreshold
```

## 🎓 Learning Outcomes

After completing this project, you will have mastered:

1. **Enterprise CI/CD Patterns**: Industry-standard pipeline design
2. **AWS Integration**: ECS, ECR, CloudWatch, and more
3. **Security Integration**: Automated security scanning and compliance
4. **Testing Strategies**: Comprehensive test automation
5. **Monitoring & Observability**: Production-ready monitoring setup
6. **Deployment Strategies**: Blue-Green and Canary deployments

## 🔗 Additional Resources

- [Spring Boot Documentation](https://spring.io/projects/spring-boot)
- [AWS ECS Best Practices](https://docs.aws.amazon.com/AmazonECS/latest/bestpracticesguide/)
- [Jenkins Pipeline Documentation](https://www.jenkins.io/doc/book/pipeline/)
- [Docker Best Practices](https://docs.docker.com/develop/dev-best-practices/)

---

**🎉 Ready to build enterprise-grade CI/CD pipelines? Let's get started!**
