# ☕ Project 3.2: Maven Style Jobs

<div align="center">

![Maven](https://img.shields.io/badge/Maven-Build-orange?style=for-the-badge&logo=apache-maven&logoColor=white)
![Java](https://img.shields.io/badge/Java-Application-red?style=for-the-badge&logo=java&logoColor=white)

**🎯 Java Build Automation | ☕ Maven Integration | 📦 Dependency Management**

</div>

---

## 📋 Project Overview

This project focuses on creating Maven-specific Jenkins jobs optimized for Java applications. You'll learn to leverage Jenkins' built-in Maven support for efficient Java project builds, testing, and artifact management.

### 🎯 **Learning Objectives**
- ✅ Create and configure Maven-specific Jenkins jobs
- ✅ Set up Maven tool integration in Jenkins
- ✅ Configure automated dependency management
- ✅ Implement Maven-based testing workflows
- ✅ Manage Java build artifacts effectively

---

## 📚 Theory: Maven Jobs in Jenkins

### **What are Maven Jobs?**
Maven jobs are specialized Jenkins job types designed specifically for Java projects that use Apache Maven as their build tool. They provide optimized integration with Maven's lifecycle and dependency management.

#### **Key Advantages over Freestyle Jobs:**
- ☕ **Java-Optimized** - Built specifically for Java/Maven projects
- 📦 **Automatic Dependency Management** - Handles Maven dependencies seamlessly
- 🧪 **Integrated Testing** - Built-in support for Maven test phases
- 📊 **Enhanced Reporting** - Better integration with Maven reports
- 🔄 **Maven Lifecycle Awareness** - Understands Maven phases and goals

#### **Maven Job Features:**
- 🎯 **POM-based Configuration** - Reads project configuration from pom.xml
- 📈 **Build Trends** - Historical build performance tracking
- 🧪 **Test Result Integration** - Automatic JUnit test result processing
- 📦 **Artifact Archiving** - Automatic artifact management
- 🔍 **Dependency Analysis** - Maven dependency tree visualization

---

## 🛠️ **Prerequisites Setup**

### **Step 1: Configure Maven in Jenkins**

1. **Navigate to Global Tool Configuration**
   - Go to "Manage Jenkins" → "Global Tool Configuration"
   - Find "Maven" section

2. **Add Maven Installation**
   ```
   Name: Maven-3.8.1
   Install automatically: ✅
   Version: 3.8.1
   ```

3. **Configure JDK**
   ```
   Name: JDK-11
   JAVA_HOME: /usr/lib/jvm/java-11-openjdk
   Install automatically: ✅ (if needed)
   ```

### **Step 2: Sample Maven Project Structure**
```
sample-java-app/
├── pom.xml
├── src/
│   ├── main/
│   │   └── java/
│   │       └── com/
│   │           └── example/
│   │               └── App.java
│   └── test/
│       └── java/
│           └── com/
│               └── example/
│                   └── AppTest.java
├── Jenkinsfile (optional)
└── README.md
```

### **Step 3: Sample pom.xml**
```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 
         http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    
    <groupId>com.example</groupId>
    <artifactId>sample-java-app</artifactId>
    <version>1.0.0</version>
    <packaging>jar</packaging>
    
    <name>Sample Java Application</name>
    <description>A sample Java application for Jenkins Maven job</description>
    
    <properties>
        <maven.compiler.source>11</maven.compiler.source>
        <maven.compiler.target>11</maven.compiler.target>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        <junit.version>5.8.2</junit.version>
    </properties>
    
    <dependencies>
        <!-- JUnit 5 for testing -->
        <dependency>
            <groupId>org.junit.jupiter</groupId>
            <artifactId>junit-jupiter</artifactId>
            <version>${junit.version}</version>
            <scope>test</scope>
        </dependency>
    </dependencies>
    
    <build>
        <plugins>
            <!-- Maven Compiler Plugin -->
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-compiler-plugin</artifactId>
                <version>3.8.1</version>
                <configuration>
                    <source>11</source>
                    <target>11</target>
                </configuration>
            </plugin>
            
            <!-- Maven Surefire Plugin for testing -->
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-surefire-plugin</artifactId>
                <version>3.0.0-M7</version>
                <configuration>
                    <includes>
                        <include>**/*Test.java</include>
                        <include>**/*Tests.java</include>
                    </includes>
                </configuration>
            </plugin>
            
            <!-- Maven JAR Plugin -->
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-jar-plugin</artifactId>
                <version>3.2.2</version>
                <configuration>
                    <archive>
                        <manifest>
                            <mainClass>com.example.App</mainClass>
                        </manifest>
                    </archive>
                </configuration>
            </plugin>
        </plugins>
    </build>
</project>
```

---

## 🚀 **Creating Maven Job**

### **Step 1: Create New Maven Job**

1. **Navigate to Jenkins Dashboard**
   - Click "New Item"
   - Enter job name: `maven-java-app-build`
   - Select "Maven project"
   - Click "OK"

### **Step 2: General Configuration**

```
Description: Maven-based Java application build job
GitHub project: https://github.com/your-username/sample-java-app
Discard old builds: Keep last 10 builds
```

### **Step 3: Source Code Management**

```bash
# Git Configuration
Repository URL: https://github.com/your-username/sample-java-app.git
Branch Specifier: */main
Credentials: (if private repository)

# Additional Behaviours
✅ Clean before checkout
✅ Check out to specific local branch: main
```

### **Step 4: Build Triggers**

```bash
# Option 1: Poll SCM (every 5 minutes)
Schedule: H/5 * * * *

# Option 2: GitHub webhook trigger
✅ GitHub hook trigger for GITScm polling

# Option 3: Build periodically (daily at 2 AM)
Schedule: 0 2 * * *
```

### **Step 5: Build Environment**

```bash
✅ Delete workspace before build starts
✅ Add timestamps to the Console Output

# Environment Variables
JAVA_HOME: /usr/lib/jvm/java-11-openjdk
MAVEN_OPTS: -Xmx1024m -XX:MaxPermSize=256m
```

### **Step 6: Build Configuration**

#### **Root POM:**
```
pom.xml
```

#### **Goals and Options:**
```bash
# For development builds
clean compile test package

# For release builds
clean compile test package install

# For deployment builds
clean compile test package deploy
```

#### **Advanced Options:**
```bash
# Maven Settings
Settings file: Use default maven settings
Global Settings file: Use default global settings

# Build Options
✅ Resolve dependencies during Pom parsing
✅ Process plugins during Pom parsing
✅ Incremental build - only build changed modules
```

### **Step 7: Post-build Actions**

#### **Archive Artifacts**
```
Files to archive: target/*.jar, target/*.war
```

#### **Publish JUnit Test Results**
```
Test report XMLs: target/surefire-reports/*.xml
Health report amplification factor: 1.0
```

#### **Email Notification**
```
Recipients: dev-team@company.com
Send email for: Failure, Unstable, Back to Normal
```

#### **Deploy to Repository**
```bash
# If using Maven deploy goal
Repository URL: http://nexus.company.com/repository/maven-releases/
Repository ID: nexus-releases
```

---

## 📊 **Advanced Maven Job Configuration**

### **Multi-Module Maven Project**

For projects with multiple modules:

```xml
<!-- Parent pom.xml -->
<modules>
    <module>core</module>
    <module>web</module>
    <module>api</module>
</modules>
```

**Jenkins Configuration:**
```bash
# Goals for multi-module build
clean compile test package -pl core,web,api

# Build specific modules only
clean compile test package -pl web -am

# Skip tests for specific modules
clean compile test package -DskipTests=true
```

### **Maven Profiles**

**pom.xml profiles:**
```xml
<profiles>
    <profile>
        <id>development</id>
        <activation>
            <activeByDefault>true</activeByDefault>
        </activation>
        <properties>
            <env>dev</env>
        </properties>
    </profile>
    
    <profile>
        <id>production</id>
        <properties>
            <env>prod</env>
        </properties>
    </profile>
</profiles>
```

**Jenkins Goals with Profiles:**
```bash
# Development build
clean compile test package -Pdevelopment

# Production build
clean compile test package -Pproduction

# Multiple profiles
clean compile test package -Pdevelopment,integration-test
```

### **Maven Job with Parameters**

Create parameterized Maven job:

```bash
# String Parameters
MAVEN_PROFILE: development (default)
BUILD_VERSION: 1.0.0-SNAPSHOT
DEPLOY_TARGET: staging

# Choice Parameters
BUILD_TYPE: [development, staging, production]
MAVEN_GOALS: [package, install, deploy]

# Boolean Parameters
SKIP_TESTS: false
RUN_INTEGRATION_TESTS: true
```

**Parameterized Goals:**
```bash
clean compile test ${MAVEN_GOALS} -P${MAVEN_PROFILE} -Dversion=${BUILD_VERSION} -DskipTests=${SKIP_TESTS}
```

---

## 🧪 **Testing Integration**

### **JUnit 5 Integration**

**Test Class Example:**
```java
package com.example;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.DisplayName;
import static org.junit.jupiter.api.Assertions.*;

public class AppTest {
    
    @Test
    @DisplayName("Should create app instance")
    public void shouldCreateAppInstance() {
        App app = new App();
        assertNotNull(app);
    }
    
    @Test
    @DisplayName("Should return correct greeting")
    public void shouldReturnCorrectGreeting() {
        App app = new App();
        String greeting = app.getGreeting();
        assertEquals("Hello World!", greeting);
    }
}
```

### **Maven Surefire Configuration**

```xml
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-surefire-plugin</artifactId>
    <version>3.0.0-M7</version>
    <configuration>
        <includes>
            <include>**/*Test.java</include>
            <include>**/*Tests.java</include>
        </includes>
        <excludes>
            <exclude>**/*IntegrationTest.java</exclude>
        </excludes>
        <reportFormat>xml</reportFormat>
        <useFile>false</useFile>
    </configuration>
</plugin>
```

---

## 📦 **Artifact Management**

### **Maven Repository Integration**

**Deploy to Nexus Repository:**
```xml
<distributionManagement>
    <repository>
        <id>nexus-releases</id>
        <url>http://nexus.company.com/repository/maven-releases/</url>
    </repository>
    <snapshotRepository>
        <id>nexus-snapshots</id>
        <url>http://nexus.company.com/repository/maven-snapshots/</url>
    </snapshotRepository>
</distributionManagement>
```

**Jenkins Deploy Configuration:**
```bash
# Maven goals for deployment
clean compile test package deploy

# Skip tests during deployment
clean compile test package deploy -DskipTests=true

# Deploy only (assuming artifacts are built)
deploy:deploy-file -Dfile=target/app.jar -DgroupId=com.example -DartifactId=sample-app
```

### **Artifact Archiving Strategy**

```bash
# Archive main artifacts
target/*.jar
target/*.war

# Archive additional files
target/site/**
target/generated-docs/**

# Archive with build number
target/*-${BUILD_NUMBER}.jar
```

---

## 🔍 **Monitoring & Troubleshooting**

### **Common Maven Job Issues**

#### **OutOfMemoryError**
```bash
# Solution: Increase Maven memory
MAVEN_OPTS: -Xmx2048m -XX:MaxPermSize=512m
```

#### **Dependency Resolution Failures**
```bash
# Clear local repository
rm -rf ~/.m2/repository

# Force update dependencies
mvn clean compile -U

# Use specific repository
mvn clean compile -Dmaven.repo.remote=http://repo1.maven.org/maven2
```

#### **Test Failures**
```bash
# Run tests with detailed output
mvn test -Dsurefire.printSummary=true

# Skip tests temporarily
mvn clean package -DskipTests=true

# Run specific test
mvn test -Dtest=AppTest
```

### **Build Performance Optimization**

```bash
# Parallel builds
mvn clean package -T 4

# Offline mode (skip dependency checks)
mvn clean package -o

# Skip unnecessary plugins
mvn clean package -Dmaven.javadoc.skip=true -Dmaven.source.skip=true
```

---

## 📊 **Expected Outcomes**

After completing this project, you will have:

### **Working Maven Job**
- ✅ **Functional Maven job** building Java applications
- ✅ **Automated dependency management** working correctly
- ✅ **Test integration** with JUnit reporting
- ✅ **Artifact archiving** and deployment

### **Advanced Skills**
- ✅ **Maven Lifecycle Understanding** - Knowledge of Maven phases
- ✅ **Dependency Management** - Handling Maven dependencies
- ✅ **Multi-module Builds** - Managing complex project structures
- ✅ **Profile Management** - Environment-specific builds

---

## 🎯 **Best Practices**

### **Maven Job Configuration**
- 📝 **Clear Goals** - Use appropriate Maven goals for each job
- 🔄 **Profile Usage** - Leverage Maven profiles for different environments
- 📦 **Artifact Management** - Proper artifact archiving and deployment
- 🧪 **Test Integration** - Comprehensive test execution and reporting

### **Performance Optimization**
- ⚡ **Parallel Builds** - Use Maven parallel execution
- 💾 **Dependency Caching** - Leverage Maven local repository
- 🎯 **Selective Building** - Build only changed modules
- 📊 **Resource Management** - Monitor memory and CPU usage

---

## ➡️ **Next Steps**

Once you've mastered Maven jobs:

1. **Experiment with Multi-module Projects** - Try complex project structures
2. **Integrate with Nexus Repository** - Set up artifact repository
3. **Add Code Quality Tools** - Integrate SonarQube, Checkstyle
4. **Proceed to Pipeline Fundamentals** - [Module 04: Pipeline Fundamentals](../../04_pipeline_fundamentals/README.md)

---

## 📚 **Additional Resources**

- 📖 [Jenkins Maven Project Documentation](https://www.jenkins.io/doc/book/using/using-maven/)
- 📖 [Apache Maven Documentation](https://maven.apache.org/guides/)
- 📖 [Maven Surefire Plugin](https://maven.apache.org/surefire/maven-surefire-plugin/)

---

<div align="center">

### 🎯 **Excellent Work!**
*You've mastered Maven integration with Jenkins! This is essential for Java development workflows.*

**Next: [Module 04 - Pipeline Fundamentals](../../04_pipeline_fundamentals/README.md)**

</div>
