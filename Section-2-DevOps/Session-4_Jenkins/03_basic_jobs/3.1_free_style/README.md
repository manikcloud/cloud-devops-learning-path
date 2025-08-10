# 🔧 Project 3.1: Freestyle Jobs - Simple Java HelloWorld

<div align="center">

![Freestyle](https://img.shields.io/badge/Freestyle-Jobs-blue?style=for-the-badge&logo=jenkins&logoColor=white)
![Java](https://img.shields.io/badge/Java-HelloWorld-red?style=for-the-badge&logo=java&logoColor=white)

**🎯 Your First Jenkins Job | 🔧 GUI Configuration | ☕ Simple Java Build**

</div>

---

## 📋 Project Overview

This project introduces you to creating your first Jenkins job using the Freestyle project type. You'll learn to build and run a simple Java HelloWorld program using Jenkins' user-friendly web interface.

### 🎯 **Learning Objectives**
- ✅ Create and configure a Freestyle Jenkins job
- ✅ Build and run simple Java programs
- ✅ Configure build steps with shell commands
- ✅ Understand workspace management and artifacts
- ✅ Learn basic Jenkins job configuration

---

## ☕ **Sample Java Project**

### **Step 1: Create Simple Java HelloWorld**

Create a simple Java file that we'll build with Jenkins:

#### **HelloWorld.java**
```java
public class HelloWorld {
    public static void main(String[] args) {
        System.out.println("Hello, World from Jenkins!");
        System.out.println("Build Number: " + System.getenv("BUILD_NUMBER"));
        System.out.println("Job Name: " + System.getenv("JOB_NAME"));
        System.out.println("Current Date: " + new java.util.Date());
    }
}
```

### **Step 2: Create Additional Java Examples**

#### **Calculator.java**
```java
public class Calculator {
    public static void main(String[] args) {
        System.out.println("=== Simple Calculator ===");
        
        int a = 10;
        int b = 5;
        
        System.out.println("Addition: " + a + " + " + b + " = " + (a + b));
        System.out.println("Subtraction: " + a + " - " + b + " = " + (a - b));
        System.out.println("Multiplication: " + a + " * " + b + " = " + (a * b));
        System.out.println("Division: " + a + " / " + b + " = " + (a / b));
        
        System.out.println("Calculator executed successfully!");
    }
}
```

---

## 🔧 **Step-by-Step Freestyle Job Creation**

### **Step 1: Create New Freestyle Job**

1. **Navigate to Jenkins Dashboard**
   - Open Jenkins web interface (http://your-jenkins-server:8080)
   - Click "New Item" in the left sidebar

2. **Configure Job Basics**
   ```
   Job Name: java-helloworld-freestyle
   Job Type: Freestyle project
   Description: Simple Java HelloWorld build using Freestyle job
   ```

3. **Click "OK"** to create the job

### **Step 2: General Configuration**

#### **Project Settings:**
- ✅ **Description:** "Simple Java HelloWorld build and execution"
- ✅ **Discard old builds:** Keep last 10 builds
- ✅ **GitHub project:** (optional - if using GitHub repository)

### **Step 3: Build Environment**

Configure build environment options:

```bash
✅ Delete workspace before build starts
✅ Add timestamps to the Console Output

# Environment Variables (optional)
JAVA_HOME=/usr/lib/jvm/java-17-amazon-corretto.x86_64
PATH=$JAVA_HOME/bin:$PATH
```

### **Step 4: Build Steps**

Add multiple build steps to compile and run Java programs:

#### **Build Step 1: Create Java Files**

**Execute Shell:**
```bash
#!/bin/bash
echo "=== Creating Java Source Files ==="

# Create HelloWorld.java
cat > HelloWorld.java << 'EOF'
public class HelloWorld {
    public static void main(String[] args) {
        System.out.println("Hello, World from Jenkins!");
        System.out.println("Build Number: " + System.getenv("BUILD_NUMBER"));
        System.out.println("Job Name: " + System.getenv("JOB_NAME"));
        System.out.println("Current Date: " + new java.util.Date());
    }
}
EOF

# Create Calculator.java
cat > Calculator.java << 'EOF'
public class Calculator {
    public static void main(String[] args) {
        System.out.println("=== Simple Calculator ===");
        
        int a = 10;
        int b = 5;
        
        System.out.println("Addition: " + a + " + " + b + " = " + (a + b));
        System.out.println("Subtraction: " + a + " - " + b + " = " + (a - b));
        System.out.println("Multiplication: " + a + " * " + b + " = " + (a * b));
        System.out.println("Division: " + a + " / " + b + " = " + (a / b));
        
        System.out.println("Calculator executed successfully!");
    }
}
EOF

echo "✅ Java source files created successfully!"
ls -la *.java
```

#### **Build Step 2: Compile Java Programs**

**Execute Shell:**
```bash
#!/bin/bash
echo "=== Compiling Java Programs ==="

# Check Java version
echo "Java Version:"
java -version
echo ""

# Compile HelloWorld.java
echo "Compiling HelloWorld.java..."
javac HelloWorld.java

if [ $? -eq 0 ]; then
    echo "✅ HelloWorld.java compiled successfully!"
else
    echo "❌ HelloWorld.java compilation failed!"
    exit 1
fi

# Compile Calculator.java
echo "Compiling Calculator.java..."
javac Calculator.java

if [ $? -eq 0 ]; then
    echo "✅ Calculator.java compiled successfully!"
else
    echo "❌ Calculator.java compilation failed!"
    exit 1
fi

echo ""
echo "📁 Compiled class files:"
ls -la *.class
```

#### **Build Step 3: Run Java Programs**

**Execute Shell:**
```bash
#!/bin/bash
echo "=== Running Java Programs ==="

# Run HelloWorld
echo "🚀 Running HelloWorld program:"
echo "----------------------------------------"
java HelloWorld
echo "----------------------------------------"
echo ""

# Run Calculator
echo "🧮 Running Calculator program:"
echo "----------------------------------------"
java Calculator
echo "----------------------------------------"
echo ""

echo "✅ All Java programs executed successfully!"
```

#### **Build Step 4: Create Build Summary**

**Execute Shell:**
```bash
#!/bin/bash
echo "=== Creating Build Summary ==="

# Create build summary file
cat > build-summary.txt << EOF
Java Build Summary
==================
Build Number: $BUILD_NUMBER
Job Name: $JOB_NAME
Build Date: $(date)
Workspace: $WORKSPACE
Java Version: $(java -version 2>&1 | head -1)

Files Created:
$(ls -la *.java *.class 2>/dev/null)

Build Status: SUCCESS
EOF

echo "📋 Build summary created:"
cat build-summary.txt

# Create a simple JAR file (optional)
echo ""
echo "📦 Creating JAR file..."
jar cf hello-programs.jar *.class
echo "✅ JAR file created: hello-programs.jar"
ls -la *.jar
```

### **Step 5: Post-build Actions**

#### **Archive Artifacts**
```
Files to archive: *.class, *.jar, build-summary.txt, *.java
```

#### **Email Notification (Optional)**
```
Recipients: your-email@company.com
Send email for: Failure, Back to Normal
```

### **Step 6: Test Your Freestyle Job**

1. **Save the job configuration**
2. **Click "Build Now"**
3. **Watch the build progress in "Build History"**
4. **Check "Console Output" for detailed logs**
5. **Verify archived artifacts**

---

## 📊 **Expected Build Output**

### **Console Output Example:**
```
Started by user admin
Running as SYSTEM
Building in workspace /var/lib/jenkins/workspace/java-helloworld-freestyle

[java-helloworld-freestyle] $ /bin/bash /tmp/jenkins123.sh
=== Creating Java Source Files ===
✅ Java source files created successfully!
-rw-r--r-- 1 jenkins jenkins 245 Aug 10 15:30 Calculator.java
-rw-r--r-- 1 jenkins jenkins 198 Aug 10 15:30 HelloWorld.java

[java-helloworld-freestyle] $ /bin/bash /tmp/jenkins456.sh
=== Compiling Java Programs ===
Java Version:
openjdk version "17.0.7" 2023-04-18 LTS

Compiling HelloWorld.java...
✅ HelloWorld.java compiled successfully!
Compiling Calculator.java...
✅ Calculator.java compiled successfully!

📁 Compiled class files:
-rw-r--r-- 1 jenkins jenkins 623 Aug 10 15:30 Calculator.class
-rw-r--r-- 1 jenkins jenkins 456 Aug 10 15:30 HelloWorld.class

[java-helloworld-freestyle] $ /bin/bash /tmp/jenkins789.sh
=== Running Java Programs ===
🚀 Running HelloWorld program:
----------------------------------------
Hello, World from Jenkins!
Build Number: 1
Job Name: java-helloworld-freestyle
Current Date: Thu Aug 10 15:30:45 UTC 2025
----------------------------------------

🧮 Running Calculator program:
----------------------------------------
=== Simple Calculator ===
Addition: 10 + 5 = 15
Subtraction: 10 - 5 = 5
Multiplication: 10 * 5 = 50
Division: 10 / 5 = 2
Calculator executed successfully!
----------------------------------------

✅ All Java programs executed successfully!

[java-helloworld-freestyle] $ /bin/bash /tmp/jenkins012.sh
=== Creating Build Summary ===
📋 Build summary created:
Java Build Summary
==================
Build Number: 1
Job Name: java-helloworld-freestyle
Build Date: Thu Aug 10 15:30:45 UTC 2025
Workspace: /var/lib/jenkins/workspace/java-helloworld-freestyle
Java Version: openjdk version "17.0.7" 2023-04-18 LTS

📦 Creating JAR file...
✅ JAR file created: hello-programs.jar
-rw-r--r-- 1 jenkins jenkins 1234 Aug 10 15:30 hello-programs.jar

Archiving artifacts
Finished: SUCCESS
```

---

## 🎯 **Learning Exercises**

### **Exercise 1: Modify the Programs**
1. Edit the HelloWorld program to include your name
2. Modify the Calculator to perform more operations
3. Run the build and see the changes

### **Exercise 2: Add Error Handling**
1. Create a Java program that might fail
2. Add error handling in build steps
3. Test both success and failure scenarios

### **Exercise 3: Environment Variables**
1. Use more Jenkins environment variables
2. Create a program that reads system properties
3. Display build information in your Java programs

---

## 📊 **Expected Learning Outcomes**

After completing this project, you will have:

### **Jenkins Skills**
- ✅ **Freestyle Job Creation** - Complete job setup and configuration
- ✅ **Build Steps** - Multiple shell commands and scripts
- ✅ **Artifact Management** - Archiving build outputs
- ✅ **Build Monitoring** - Understanding console output and logs

### **Java Build Skills**
- ✅ **Java Compilation** - Using javac in automated builds
- ✅ **Java Execution** - Running Java programs in Jenkins
- ✅ **JAR Creation** - Basic packaging with jar command
- ✅ **Build Automation** - Automated compile and run process

---

## 🔍 **Common Issues & Solutions**

### **Java Not Found**
```bash
# Solution: Set JAVA_HOME in build environment
JAVA_HOME=/usr/lib/jvm/java-17-amazon-corretto.x86_64
PATH=$JAVA_HOME/bin:$PATH
```

### **Compilation Errors**
```bash
# Check Java syntax in your source files
# Verify file names match class names
# Ensure proper file encoding
```

### **Permission Issues**
```bash
# Ensure Jenkins has write permissions in workspace
# Check file permissions after creation
```

---

## ➡️ **Next Steps**

Once you've mastered basic Freestyle jobs:

1. **Try Different Programming Languages** - Python, Node.js, etc.
2. **Add More Complex Build Logic** - Conditional builds, loops
3. **Integrate with Version Control** - Git repository integration
4. **Proceed to Maven Jobs** - [3.2 Maven Style Jobs](../3.2_maven_style/README.md)

---

## 📚 **Additional Resources**

- 📖 [Jenkins Freestyle Project Documentation](https://www.jenkins.io/doc/book/using/using-freestyle-projects/)
- 📖 [Java Compilation and Execution](https://docs.oracle.com/javase/tutorial/getStarted/cupojava/)
- 📖 [Jenkins Environment Variables](https://www.jenkins.io/doc/book/pipeline/jenkinsfile/#using-environment-variables)

---

<div align="center">

### 🎯 **Congratulations!**
*You've created your first Jenkins Freestyle job with Java! This is the foundation for all Jenkins automation.*

**Next: [3.2 Maven Style Jobs](../3.2_maven_style/README.md)**

</div>
