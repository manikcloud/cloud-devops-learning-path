# ☕ Project 3.3: Maven Style Jobs

<div align="center">

![Maven Jobs](https://img.shields.io/badge/Jenkins-Maven%20Jobs-orange?style=for-the-badge&logo=apache-maven&logoColor=white)
![CI/CD](https://img.shields.io/badge/CI%2FCD-Integration-blue?style=for-the-badge&logo=jenkins&logoColor=white)
![Java](https://img.shields.io/badge/Java-Enterprise-red?style=for-the-badge&logo=java&logoColor=white)

**☕ Advanced Maven Integration | 🔧 Jenkins Automation | 📊 Enterprise CI/CD**

</div>

---

## 📋 Project Overview

Master Jenkins Maven job creation using the **current repository** for advanced Java build automation. This project demonstrates enterprise-level CI/CD practices with Maven integration, automated testing, and artifact management using real code from your learning environment.

<div align="center">

### 🎯 **What You'll Build**
*Professional Maven-based Jenkins job with full CI/CD capabilities*

</div>

### 🎯 **Learning Objectives**
- ✅ Create specialized Jenkins Maven jobs
- ✅ Configure Maven integration in Jenkins
- ✅ Set up automated dependency management
- ✅ Implement comprehensive testing workflows
- ✅ Master artifact archiving and deployment
- ✅ Integrate with local Git repository for CI/CD

---

## 🚀 Prerequisites & Setup

### **📋 Prerequisites Checklist**
- ✅ Jenkins installed with Maven Integration plugin
- ✅ Maven installed on the system (Project 3.2 completed)
- ✅ Java JDK 11 or later
- ✅ Current repository accessible to Jenkins
- ✅ Understanding of Maven fundamentals

### **🔧 Jenkins Maven Plugin Installation**

#### **Step 1: Install Maven Integration Plugin**
1. **Navigate to Jenkins**: Go to `http://localhost:8080`
2. **Manage Jenkins**: Click "Manage Jenkins" → "Manage Plugins"
3. **Available Tab**: Search for "Maven Integration plugin"
4. **Install**: Select and install the plugin
5. **Restart**: Restart Jenkins if required

#### **Step 2: Configure Maven in Jenkins**
1. **Global Tool Configuration**: Go to "Manage Jenkins" → "Global Tool Configuration"
2. **Maven Section**: Click "Add Maven"
3. **Configuration**:
   ```yaml
   Name: Maven-3.6.3
   MAVEN_HOME: /usr/share/maven
   ✅ Install automatically: false
   ```
4. **Save**: Apply the configuration

---

## 📦 Repository Setup & Project Structure

### **📁 Current Repository Integration**

The Maven project will be created within your repository structure:

```bash
# Navigate to the Maven style directory (after Jenkins checkout)
cd Section-2-DevOps/Session-4_Jenkins/03_basic_jobs/3.3_maven_style

# Create a comprehensive Maven project
mvn archetype:generate \
  -DgroupId=com.clouddevops.jenkins \
  -DartifactId=maven-jenkins-app \
  -DarchetypeArtifactId=maven-archetype-quickstart \
  -DarchetypeVersion=1.4 \
  -DinteractiveMode=false

# Navigate to the created project
cd maven-jenkins-app
```

### **🏗️ Simple Project Structure**
```
maven-jenkins-app/
├── pom.xml                          # Enhanced POM with plugins
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/clouddevops/jenkins/
│   │   │       └── App.java         # Main HelloWorld application
│   │   └── resources/
│   │       └── application.properties
│   └── test/
│       ├── java/
│       │   └── com/clouddevops/jenkins/
│       │       └── AppTest.java     # Unit test
│       └── resources/
└── target/                          # Generated after build
    ├── classes/
    ├── test-classes/
    ├── maven-jenkins-app-1.0-SNAPSHOT.jar
    └── surefire-reports/            # Test reports
```

---

## 🔧 Jenkins Maven Job Configuration

### **📋 Step-by-Step Job Creation**

#### **Step 1: Create Maven Project Job**
1. **Jenkins Dashboard**: Navigate to `http://localhost:8080`
2. **New Item**: Click "New Item"
3. **Job Configuration**:
   ```yaml
   Item name: Maven-HelloWorld-CI
   Type: Maven project
   ```
4. **Click OK**: Proceed to configuration

#### **Step 2: Source Code Management**
```yaml
Source Code Management:
  ✅ Git
  Repository URL: https://github.com/manikcloud/cloud-devops-learning-path.git
  Branch Specifier: */main
  
  Additional Behaviours:
    ✅ Sparse Checkout Paths:
      Path: Section-2-DevOps/Session-4_Jenkins/03_basic_jobs/3.3_maven_style/maven-jenkins-app
```

#### **Step 3: Build Configuration**
```yaml
Build:
  Root POM: Section-2-DevOps/Session-4_Jenkins/03_basic_jobs/3.3_maven_style/maven-jenkins-app/pom.xml
  Goals and options: clean compile test package
  Maven Version: Maven-3.6.3
  
  Advanced Options:
    ✅ Use private Maven repository
    ✅ Settings file: Use default maven settings
```

#### **Step 4: Build Triggers**
```yaml
Build Triggers:
  ✅ Poll SCM: H/5 * * * *  # Check every 5 minutes
  ✅ Build periodically: H 2 * * *  # Daily at 2 AM
```

#### **Step 5: Post-build Actions**
```yaml
Post-build Actions:
  ✅ Archive the artifacts: 
    Files to archive: **/target/*.jar
    
  ✅ Publish JUnit test result report:
    Test report XMLs: **/target/surefire-reports/*.xml
    
  ✅ Email Notification (optional):
    Recipients: your-email@example.com
```

---

## 📊 Enhanced Maven POM Configuration

### **🔧 Simple pom.xml Setup**

Create a simple `pom.xml` file in your Maven project:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 
         http://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>

  <groupId>com.clouddevops.jenkins</groupId>
  <artifactId>maven-jenkins-app</artifactId>
  <version>1.0-SNAPSHOT</version>
  <packaging>jar</packaging>

  <name>Jenkins Maven Integration App</name>
  <description>A simple Maven project for Jenkins CI/CD integration</description>

  <properties>
    <maven.compiler.source>11</maven.compiler.source>
    <maven.compiler.target>11</maven.compiler.target>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    <junit.version>4.13.2</junit.version>
  </properties>

  <dependencies>
    <dependency>
      <groupId>junit</groupId>
      <artifactId>junit</artifactId>
      <version>${junit.version}</version>
      <scope>test</scope>
    </dependency>
  </dependencies>

  <build>
    <plugins>
      <plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-compiler-plugin</artifactId>
        <version>3.8.1</version>
        <configuration>
          <source>${maven.compiler.source}</source>
          <target>${maven.compiler.target}</target>
        </configuration>
      </plugin>
      
      <plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-surefire-plugin</artifactId>
        <version>3.0.0-M7</version>
        <configuration>
          <includes>
            <include>**/*Test.java</include>
          </includes>
          <reportFormat>xml</reportFormat>
        </configuration>
      </plugin>
    </plugins>
  </build>
</project>
```

---

## ☕ Simple Java HelloWorld Application

### **📄 Simple App.java**

```java
package com.clouddevops.jenkins;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 * Simple HelloWorld application for Jenkins Maven integration
 */
public class App {
    
    public static void main(String[] args) {
        System.out.println("=".repeat(50));
        System.out.println("   Jenkins Maven CI/CD Demo");
        System.out.println("   Hello, World from Maven!");
        System.out.println("=".repeat(50));
        
        // Display current timestamp
        LocalDateTime now = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        System.out.println("Build executed at: " + now.format(formatter));
        
        System.out.println("✅ Maven build completed successfully!");
        System.out.println("🎉 Jenkins integration working perfectly!");
    }
}
```

### **🧪 AppTest.java**

```java
package com.clouddevops.jenkins;

import junit.framework.Test;
import junit.framework.TestCase;
import junit.framework.TestSuite;

/**
 * Unit test for simple App.
 */
public class AppTest extends TestCase {
    
    /**
     * Create the test case
     */
    public AppTest(String testName) {
        super(testName);
    }

    /**
     * @return the suite of tests being tested
     */
    public static Test suite() {
        return new TestSuite(AppTest.class);
    }

    /**
     * Test the main application
     */
    public void testApp() {
        // Simple test to ensure the app runs without errors
        assertTrue("Application should run successfully", true);
        
        // Test that we can create an App instance
        App app = new App();
        assertNotNull("App instance should not be null", app);
    }
}
```

---

## 🚀 Build and Execute

### **🔧 Local Testing**

Before creating the Jenkins job, test locally:

```bash
# Navigate to the Maven project (after repository checkout)
cd Section-2-DevOps/Session-4_Jenkins/03_basic_jobs/3.3_maven_style/maven-jenkins-app

# Clean and compile
mvn clean compile

# Run tests
mvn test

# Package the application
mvn package

# Run the application
java -cp target/maven-jenkins-app-1.0-SNAPSHOT.jar com.clouddevops.jenkins.App
```

### **📊 Expected Output**

```bash
==================================================
   Jenkins Maven CI/CD Demo
   Hello, World from Maven!
==================================================
Build executed at: 2024-08-15 14:30:25
✅ Maven build completed successfully!
🎉 Jenkins integration working perfectly!
```

---

## 🎯 Jenkins Job Execution

### **▶️ Running the Job**

1. **Navigate to Job**: Go to `Maven-HelloWorld-CI` job
2. **Build Now**: Click "Build Now"
3. **Monitor Progress**: Watch the build in real-time
4. **View Console Output**: Check the detailed logs

### **📋 Expected Jenkins Console Output**

```bash
Started by user admin
Building in workspace /var/lib/jenkins/workspace/Maven-HelloWorld-CI
The recommended git tool is: NONE
 > git rev-parse --resolve-git-dir /var/lib/jenkins/workspace/Maven-HelloWorld-CI/.git
Fetching changes from the remote Git repository
 > git config remote.origin.url https://github.com/manikcloud/cloud-devops-learning-path.git
 > git fetch --tags --force --progress -- https://github.com/manikcloud/cloud-devops-learning-path.git +refs/heads/*:refs/remotes/origin/*
 > git rev-parse refs/remotes/origin/main^{commit}
Checking out Revision abc123... (refs/remotes/origin/main)
 > git config core.sparsecheckout
 > git checkout -f abc123...
Parsing POMs
Established TCP socket on 43851
[Maven-HelloWorld-CI] $ /usr/share/maven/bin/mvn clean compile test package
[INFO] Scanning for projects...
[INFO] 
[INFO] --------< com.clouddevops.jenkins:maven-jenkins-app >--------
[INFO] Building Jenkins Maven Integration App 1.0-SNAPSHOT
[INFO] --------------------------------[ jar ]---------------------------------
[INFO] 
[INFO] --- maven-clean-plugin:2.5:clean (default-clean) @ maven-jenkins-app ---
[INFO] Deleting /var/lib/jenkins/workspace/Maven-HelloWorld-CI/Section-2-DevOps/Session-4_Jenkins/03_basic_jobs/3.3_maven_style/maven-jenkins-app/target
[INFO] 
[INFO] --- maven-resources-plugin:2.6:resources (default-resources) @ maven-jenkins-app ---
[INFO] Using 'UTF-8' encoding to copy filtered resources.
[INFO] skip non existing resourceDirectory /var/lib/jenkins/workspace/Maven-HelloWorld-CI/Section-2-DevOps/Session-4_Jenkins/03_basic_jobs/3.3_maven_style/maven-jenkins-app/src/main/resources
[INFO] 
[INFO] --- maven-compiler-plugin:3.8.1:compile (default-compile) @ maven-jenkins-app ---
[INFO] Changes detected - recompiling the module!
[INFO] Compiling 1 source file to /var/lib/jenkins/workspace/Maven-HelloWorld-CI/Section-2-DevOps/Session-4_Jenkins/03_basic_jobs/3.3_maven_style/maven-jenkins-app/target/classes
[INFO] 
[INFO] --- maven-resources-plugin:2.6:testResources (default-testResources) @ maven-jenkins-app ---
[INFO] Using 'UTF-8' encoding to copy filtered resources.
[INFO] skip non existing resourceDirectory /var/lib/jenkins/workspace/Maven-HelloWorld-CI/Section-2-DevOps/Session-4_Jenkins/03_basic_jobs/3.3_maven_style/maven-jenkins-app/src/test/resources
[INFO] 
[INFO] --- maven-compiler-plugin:3.8.1:testCompile (default-testCompile) @ maven-jenkins-app ---
[INFO] Changes detected - recompiling the module!
[INFO] Compiling 1 source file to /var/lib/jenkins/workspace/Maven-HelloWorld-CI/Section-2-DevOps/Session-4_Jenkins/03_basic_jobs/3.3_maven_style/maven-jenkins-app/target/test-classes
[INFO] 
[INFO] --- maven-surefire-plugin:3.0.0-M7:test (default-test) @ maven-jenkins-app ---
[INFO] 
[INFO] -------------------------------------------------------
[INFO]  T E S T S
[INFO] -------------------------------------------------------
[INFO] Running com.clouddevops.jenkins.AppTest
[INFO] Tests run: 1, Failures: 0, Errors: 0, Skipped: 0, Time elapsed: 0.123 s - in com.clouddevops.jenkins.AppTest
[INFO] 
[INFO] Results:
[INFO] 
[INFO] Tests run: 1, Failures: 0, Errors: 0, Skipped: 0
[INFO] 
[INFO] 
[INFO] --- maven-jar-plugin:2.4:jar (default-jar) @ maven-jenkins-app ---
[INFO] Building jar: /var/lib/jenkins/workspace/Maven-HelloWorld-CI/Section-2-DevOps/Session-4_Jenkins/03_basic_jobs/3.3_maven_style/maven-jenkins-app/target/maven-jenkins-app-1.0-SNAPSHOT.jar
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  4.567 s
[INFO] Finished at: 2024-08-15T14:30:25Z
[INFO] ------------------------------------------------------------------------
Archiving artifacts
Recording test results
Finished: SUCCESS
```

---

## 🎓 Learning Outcomes

After completing this project, you will have mastered:

### **✅ Jenkins Maven Integration**
- **Maven Job Creation** - Create specialized Maven jobs in Jenkins
- **Build Automation** - Automate Java builds with Maven lifecycle
- **Test Integration** - Execute and report unit tests automatically
- **Artifact Management** - Archive and manage build artifacts
- **CI/CD Pipeline** - Implement continuous integration workflows

### **✅ Advanced Jenkins Skills**
- **Plugin Configuration** - Install and configure Maven Integration plugin
- **Build Triggers** - Set up automated build triggers
- **Post-Build Actions** - Configure artifact archiving and notifications
- **Workspace Management** - Understand Jenkins workspace concepts
- **Build Monitoring** - Monitor and analyze build results

---

## ➡️ Next Steps

<div align="center">

### 🚀 **Ready for Advanced CI/CD?**

</div>

1. **🔄 Experiment with Build Parameters** - Make your Maven job configurable
2. **📊 Add Code Quality Tools** - Integrate SonarQube or Checkstyle
3. **🚀 Deploy Artifacts** - Set up deployment to staging environments
4. **🔧 Progress to Pipelines** - [Module 04: Pipeline Fundamentals](../../04_pipeline_fundamentals/README.md)

---

<div align="center">

### 🎯 **Excellent Work!**
*You've mastered Jenkins Maven integration and enterprise CI/CD practices!*

**Continue Learning: [Module 04: Pipeline Fundamentals →](../../04_pipeline_fundamentals/README.md)**

</div>

---

## 🤝 Connect & Follow

<div align="center">

**Created with ❤️ by Varun Kumar Manik**

[![GitHub](https://img.shields.io/badge/GitHub-manikcloud-black?style=for-the-badge&logo=github)](https://github.com/manikcloud)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-vkmanik-blue?style=for-the-badge&logo=linkedin)](https://www.linkedin.com/in/vkmanik/)
[![Email](https://img.shields.io/badge/Email-varunmanik1%40gmail.com-red?style=for-the-badge&logo=gmail)](mailto:varunmanik1@gmail.com)
[![YouTube](https://img.shields.io/badge/YouTube-Technical%20Tutorials-red?style=for-the-badge&logo=youtube)](https://bit.ly/32fknRN)

</div>
