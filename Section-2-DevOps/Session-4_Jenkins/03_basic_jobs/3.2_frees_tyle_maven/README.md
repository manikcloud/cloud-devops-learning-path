# 🔧 Project 3.2: Freestyle Maven Setup

<div align="center">

![Maven](https://img.shields.io/badge/Apache-Maven-orange?style=for-the-badge&logo=apache-maven&logoColor=white)
![Ubuntu](https://img.shields.io/badge/Ubuntu-Installation-purple?style=for-the-badge&logo=ubuntu&logoColor=white)
![Java](https://img.shields.io/badge/Java-Build%20Tool-red?style=for-the-badge&logo=java&logoColor=white)

**🔧 Maven Installation & Setup | 📦 Project Generation | 🏗️ Build Lifecycle**

</div>

---

## 📋 Project Overview

Master Maven installation and project creation on Ubuntu. This comprehensive guide prepares you for advanced Maven-based Jenkins jobs by establishing a solid foundation in Maven concepts, project structure, and build lifecycle management.

<div align="center">

### 🎯 **What You'll Learn**
*From Maven installation to project mastery*

</div>

### 🎯 **Learning Objectives**
- ✅ Install and configure Maven on Ubuntu
- ✅ Create Maven projects using archetypes
- ✅ Understand Maven project structure and conventions
- ✅ Master Maven build lifecycle and goals
- ✅ Execute Maven commands and analyze results
- ✅ Prepare for Jenkins Maven integration

---

## 🚀 Maven Installation Guide

### **📋 Prerequisites**
- ✅ Ubuntu system (18.04 or later)
- ✅ Java JDK installed (Java 8 or later)
- ✅ Terminal access with sudo privileges
- ✅ Internet connection for package downloads

### **🔧 Step-by-Step Installation**

#### **Step 1: Install Maven**
```bash
# Update package repository
sudo apt update

# Install Maven
sudo apt install maven -y

# Verify installation
mvn --version
```

**Expected Output:**
```bash
Apache Maven 3.6.3
Maven home: /usr/share/maven
Java version: 17.0.16, vendor: Ubuntu, runtime: /usr/lib/jvm/java-17-openjdk-amd64
Default locale: en_US, platform encoding: UTF-8
OS name: "linux", version: "5.4.0-74-generic", arch: "amd64"
```

#### **Step 2: Verify Java Installation**
```bash
# Check Java version
java -version
javac -version

# Verify JAVA_HOME (if needed)
echo $JAVA_HOME

# Set JAVA_HOME if not set
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
```

---

## 📦 Creating Your First Maven Project

### **🏗️ Project Generation with Archetype**

#### **Step 1: Generate Maven Project**
```bash
# Navigate to your workspace (Jenkins will handle the checkout)
cd Section-2-DevOps/Session-4_Jenkins/03_basic_jobs/3.2_frees_tyle_maven

# Create Maven project using quickstart archetype
mvn archetype:generate \
  -DgroupId=com.mycompany.app \
  -DartifactId=my-app \
  -DarchetypeArtifactId=maven-archetype-quickstart \
  -DarchetypeVersion=1.4 \
  -DinteractiveMode=false

# Alternative one-liner for easy copying
mvn archetype:generate -DgroupId=com.mycompany.app -DartifactId=my-app -DarchetypeArtifactId=maven-archetype-quickstart -DarchetypeVersion=1.4 -DinteractiveMode=false
```

#### **Step 2: Install Tree Utility (for project visualization)**
```bash
# Install tree package for better directory visualization
sudo apt install tree -y

# Navigate to the generated project
cd my-app/

# Display project structure
tree
```

**Expected Project Structure:**
```
my-app/
├── pom.xml
└── src/
    ├── main/
    │   └── java/
    │       └── com/
    │           └── mycompany/
    │               └── app/
    │                   └── App.java
    └── test/
        └── java/
            └── com/
                └── mycompany/
                    └── app/
                        └── AppTest.java
```

---

## 🔍 Understanding Maven Archetype Parameters

<div align="center">

### 📊 **Archetype Command Breakdown**
*Understanding each parameter for project customization*

</div>

<table>
<tr>
<th width="25%">Parameter</th>
<th width="35%">Description</th>
<th width="40%">Example & Purpose</th>
</tr>

<tr>
<td><strong>groupId</strong></td>
<td>Unique identifier for your organization/project group</td>
<td><code>com.mycompany.app</code><br>• Follows reverse domain convention<br>• Organizes related projects</td>
</tr>

<tr>
<td><strong>artifactId</strong></td>
<td>Unique name for your specific project</td>
<td><code>my-app</code><br>• Becomes project folder name<br>• Should be descriptive</td>
</tr>

<tr>
<td><strong>archetypeArtifactId</strong></td>
<td>Template type for project generation</td>
<td><code>maven-archetype-quickstart</code><br>• Creates basic Java project<br>• Includes sample code</td>
</tr>

<tr>
<td><strong>archetypeVersion</strong></td>
<td>Version of the archetype template</td>
<td><code>1.4</code><br>• Latest stable version<br>• Ensures modern structure</td>
</tr>

<tr>
<td><strong>interactiveMode</strong></td>
<td>Whether to prompt for input</td>
<td><code>false</code><br>• Automated generation<br>• Uses provided parameters</td>
</tr>

</table>

---

## 🏗️ Maven Build Lifecycle & Goals

### **🎯 Understanding Maven Goals**

Maven goals are specific tasks executed as part of the build process. Each goal performs a particular function in the software development lifecycle.

#### **🔄 Core Maven Goals**

<table>
<tr>
<th width="20%">Goal</th>
<th width="30%">Purpose</th>
<th width="30%">Command</th>
<th width="20%">When to Use</th>
</tr>

<tr>
<td><strong>clean</strong></td>
<td>Remove all generated files and directories</td>
<td><code>mvn clean</code></td>
<td>Before fresh builds</td>
</tr>

<tr>
<td><strong>compile</strong></td>
<td>Compile source code</td>
<td><code>mvn compile</code></td>
<td>Check compilation</td>
</tr>

<tr>
<td><strong>test</strong></td>
<td>Run unit tests</td>
<td><code>mvn test</code></td>
<td>Verify code quality</td>
</tr>

<tr>
<td><strong>package</strong></td>
<td>Create JAR/WAR files</td>
<td><code>mvn package</code></td>
<td>Create deployable artifacts</td>
</tr>

<tr>
<td><strong>install</strong></td>
<td>Install artifacts to local repository</td>
<td><code>mvn install</code></td>
<td>Make available locally</td>
</tr>

<tr>
<td><strong>deploy</strong></td>
<td>Deploy to remote repository</td>
<td><code>mvn deploy</code></td>
<td>Share with team</td>
</tr>

</table>

### **🚀 Hands-On Maven Commands**

#### **Step 1: Build the Project**
```bash
# Navigate to project directory
cd my-app/

# Clean and install (most common combination)
mvn clean install

# View the results
tree
```

#### **Step 2: Run Individual Goals**
```bash
# Clean the project
mvn clean
echo "✅ Project cleaned"

# Compile source code
mvn compile
echo "✅ Source code compiled"

# Run tests
mvn test
echo "✅ Tests executed"

# Package the application
mvn package
echo "✅ JAR file created"

# View generated artifacts
ls -la target/
```

#### **Step 3: Execute the Application**
```bash
# Run the generated JAR file
java -cp target/my-app-1.0-SNAPSHOT.jar com.mycompany.app.App

# Alternative: Use Maven exec plugin (if configured)
mvn exec:java -Dexec.mainClass="com.mycompany.app.App"
```

**Expected Output:**
```
Hello World!
```

---

## 📊 Maven Project Structure Deep Dive

### **🏗️ Standard Directory Layout**

<div align="center">

### 📁 **Maven Standard Directory Layout**
*Convention over configuration*

</div>

```
my-app/
├── pom.xml                          # Project Object Model (POM) file
├── src/                             # Source code directory
│   ├── main/                        # Main application code
│   │   ├── java/                    # Java source files
│   │   │   └── com/mycompany/app/   # Package structure
│   │   │       └── App.java         # Main application class
│   │   ├── resources/               # Resource files (configs, etc.)
│   │   └── webapp/                  # Web application files (if applicable)
│   └── test/                        # Test code directory
│       ├── java/                    # Test source files
│       │   └── com/mycompany/app/   # Test package structure
│       │       └── AppTest.java     # Unit test class
│       └── resources/               # Test resource files
├── target/                          # Generated files (after build)
│   ├── classes/                     # Compiled main classes
│   ├── test-classes/                # Compiled test classes
│   ├── my-app-1.0-SNAPSHOT.jar      # Generated JAR file
│   └── [other generated files]
└── [other project files]
```

### **📄 Understanding the POM File**

The `pom.xml` file is the heart of any Maven project:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 
         http://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>

  <groupId>com.mycompany.app</groupId>
  <artifactId>my-app</artifactId>
  <version>1.0-SNAPSHOT</version>

  <properties>
    <maven.compiler.source>11</maven.compiler.source>
    <maven.compiler.target>11</maven.compiler.target>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
  </properties>

  <dependencies>
    <dependency>
      <groupId>junit</groupId>
      <artifactId>junit</artifactId>
      <version>4.11</version>
      <scope>test</scope>
    </dependency>
  </dependencies>
</project>
```

---

## 🎯 Maven Build Lifecycle Phases

### **🔄 Complete Build Lifecycle**

Maven follows a well-defined build lifecycle with specific phases:

<table>
<tr>
<th width="20%">Phase</th>
<th width="30%">Description</th>
<th width="30%">Key Actions</th>
<th width="20%">Dependencies</th>
</tr>

<tr>
<td><strong>validate</strong></td>
<td>Validate project structure</td>
<td>• Check POM validity<br>• Verify required information</td>
<td>None</td>
</tr>

<tr>
<td><strong>compile</strong></td>
<td>Compile source code</td>
<td>• Compile main Java files<br>• Generate class files</td>
<td>validate</td>
</tr>

<tr>
<td><strong>test</strong></td>
<td>Run unit tests</td>
<td>• Compile test code<br>• Execute unit tests</td>
<td>compile</td>
</tr>

<tr>
<td><strong>package</strong></td>
<td>Create distributable format</td>
<td>• Create JAR/WAR files<br>• Include resources</td>
<td>test</td>
</tr>

<tr>
<td><strong>verify</strong></td>
<td>Run integration tests</td>
<td>• Execute integration tests<br>• Verify package quality</td>
<td>package</td>
</tr>

<tr>
<td><strong>install</strong></td>
<td>Install to local repository</td>
<td>• Copy to ~/.m2/repository<br>• Make available locally</td>
<td>verify</td>
</tr>

<tr>
<td><strong>deploy</strong></td>
<td>Deploy to remote repository</td>
<td>• Upload to remote repo<br>• Share with team</td>
<td>install</td>
</tr>

</table>

### **🚀 Practical Build Examples**

```bash
# Execute specific phases
mvn validate          # Validate project
mvn compile           # Compile only
mvn test              # Compile and test
mvn package           # Create JAR file
mvn verify            # Run integration tests
mvn install           # Install to local repo
mvn deploy            # Deploy to remote repo

# Common combinations
mvn clean compile     # Clean and compile
mvn clean test        # Clean, compile, and test
mvn clean package     # Clean, compile, test, and package
mvn clean install     # Full build cycle
```

---

## 🔧 Advanced Maven Configuration

### **🎯 Customizing Your Maven Project**

#### **Adding Dependencies**
Edit `pom.xml` to add external libraries:

```xml
<dependencies>
  <!-- JUnit for testing -->
  <dependency>
    <groupId>junit</groupId>
    <artifactId>junit</artifactId>
    <version>4.13.2</version>
    <scope>test</scope>
  </dependency>
  
  <!-- Apache Commons Lang -->
  <dependency>
    <groupId>org.apache.commons</groupId>
    <artifactId>commons-lang3</artifactId>
    <version>3.12.0</version>
  </dependency>
</dependencies>
```

#### **Configuring Plugins**
Add build plugins for enhanced functionality:

```xml
<build>
  <plugins>
    <!-- Compiler plugin -->
    <plugin>
      <groupId>org.apache.maven.plugins</groupId>
      <artifactId>maven-compiler-plugin</artifactId>
      <version>3.8.1</version>
      <configuration>
        <source>11</source>
        <target>11</target>
      </configuration>
    </plugin>
    
    <!-- Exec plugin for running applications -->
    <plugin>
      <groupId>org.codehaus.mojo</groupId>
      <artifactId>exec-maven-plugin</artifactId>
      <version>3.0.0</version>
      <configuration>
        <mainClass>com.mycompany.app.App</mainClass>
      </configuration>
    </plugin>
  </plugins>
</build>
```

---

## 🔍 Troubleshooting Common Issues

### **❌ Common Problems and Solutions**

<table>
<tr>
<th width="30%">Issue</th>
<th width="35%">Cause</th>
<th width="35%">Solution</th>
</tr>

<tr>
<td><strong>Maven command not found</strong></td>
<td>Maven not installed or not in PATH</td>
<td>• Install Maven: <code>sudo apt install maven</code><br>• Verify installation: <code>mvn --version</code></td>
</tr>

<tr>
<td><strong>Java version mismatch</strong></td>
<td>Wrong Java version or JAVA_HOME</td>
<td>• Check Java: <code>java -version</code><br>• Set JAVA_HOME correctly<br>• Update POM compiler settings</td>
</tr>

<tr>
<td><strong>Build failures</strong></td>
<td>Compilation errors or test failures</td>
<td>• Check console output<br>• Fix compilation errors<br>• Review test failures</td>
</tr>

<tr>
<td><strong>Dependency resolution issues</strong></td>
<td>Network issues or repository problems</td>
<td>• Check internet connection<br>• Clear local repository<br>• Update repository URLs</td>
</tr>

</table>

### **🔧 Debugging Commands**

```bash
# Get detailed build information
mvn clean install -X

# Skip tests if needed
mvn clean install -DskipTests

# Force update dependencies
mvn clean install -U

# Show dependency tree
mvn dependency:tree

# Clear local repository cache
rm -rf ~/.m2/repository
```

---

## 🎓 Learning Outcomes

After completing this project, you will have mastered:

### **✅ Maven Fundamentals**
- **Installation & Configuration** - Set up Maven on Ubuntu
- **Project Generation** - Create projects using archetypes
- **Build Lifecycle** - Understand phases and goals
- **Project Structure** - Navigate Maven conventions
- **Dependency Management** - Add and manage external libraries

### **✅ Practical Skills**
- **Command Line Proficiency** - Execute Maven commands confidently
- **Project Management** - Create and maintain Maven projects
- **Build Automation** - Automate compilation and testing
- **Troubleshooting** - Debug common Maven issues
- **Jenkins Preparation** - Ready for Maven job integration

---

## ❓ Maven Q&A - Common Interview Questions

<div align="center">

### 🎯 **Essential Maven Knowledge**
*Master these concepts for interviews and real-world projects*

</div>

### **Q: What is the difference between `mvn clean package` and `mvn clean install`?**

**Answer:**

Both commands compile your code, run tests, and create JAR/WAR files in the `target/` folder.

**The key difference:**

**`mvn clean package`:**
- ✅ Builds artifacts only in `target/` folder
- ❌ Other projects on your machine **cannot** use these artifacts

**`mvn clean install`:**
- ✅ Builds artifacts in `target/` folder **AND** copies them to `~/.m2/repository/`
- ✅ Other projects on your machine **can** use these artifacts as dependencies

**When to use:**
- 📦 Use `package` for simple builds and testing
- 🔧 Use `install` when other local projects need to depend on this artifact

**Example:**
If Project B depends on Project A:
- After `mvn package` on Project A → Project B build **fails** ❌
- After `mvn install` on Project A → Project B build **succeeds** ✅

> 💡 **Pro Tip:** The local repository (`~/.m2/repository/`) is like a shared library where all your local projects can find each other's built artifacts.

### **Q: What are the main Maven lifecycle phases?**

**Answer:**

Maven has three built-in build lifecycles:

**Default Lifecycle (most common):**
1. `validate` - Validate project structure
2. `compile` - Compile source code
3. `test` - Run unit tests
4. `package` - Create JAR/WAR files
5. `verify` - Run integration tests
6. `install` - Install to local repository
7. `deploy` - Copy to remote repository

**Clean Lifecycle:**
- `clean` - Remove target directory and compiled artifacts

**Site Lifecycle:**
- `site` - Generate project documentation

> 📝 **Remember:** When you run a phase, all previous phases execute automatically!

### **Q: What is the purpose of the `pom.xml` file?**

**Answer:**

The `pom.xml` (Project Object Model) is Maven's configuration file that defines:

- 📋 **Project Information** - groupId, artifactId, version
- 📦 **Dependencies** - External libraries your project needs
- 🔧 **Build Configuration** - Plugins, goals, and build settings
- 🎯 **Project Properties** - Java version, encoding, etc.

**Key sections:**
```xml
<project>
    <groupId>com.example</groupId>      <!-- Organization -->
    <artifactId>my-app</artifactId>     <!-- Project name -->
    <version>1.0-SNAPSHOT</version>     <!-- Project version -->
    
    <dependencies>                      <!-- External libraries -->
        <dependency>
            <groupId>junit</groupId>
            <artifactId>junit</artifactId>
            <version>4.12</version>
        </dependency>
    </dependencies>
</project>
```

---

## ➡️ Next Steps

<div align="center">

### 🚀 **Ready for Jenkins Maven Integration?**

</div>

1. **🔄 Practice Maven Commands** - Get comfortable with the build lifecycle
2. **📦 Experiment with Dependencies** - Add external libraries to your project
3. **🧪 Write Additional Tests** - Expand your test suite
4. **🔧 Progress to Maven Jobs** - [Project 3.3: Maven Style Jobs](../3.3_maven_style/README.md)

---

<div align="center">

### 🎯 **Excellent Work!**
*You've mastered Maven fundamentals and project creation!*

**Continue Learning: [3.3 Maven Style Jobs →](../3.3_maven_style/README.md)**

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
