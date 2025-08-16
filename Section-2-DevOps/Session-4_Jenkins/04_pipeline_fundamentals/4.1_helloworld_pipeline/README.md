# 🚀 Project 4.1: Hello World Pipeline

<div align="center">

![Pipeline](https://img.shields.io/badge/Jenkins-Pipeline-blue?style=for-the-badge&logo=jenkins&logoColor=white)
![Maven](https://img.shields.io/badge/Apache-Maven-orange?style=for-the-badge&logo=apache-maven&logoColor=white)

**📜 Basic Pipeline Example | ☕ Maven Integration | 🔧 Step by Step**

</div>

---

## 📋 Project Overview

Learn Jenkins Pipeline basics with a simple Maven project build. This is a straightforward example that demonstrates the fundamental pipeline structure.

### 🎯 **Learning Objectives**
- ✅ Create your first Jenkins Pipeline job
- ✅ Understand basic pipeline syntax
- ✅ Integrate Maven with Jenkins Pipeline
- ✅ Use Git checkout in pipeline

---

## 🔧 Step-by-Step Pipeline Creation

### **Step 1: Create Pipeline Job**
1. **Jenkins Dashboard**: Navigate to `http://localhost:8080`
2. **New Item**: Click "New Item"
3. **Job Configuration**:
   ```
   Item name: HelloWorld-Pipeline
   Type: Pipeline
   ```
4. **Click OK**: Proceed to configuration

### **Step 2: Configure Pipeline Script**

In the Pipeline section, select "Pipeline script" and enter:

```groovy
pipeline {
    agent any
    tools {
        maven 'maven'
    }
    stages {
        stage("Checkout") {   
            steps {               	 
                git branch: 'main', url: 'https://github.com/manikcloud/cloud-devops-learning-path.git'        	 
            }    
        }

        stage('List root dir') {
            steps {
                sh "pwd && ls -l"
            }
        }

        stage('Build and Test Maven Project') {
            steps {
                dir('Section-2-DevOps/Session-4_Jenkins/03_basic_jobs/3.2_frees_tyle_maven/my-app') {
                    sh "pwd && ls -l"
                    sh "mvn clean"
                    sh "mvn package"

                }
            }
        }
    }
}
```

### **Step 3: Save and Run**
1. **Save**: Click "Save"
2. **Build Now**: Click "Build Now"
3. **View Console Output**: Monitor the build progress

---

## 📊 Expected Output

```bash
Started by user admin
[Pipeline] Start of Pipeline
[Pipeline] node
Running on Jenkins in /var/lib/jenkins/workspace/HelloWorld-Pipeline
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Checkout)
[Pipeline] git
Cloning the remote Git repository
 > git clone https://github.com/manikcloud/cloud-devops-learning-path.git
Checking out Revision abc123... (refs/remotes/origin/main)
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (List root dir)
[Pipeline] sh
+ pwd
/var/lib/jenkins/workspace/HelloWorld-Pipeline
+ ls -l
total 16
drwxr-xr-x 3 jenkins jenkins 4096 Aug 16 10:30 Section-1-Cloud
drwxr-xr-x 4 jenkins jenkins 4096 Aug 16 10:30 Section-2-DevOps
-rw-r--r-- 1 jenkins jenkins 1234 Aug 16 10:30 README.md
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Build and Test Maven Project)
[Pipeline] dir
Running in /var/lib/jenkins/workspace/HelloWorld-Pipeline/Section-2-DevOps/Session-4_Jenkins/03_basic_jobs/3.2_frees_tyle_maven/my-app
[Pipeline] {
[Pipeline] sh
+ pwd
/var/lib/jenkins/workspace/HelloWorld-Pipeline/Section-2-DevOps/Session-4_Jenkins/03_basic_jobs/3.2_frees_tyle_maven/my-app
+ ls -l
total 8
-rw-r--r-- 1 jenkins jenkins 1234 Aug 16 10:30 pom.xml
drwxr-xr-x 4 jenkins jenkins 4096 Aug 16 10:30 src
[Pipeline] sh
+ mvn clean
[INFO] Scanning for projects...
[INFO] Building my-app 1.0-SNAPSHOT
[INFO] --- maven-clean-plugin:2.5:clean (default-clean) @ my-app ---
[INFO] BUILD SUCCESS
[Pipeline] sh
+ mvn package
[INFO] Scanning for projects...
[INFO] Building my-app 1.0-SNAPSHOT
[INFO] --- maven-compiler-plugin:3.8.1:compile (default-compile) @ my-app ---
[INFO] Compiling 1 source file to target/classes
[INFO] --- maven-surefire-plugin:3.0.0-M7:test (default-test) @ my-app ---
[INFO] Tests run: 1, Failures: 0, Errors: 0, Skipped: 0
[INFO] --- maven-jar-plugin:2.4:jar (default-jar) @ my-app ---
[INFO] Building jar: target/my-app-1.0-SNAPSHOT.jar
[INFO] BUILD SUCCESS
[Pipeline] }
[Pipeline] // dir
[Pipeline] }
[Pipeline] // stage
[Pipeline] }
[Pipeline] // node
[Pipeline] End of Pipeline
Finished: SUCCESS
```

---

## 🔍 Pipeline Breakdown

### **Stage 1: Checkout**
- Clones the Git repository
- Checks out the main branch

### **Stage 2: List root dir**
- Shows current directory
- Lists repository contents

### **Stage 3: Build and Test Maven Project**
- Navigates to Maven project directory
- Runs `mvn clean` to clean previous builds
- Runs `mvn package` to compile, test, and package

---

## 🎯 What You Learned

- ✅ **Pipeline Structure** - agent, tools, stages, steps
- ✅ **Git Integration** - Checking out source code
- ✅ **Maven Integration** - Using Maven tool in pipeline
- ✅ **Directory Navigation** - Using `dir()` to change directories
- ✅ **Shell Commands** - Running commands with `sh`

---

## ➡️ Next Steps

1. **Modify the pipeline** - Try changing the Maven goals
2. **Add more stages** - Experiment with additional build steps
3. **Progress to next project** - [4.2 Pipeline without Jenkinsfile](../4.2_pipeline_no_jenkinsfile/README.md)

---

<div align="center">

### 🎯 **Great Job!**
*You've created your first Jenkins Pipeline!*

**Continue Learning: [4.2 Pipeline without Jenkinsfile →](../4.2_pipeline_no_jenkinsfile/README.md)**

</div>
