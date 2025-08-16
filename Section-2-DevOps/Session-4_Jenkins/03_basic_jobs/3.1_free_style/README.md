# 🎯 Project 3.1: Freestyle Jobs - Java HelloWorld

<div align="center">

![Freestyle Jobs](https://img.shields.io/badge/Jenkins-Freestyle-blue?style=for-the-badge&logo=jenkins&logoColor=white)
![Java](https://img.shields.io/badge/Java-HelloWorld-red?style=for-the-badge&logo=java&logoColor=white)
![Git](https://img.shields.io/badge/Git-Local%20Repository-orange?style=for-the-badge&logo=git&logoColor=white)

**🎯 Your First Jenkins Job | ☕ Java Application | 🔧 Build Automation**

</div>

---

## 📋 Project Overview

Create your first Jenkins Freestyle job using the **current repository's** Java HelloWorld application. This hands-on project teaches you the fundamentals of Jenkins job creation, configuration, and build automation using real code from your learning environment.

<div align="center">

### 🎯 **What You'll Build**
*A complete Jenkins job that compiles and runs Java code from the current repository*

</div>

### 🎯 **Learning Objectives**
- ✅ Create your first Jenkins Freestyle job
- ✅ Configure build steps for Java compilation
- ✅ Integrate with local Git repository
- ✅ Execute shell commands in Jenkins
- ✅ Monitor build results and console output
- ✅ Understand Jenkins workspace management

---

## 🛤️ Step-by-Step Implementation

### **📁 Repository Setup**

The Java HelloWorld application is already available in your repository:

```bash
# Navigate to the Java application directory after Jenkins checkout
cd Section-2-DevOps/Session-4_Jenkins/03_basic_jobs/3.1_free_style/hello-world

# View the Java source code
cat HelloWorld.java

# Test compilation locally (optional)
javac HelloWorld.java
java HelloWorld
```

**📄 HelloWorld.java Content:**
```java
public class HelloWorld {
    public static void main(String[] args) {
        System.out.println("Hello, World from varun on Aug 10  !!!");
    }
}
```

### **🔧 Jenkins Job Configuration**

#### **Step 1: Create New Freestyle Job**
1. **Access Jenkins Dashboard**: Navigate to `http://localhost:8080`
2. **Create New Item**: Click "New Item" → Enter job name: `HelloWorld-Freestyle`
3. **Select Job Type**: Choose "Freestyle project" → Click "OK"

#### **Step 2: Configure Source Code Management**
```yaml
Source Code Management:
  ✅ Git
  Repository URL: https://github.com/manikcloud/cloud-devops-learning-path.git
  Branch Specifier: */main (or your current branch)
```

#### **Step 3: Configure Build Environment**
```yaml
Build Environment:
  ✅ Delete workspace before build starts (optional)
  ✅ Add timestamps to the Console Output
```

#### **Step 4: Add Build Steps**
**Build Step: Navigate to Java Directory and Compile**
```bash
# Navigate to the HelloWorld directory
cd Section-2-DevOps/Session-4_Jenkins/03_basic_jobs/3.1_free_style/hello-world

# List files to verify location
ls -la

# Compile the Java program
echo "🔨 Compiling HelloWorld.java..."
javac HelloWorld.java

# Verify compilation
if [ -f "HelloWorld.class" ]; then
    echo "✅ Compilation successful!"
    ls -la HelloWorld.*
else
    echo "❌ Compilation failed!"
    exit 1
fi

echo "🎉 Build completed successfully!"
```

#### **Step 5: Configure Post-Build Actions**
```yaml
Post-build Actions:
  ✅ Archive the artifacts: **/*.class
  ✅ Build other projects (if needed)
  ✅ Send build notifications (optional)
```

---

## 🚀 Build Execution

### **Manual Build Trigger**
1. **Navigate to Job**: Go to your `HelloWorld-Freestyle` job
2. **Start Build**: Click "Build Now"
3. **Monitor Progress**: Watch the build progress in real-time
4. **View Results**: Check console output and build status

### **Expected Console Output**
```bash
Started by user admin
Running as SYSTEM
Building in workspace /var/lib/jenkins/workspace/HelloWorld-Freestyle
The recommended git tool is: NONE
using credential 
 > git rev-parse --resolve-git-dir /var/lib/jenkins/workspace/HelloWorld-Freestyle/.git # timeout=10
Fetching changes from the remote Git repository
 > git config remote.origin.url https://github.com/manikcloud/cloud-devops-learning-path.git # timeout=10
Fetching upstream changes from https://github.com/manikcloud/cloud-devops-learning-path.git
 > git --version # timeout=10
 > git --version # 'git version 2.34.1'
 > git fetch --tags --force --progress -- https://github.com/manikcloud/cloud-devops-learning-path.git +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git rev-parse refs/remotes/origin/main^{commit} # timeout=10
Checking out Revision abc123def456... (refs/remotes/origin/main)
 > git config core.sparsecheckout # timeout=10
 > git checkout -f abc123def456... # timeout=10
Commit message: "Updated Jenkins basic jobs module"
 > git rev-list --no-walk abc123def456... # timeout=10
[HelloWorld-Freestyle] $ /bin/sh -xe /tmp/jenkins123456.sh
+ cd Section-2-DevOps/Session-4_Jenkins/03_basic_jobs/3.1_free_style/hello-world
+ ls -la
total 12
drwxr-xr-x 2 jenkins jenkins 4096 Aug 15 10:30 .
drwxr-xr-x 3 jenkins jenkins 4096 Aug 15 10:30 ..
-rw-r--r-- 1 jenkins jenkins  137 Aug 15 10:30 HelloWorld.java
+ echo '🔨 Compiling HelloWorld.java...'
🔨 Compiling HelloWorld.java...
+ javac HelloWorld.java
+ '[' -f HelloWorld.class ']'
+ echo '✅ Compilation successful!'
✅ Compilation successful!
+ ls -la HelloWorld.java HelloWorld.class
-rw-r--r-- 1 jenkins jenkins 430 Aug 15 10:30 HelloWorld.class
-rw-r--r-- 1 jenkins jenkins 137 Aug 15 10:30 HelloWorld.java
+ echo '🎉 Build completed successfully!'
🎉 Build completed successfully!
Archiving artifacts
Finished: SUCCESS
```

---

## 🔍 Understanding the Build Process

### **🏗️ Build Phases Explained**

<table>
<tr>
<th width="20%">Phase</th>
<th width="40%">Description</th>
<th width="40%">What Happens</th>
</tr>

<tr>
<td><strong>🔄 SCM Checkout</strong></td>
<td>Jenkins fetches code from the repository</td>
<td>• Clones/updates repository<br>• Checks out specified branch<br>• Creates workspace</td>
</tr>

<tr>
<td><strong>🏗️ Build Execution</strong></td>
<td>Executes configured build steps</td>
<td>• Navigates to Java directory<br>• Compiles Java source<br>• Verifies compilation success</td>
</tr>

<tr>
<td><strong>📊 Post-Build</strong></td>
<td>Performs post-build actions</td>
<td>• Archives artifacts<br>• Sends notifications<br>• Updates build status</td>
</tr>

</table>

### **📁 Workspace Structure**
```
/var/lib/jenkins/workspace/HelloWorld-Freestyle/
├── Section-2-DevOps/
│   └── Session-4_Jenkins/
│       └── 03_basic_jobs/
│           └── 3.1_free_style/
│               └── hello-world/
│                   ├── HelloWorld.java
│                   └── HelloWorld.class (generated)
└── [other repository files...]
```

---

## 🎯 Advanced Configuration Options

### **🔄 Build Triggers**
Configure automatic build triggers for continuous integration:

```yaml
Build Triggers:
  ✅ Poll SCM: H/5 * * * *  # Check every 5 minutes
  ✅ Build periodically: H 2 * * *  # Daily at 2 AM
  ✅ GitHub hook trigger for GITScm polling
```

### **🌍 Environment Variables**
Add custom environment variables for your build:

```bash
# In Build Environment section
Environment variables:
  JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
  BUILD_USER=jenkins
  PROJECT_NAME=HelloWorld-Freestyle
```

### **📊 Build Parameters**
Make your job configurable with parameters:

```yaml
This project is parameterized:
  ✅ String Parameter:
    Name: GREETING_MESSAGE
    Default Value: Hello, World from Jenkins!
    Description: Custom greeting message for the application
```

**Updated Java code to use parameter:**
```bash
# In build step, modify the Java file dynamically
sed -i "s/Hello, World from varun on Aug 10  !!!/${GREETING_MESSAGE}/" HelloWorld.java
javac HelloWorld.java
java HelloWorld
```

---

## 🔧 Troubleshooting Guide

### **Common Issues and Solutions**

<table>
<tr>
<th width="30%">Issue</th>
<th width="35%">Cause</th>
<th width="35%">Solution</th>
</tr>

<tr>
<td><strong>❌ Repository not found</strong></td>
<td>Incorrect repository path</td>
<td>• Verify path exists<br>• Use absolute path<br>• Check permissions</td>
</tr>

<tr>
<td><strong>❌ Java compilation failed</strong></td>
<td>Java not installed or not in PATH</td>
<td>• Install Java JDK<br>• Configure JAVA_HOME<br>• Update PATH variable</td>
</tr>

<tr>
<td><strong>❌ File not found</strong></td>
<td>Incorrect directory navigation</td>
<td>• Check file paths<br>• Use ls -la to debug<br>• Verify repository structure</td>
</tr>

<tr>
<td><strong>❌ Permission denied</strong></td>
<td>Jenkins user lacks permissions</td>
<td>• Check file permissions<br>• Update ownership<br>• Grant execute permissions</td>
</tr>

</table>

### **🔍 Debugging Commands**
Add these commands to your build steps for debugging:

```bash
# Debug information
echo "=== DEBUG INFORMATION ==="
echo "Current directory: $(pwd)"
echo "User: $(whoami)"
echo "Java version: $(java -version 2>&1)"
echo "Available files:"
find . -name "*.java" -type f
echo "=========================="
```

---

## 🎓 Learning Outcomes

After completing this project, you will have mastered:

### **✅ Technical Skills**
- **Jenkins Job Creation** - Create and configure Freestyle jobs
- **Build Configuration** - Set up build steps and parameters
- **Git Integration** - Connect Jenkins with local repositories
- **Java Compilation** - Automate Java build processes
- **Console Monitoring** - Interpret build logs and results

### **✅ DevOps Concepts**
- **Continuous Integration** - Automated build processes
- **Build Automation** - Eliminate manual compilation steps
- **Version Control Integration** - Connect builds with source code
- **Build Monitoring** - Track build success and failures
- **Workspace Management** - Understand Jenkins workspace concepts

---

## ➡️ Next Steps

<div align="center">

### 🚀 **Ready for More Advanced Builds?**

</div>

1. **🔧 Experiment with Build Parameters** - Make your job configurable
2. **⏰ Set Up Build Triggers** - Automate build execution
3. **📊 Add Post-Build Actions** - Archive artifacts and send notifications
4. **🔄 Progress to Maven Jobs** - [Project 3.2: Freestyle Maven](../3.2_frees_tyle_maven/README.md)

---

<div align="center">

### 🎯 **Congratulations!**
*You've successfully created your first Jenkins Freestyle job!*

**Continue Learning: [3.2 Freestyle Maven Setup →](../3.2_frees_tyle_maven/README.md)**

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
