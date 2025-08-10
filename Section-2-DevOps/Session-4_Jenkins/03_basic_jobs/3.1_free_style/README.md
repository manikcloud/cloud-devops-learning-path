# 🔧 Project 3.1: Freestyle Jobs

<div align="center">

![Freestyle](https://img.shields.io/badge/Freestyle-Jobs-blue?style=for-the-badge&logo=jenkins&logoColor=white)
![Beginner](https://img.shields.io/badge/Level-Beginner-green?style=for-the-badge&logo=graduation-cap&logoColor=white)

**🎯 Your First Jenkins Job | 🔧 GUI Configuration | 📊 Build Automation**

</div>

---

## 📋 Project Overview

This project introduces you to creating your first Jenkins job using the Freestyle project type. You'll learn the fundamentals of job configuration, build steps, and basic automation through Jenkins' user-friendly web interface.

### 🎯 **Learning Objectives**
- ✅ Create and configure a Freestyle Jenkins job
- ✅ Set up build triggers and scheduling
- ✅ Configure build steps with shell commands
- ✅ Implement post-build actions
- ✅ Understand workspace management

---

## 📚 Theory: Freestyle Jobs

### **What are Freestyle Jobs?**
Freestyle jobs are the most basic and flexible job type in Jenkins. They provide a simple, GUI-based approach to creating build jobs without requiring any scripting knowledge.

#### **Key Characteristics:**
- 🎯 **GUI Configuration** - Point-and-click setup
- 🔧 **Flexible Build Steps** - Execute various commands and scripts
- 📊 **Plugin Integration** - Use any Jenkins plugin
- 🔄 **Simple Workflow** - Straightforward build process
- 👥 **Beginner Friendly** - Easy to understand and configure

#### **When to Use Freestyle Jobs:**
- Learning Jenkins fundamentals
- Simple build and deployment tasks
- Quick prototyping and testing
- Legacy project integration
- One-off or ad-hoc builds

---

## 🛠️ **Step-by-Step Implementation**

### **Step 1: Create New Freestyle Job**

1. **Navigate to Jenkins Dashboard**
   - Open Jenkins web interface (http://your-jenkins-server:8080)
   - Click "New Item" in the left sidebar

2. **Configure Job Basics**
   ```
   Job Name: my-first-freestyle-job
   Job Type: Freestyle project
   Description: My first Jenkins freestyle job for learning
   ```

3. **Click "OK"** to create the job

### **Step 2: General Configuration**

#### **Project Settings:**
- ✅ **Description:** "Learning freestyle job configuration"
- ✅ **Discard old builds:** Keep last 10 builds
- ✅ **GitHub project:** (if using GitHub repository)

#### **Source Code Management:**
```bash
# If using Git repository
Repository URL: https://github.com/your-username/sample-java-app.git
Branch: */main
Credentials: (configure if private repo)
```

### **Step 3: Build Triggers**

Choose one or more trigger options:

#### **Option 1: Manual Trigger**
- No automatic triggers
- Build only when manually started

#### **Option 2: SCM Polling**
```bash
# Poll SCM every 5 minutes
Schedule: H/5 * * * *
```

#### **Option 3: Scheduled Build**
```bash
# Build every day at 2 AM
Schedule: 0 2 * * *
```

#### **Option 4: GitHub Webhook**
- Configure webhook in GitHub repository
- Enable "GitHub hook trigger for GITScm polling"

### **Step 4: Build Environment**

Configure build environment options:

```bash
✅ Delete workspace before build starts
✅ Add timestamps to the Console Output
✅ Set environment variables:
   - JAVA_HOME=/usr/lib/jvm/java-11-openjdk
   - MAVEN_HOME=/usr/share/maven
```

### **Step 5: Build Steps**

Add multiple build steps:

#### **Build Step 1: Execute Shell**
```bash
#!/bin/bash
echo "=== Starting Build Process ==="
echo "Build Number: $BUILD_NUMBER"
echo "Job Name: $JOB_NAME"
echo "Workspace: $WORKSPACE"
echo "Build URL: $BUILD_URL"

# Display system information
echo "=== System Information ==="
uname -a
java -version
mvn -version
```

#### **Build Step 2: Maven Build**
```bash
#!/bin/bash
echo "=== Maven Build ==="
cd $WORKSPACE

# Clean and compile
mvn clean compile

# Run tests
mvn test

# Package application
mvn package

echo "=== Build Completed ==="
ls -la target/
```

#### **Build Step 3: Archive Artifacts**
```bash
#!/bin/bash
echo "=== Preparing Artifacts ==="

# Create artifacts directory
mkdir -p artifacts

# Copy build artifacts
cp target/*.jar artifacts/ 2>/dev/null || echo "No JAR files found"
cp target/*.war artifacts/ 2>/dev/null || echo "No WAR files found"

# Create build info file
echo "Build Number: $BUILD_NUMBER" > artifacts/build-info.txt
echo "Build Date: $(date)" >> artifacts/build-info.txt
echo "Git Commit: $GIT_COMMIT" >> artifacts/build-info.txt

ls -la artifacts/
```

### **Step 6: Post-build Actions**

Configure actions to run after the build:

#### **Archive Artifacts**
```
Files to archive: artifacts/**
```

#### **Publish JUnit Test Results**
```
Test report XMLs: target/surefire-reports/*.xml
```

#### **Email Notification**
```
Recipients: your-email@company.com
Send email for: Failure, Unstable, Back to Normal
```

#### **Build Status Badge**
- Enable "Set build status on GitHub commit"

---

## 📊 **Complete Job Configuration Example**

### **Job XML Configuration (for reference):**
```xml
<?xml version='1.1' encoding='UTF-8'?>
<project>
  <description>My first Jenkins freestyle job for learning</description>
  <keepDependencies>false</keepDependencies>
  <properties>
    <jenkins.model.BuildDiscarderProperty>
      <strategy class="hudson.tasks.LogRotator">
        <daysToKeep>-1</daysToKeep>
        <numToKeep>10</numToKeep>
        <artifactDaysToKeep>-1</artifactDaysToKeep>
        <artifactNumToKeep>-1</artifactNumToKeep>
      </strategy>
    </jenkins.model.BuildDiscarderProperty>
  </properties>
  <scm class="hudson.plugins.git.GitSCM">
    <configVersion>2</configVersion>
    <userRemoteConfigs>
      <hudson.plugins.git.UserRemoteConfig>
        <url>https://github.com/your-username/sample-java-app.git</url>
      </hudson.plugins.git.UserRemoteConfig>
    </userRemoteConfigs>
    <branches>
      <hudson.plugins.git.BranchSpec>
        <name>*/main</name>
      </hudson.plugins.git.BranchSpec>
    </branches>
  </scm>
  <triggers>
    <hudson.triggers.SCMTrigger>
      <spec>H/5 * * * *</spec>
      <ignorePostCommitHooks>false</ignorePostCommitHooks>
    </hudson.triggers.SCMTrigger>
  </triggers>
  <builders>
    <hudson.tasks.Shell>
      <command>
        echo "=== Starting Build Process ==="
        echo "Build Number: $BUILD_NUMBER"
        mvn clean package
      </command>
    </hudson.tasks.Shell>
  </builders>
  <publishers>
    <hudson.tasks.ArtifactArchiver>
      <artifacts>artifacts/**</artifacts>
      <allowEmptyArchive>false</allowEmptyArchive>
      <onlyIfSuccessful>false</onlyIfSuccessful>
      <fingerprint>false</fingerprint>
      <defaultExcludes>true</defaultExcludes>
    </hudson.tasks.ArtifactArchiver>
  </publishers>
</project>
```

---

## 🚀 **Testing Your Job**

### **Step 1: Manual Build**
1. Go to your job page
2. Click "Build Now"
3. Watch the build progress in "Build History"
4. Check "Console Output" for detailed logs

### **Step 2: Verify Build Results**
```bash
# Check workspace contents
ls -la /var/lib/jenkins/workspace/my-first-freestyle-job/

# Check archived artifacts
ls -la /var/lib/jenkins/jobs/my-first-freestyle-job/builds/*/archive/
```

### **Step 3: Test Triggers**
- Make a code change and push to repository
- Verify automatic build trigger works
- Check email notifications

---

## 📊 **Expected Outcomes**

After completing this project, you will have:

### **Working Freestyle Job**
- ✅ **Functional Jenkins job** that builds successfully
- ✅ **Automated triggers** responding to code changes
- ✅ **Build artifacts** properly archived
- ✅ **Email notifications** for build status

### **Skills Gained**
- ✅ **Jenkins UI Navigation** - Comfortable with Jenkins interface
- ✅ **Job Configuration** - Understanding of all job settings
- ✅ **Build Process** - Knowledge of build steps and flow
- ✅ **Troubleshooting** - Ability to debug build issues

---

## 🔍 **Common Issues & Solutions**

### **Build Fails with "Command not found"**
```bash
# Solution: Add tool paths to build environment
export PATH=$PATH:/usr/local/bin:/usr/bin
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk
export MAVEN_HOME=/usr/share/maven
export PATH=$MAVEN_HOME/bin:$PATH
```

### **Git Clone Fails**
```bash
# Check Git configuration
git config --global user.name "Jenkins"
git config --global user.email "jenkins@company.com"

# Verify repository URL and credentials
```

### **Artifacts Not Archived**
```bash
# Ensure artifacts directory exists and has files
ls -la artifacts/
# Check file patterns in archive configuration
```

### **Email Notifications Not Working**
- Verify SMTP configuration in Jenkins global settings
- Check email addresses are correct
- Test SMTP connectivity from Jenkins server

---

## 🎯 **Best Practices**

### **Job Organization**
- 📝 **Clear Naming** - Use descriptive job names
- 📁 **Folder Structure** - Organize jobs in folders
- 🏷️ **Descriptions** - Add meaningful job descriptions
- 🔄 **Build Retention** - Configure appropriate build history

### **Build Optimization**
- ⚡ **Efficient Scripts** - Write optimized build scripts
- 💾 **Workspace Cleanup** - Clean workspace when needed
- 🎯 **Selective Triggers** - Use appropriate trigger strategies
- 📊 **Resource Management** - Monitor resource usage

### **Maintenance**
- 🔍 **Regular Review** - Review and update job configurations
- 📈 **Performance Monitoring** - Track build times and success rates
- 🔧 **Plugin Updates** - Keep Jenkins and plugins updated
- 📋 **Documentation** - Document job purposes and configurations

---

## ➡️ **Next Steps**

Once you've mastered Freestyle jobs:

1. **Experiment with Different Build Steps** - Try various shell commands
2. **Add More Post-build Actions** - Explore notification options
3. **Create Multiple Jobs** - Build a collection of different job types
4. **Proceed to Maven Jobs** - [3.2 Maven Style Jobs](../3.2_maven_style/README.md)

---

## 📚 **Additional Resources**

- 📖 [Jenkins Freestyle Project Documentation](https://www.jenkins.io/doc/book/using/using-freestyle-projects/)
- 📖 [Jenkins Build Triggers](https://www.jenkins.io/doc/book/using/triggering-builds/)
- 📖 [Jenkins Post-build Actions](https://www.jenkins.io/doc/book/using/post-build-actions/)

---

<div align="center">

### 🎯 **Congratulations!**
*You've created your first Jenkins Freestyle job! This is the foundation for all Jenkins automation.*

**Next: [3.2 Maven Style Jobs](../3.2_maven_style/README.md)**

</div>
