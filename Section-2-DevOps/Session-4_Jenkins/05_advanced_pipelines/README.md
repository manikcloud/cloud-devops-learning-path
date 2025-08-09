# 🚀 Module 05: Advanced Pipelines

<div align="center">

![Advanced Pipeline](https://img.shields.io/badge/Advanced-Pipeline-purple?style=for-the-badge&logo=jenkins&logoColor=white)
![Parameters](https://img.shields.io/badge/Parameters-Dynamic-blue?style=for-the-badge&logo=settings&logoColor=white)

**🎯 Dynamic Pipelines | ⚙️ Parameters & Variables | 🔄 Pipeline Management**

</div>

---

## 📋 Module Overview

This module covers advanced pipeline features including parameterized builds, dynamic pipeline behavior, and sophisticated pipeline management techniques. You'll learn to create flexible, reusable pipelines.

### 🎯 **Learning Objectives**
- ✅ Implement parameterized pipeline builds
- ✅ Use string and choice parameters effectively
- ✅ Handle Git tags and version parameters
- ✅ Manage pipeline restarts and recovery
- ✅ Create dynamic and flexible pipelines

---

## 🛤️ Module Structure

<table>
<tr>
<th width="10%">Project</th>
<th width="30%">Name</th>
<th width="40%">Description</th>
<th width="20%">Skills</th>
</tr>

<tr>
<td><strong>5.1</strong></td>
<td><strong><a href="./5.1_string_parameter">String Parameters</a></strong></td>
<td>Create pipelines with string input parameters for dynamic builds</td>
<td>Build Parameters, Dynamic Input, String Handling</td>
</tr>

<tr>
<td><strong>5.2</strong></td>
<td><strong><a href="./5.2_tag_parameter">Tag Parameters</a></strong></td>
<td>Implement Git tag-based deployments with version parameters</td>
<td>Git Tags, Version Control, Release Management</td>
</tr>

<tr>
<td><strong>5.3</strong></td>
<td><strong><a href="./5.3_restarting_pipeline">Pipeline Restart</a></strong></td>
<td>Handle pipeline failures, restarts, and recovery mechanisms</td>
<td>Error Recovery, Pipeline Management, Restart Logic</td>
</tr>

</table>

---

## 📚 Theory: Advanced Pipeline Concepts

### **Parameterized Builds**
Parameterized builds allow you to pass dynamic values to your pipeline at runtime, making pipelines flexible and reusable.

#### **Parameter Types:**
- 🔤 **String Parameter** - Text input for dynamic values
- 📋 **Choice Parameter** - Dropdown selection from predefined options
- ☑️ **Boolean Parameter** - True/false checkbox
- 📁 **File Parameter** - File upload capability
- 🔢 **Multi-line String** - Large text input areas

#### **Benefits:**
- 🔄 **Reusability** - Same pipeline for different environments
- 🎯 **Flexibility** - Runtime decision making
- 👥 **User Interaction** - Manual input when needed
- 🔧 **Configuration** - Environment-specific settings

### **Dynamic Pipeline Behavior**
Advanced pipelines can adapt their behavior based on parameters, environment conditions, or runtime decisions.

#### **Key Techniques:**
- 🔄 **Conditional Stages** - Execute stages based on conditions
- 🌿 **Branch-based Logic** - Different behavior per Git branch
- 📊 **Environment Detection** - Adapt to deployment targets
- 🎯 **Feature Toggles** - Enable/disable pipeline features

---

## 🔧 **Parameter Implementation**

### **String Parameters**
```groovy
pipeline {
    agent any
    
    parameters {
        string(
            name: 'ENVIRONMENT',
            defaultValue: 'staging',
            description: 'Target deployment environment'
        )
        string(
            name: 'VERSION',
            defaultValue: '1.0.0',
            description: 'Application version to deploy'
        )
    }
    
    stages {
        stage('Deploy') {
            steps {
                echo "Deploying version ${params.VERSION} to ${params.ENVIRONMENT}"
                sh "deploy.sh --env=${params.ENVIRONMENT} --version=${params.VERSION}"
            }
        }
    }
}
```

### **Choice Parameters**
```groovy
parameters {
    choice(
        name: 'DEPLOY_TARGET',
        choices: ['staging', 'production', 'development'],
        description: 'Select deployment target'
    )
    choice(
        name: 'BUILD_TYPE',
        choices: ['release', 'debug', 'profile'],
        description: 'Build configuration type'
    )
}
```

### **Boolean Parameters**
```groovy
parameters {
    booleanParam(
        name: 'SKIP_TESTS',
        defaultValue: false,
        description: 'Skip test execution'
    )
    booleanParam(
        name: 'DEPLOY_IMMEDIATELY',
        defaultValue: true,
        description: 'Deploy after successful build'
    )
}
```

---

## 🏷️ **Git Tag Management**

### **Tag-based Deployments**
```groovy
pipeline {
    agent any
    
    parameters {
        gitParameter(
            name: 'TAG',
            type: 'PT_TAG',
            defaultValue: 'main',
            description: 'Select Git tag for deployment'
        )
    }
    
    stages {
        stage('Checkout Tag') {
            steps {
                checkout([
                    $class: 'GitSCM',
                    branches: [[name: "refs/tags/${params.TAG}"]],
                    userRemoteConfigs: [[url: 'https://github.com/user/repo.git']]
                ])
            }
        }
        
        stage('Build from Tag') {
            steps {
                sh "echo 'Building from tag: ${params.TAG}'"
                sh 'mvn clean package'
            }
        }
    }
}
```

### **Version Extraction**
```groovy
stage('Extract Version') {
    steps {
        script {
            def version = sh(
                script: "git describe --tags --abbrev=0",
                returnStdout: true
            ).trim()
            
            env.BUILD_VERSION = version
            echo "Building version: ${env.BUILD_VERSION}"
        }
    }
}
```

---

## 🔄 **Pipeline Recovery & Restart**

### **Error Handling**
```groovy
pipeline {
    agent any
    
    stages {
        stage('Build') {
            steps {
                script {
                    try {
                        sh 'mvn clean package'
                    } catch (Exception e) {
                        echo "Build failed: ${e.getMessage()}"
                        currentBuild.result = 'FAILURE'
                        error("Build stage failed")
                    }
                }
            }
        }
    }
    
    post {
        failure {
            echo 'Pipeline failed - check logs for details'
            // Send notifications, cleanup, etc.
        }
        
        unstable {
            echo 'Pipeline completed with warnings'
        }
    }
}
```

### **Retry Logic**
```groovy
stage('Deploy with Retry') {
    steps {
        retry(3) {
            sh 'deploy.sh'
        }
    }
}
```

### **Timeout Management**
```groovy
stage('Long Running Task') {
    steps {
        timeout(time: 10, unit: 'MINUTES') {
            sh 'long-running-process.sh'
        }
    }
}
```

---

## 🎯 **Advanced Patterns**

### **Multi-Environment Pipeline**
```groovy
pipeline {
    agent any
    
    parameters {
        choice(
            name: 'ENVIRONMENT',
            choices: ['dev', 'staging', 'production'],
            description: 'Target environment'
        )
    }
    
    stages {
        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }
        
        stage('Deploy to Dev') {
            when {
                expression { params.ENVIRONMENT == 'dev' }
            }
            steps {
                sh 'deploy-dev.sh'
            }
        }
        
        stage('Deploy to Staging') {
            when {
                expression { params.ENVIRONMENT == 'staging' }
            }
            steps {
                sh 'deploy-staging.sh'
            }
        }
        
        stage('Deploy to Production') {
            when {
                allOf {
                    expression { params.ENVIRONMENT == 'production' }
                    branch 'main'
                }
            }
            input {
                message "Deploy to production?"
                ok "Deploy"
            }
            steps {
                sh 'deploy-production.sh'
            }
        }
    }
}
```

### **Feature Flag Pipeline**
```groovy
pipeline {
    agent any
    
    parameters {
        booleanParam(name: 'ENABLE_FEATURE_X', defaultValue: false)
        booleanParam(name: 'RUN_PERFORMANCE_TESTS', defaultValue: true)
        booleanParam(name: 'DEPLOY_TO_STAGING', defaultValue: true)
    }
    
    stages {
        stage('Build') {
            steps {
                script {
                    def buildFlags = []
                    if (params.ENABLE_FEATURE_X) {
                        buildFlags.add('-DFEATURE_X=true')
                    }
                    
                    sh "mvn clean package ${buildFlags.join(' ')}"
                }
            }
        }
        
        stage('Performance Tests') {
            when {
                expression { params.RUN_PERFORMANCE_TESTS }
            }
            steps {
                sh 'run-performance-tests.sh'
            }
        }
    }
}
```

---

## 🚀 Getting Started

### **Prerequisites**
- ✅ Completed Module 04 (Pipeline Fundamentals)
- ✅ Understanding of Git workflows
- ✅ Basic Groovy scripting knowledge
- ✅ Experience with Jenkins parameters

### **Best Practices**
- 🎯 **Parameter Validation** - Always validate input parameters
- 📝 **Clear Descriptions** - Provide helpful parameter descriptions
- 🔒 **Security** - Never expose sensitive data in parameters
- 🔄 **Default Values** - Always provide sensible defaults

---

## 📊 Expected Outcomes

After completing this module, you will have:

### **Advanced Skills**
- ✅ **Dynamic Pipelines** - Create flexible, parameterized builds
- ✅ **Version Management** - Handle Git tags and versioning
- ✅ **Error Recovery** - Implement robust error handling
- ✅ **Pipeline Optimization** - Create efficient, reusable pipelines

### **Professional Techniques**
- ✅ **Production Patterns** - Industry-standard pipeline designs
- ✅ **User Experience** - Create user-friendly parameter interfaces
- ✅ **Maintenance** - Build maintainable pipeline code
- ✅ **Troubleshooting** - Debug complex pipeline issues

---

## ➡️ Next Steps

Once you've mastered advanced pipelines:
1. **Practice Complex Scenarios** - Multi-parameter pipelines
2. **Explore Pipeline Libraries** - Shared pipeline code
3. **Proceed to Module 06** - [Testing Integration](../06_testing_integration/README.md)

---

<div align="center">

### 🎯 **Ready for Advanced Pipeline Mastery?**

**Start Advanced Learning: [5.1 String Parameters](./5.1_string_parameter/README.md)**

*Build dynamic, flexible pipelines for production environments!*

</div>
