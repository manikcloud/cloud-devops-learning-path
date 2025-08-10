# ⚙️ Project 5.1: String Parameters - Freestyle to Pipeline

<div align="center">

![Freestyle First](https://img.shields.io/badge/Freestyle-First-blue?style=for-the-badge&logo=jenkins&logoColor=white)
![Parameters](https://img.shields.io/badge/String-Parameters-green?style=for-the-badge&logo=settings&logoColor=white)

**🎯 Start with Freestyle Parameters | 📜 Convert to Pipeline | 🚀 Dynamic Builds**

</div>

---

## 📋 Project Overview

This project teaches you to create parameterized builds using **Freestyle jobs first**, then convert to **Pipeline**. You'll learn how to make your builds dynamic and flexible using string parameters.

### 🎯 **Learning Objectives**
- ✅ Create parameterized Freestyle jobs with string inputs
- ✅ Use parameters in build steps and scripts
- ✅ Convert parameterized Freestyle to Pipeline
- ✅ Compare parameter handling in both methods
- ✅ Build dynamic, flexible automation

---

## 🔧 **Method 1: Freestyle Job with Parameters (Primary Focus)**

### **Step 1: Create Parameterized Freestyle Job**

1. **Navigate to Jenkins Dashboard**
   - Click "New Item"
   - Enter job name: `parameterized-build-freestyle`
   - Select "Freestyle project"
   - Click "OK"

### **Step 2: Configure Parameters**

In the **General** section:

1. **Check:** "This project is parameterized"
2. **Click:** "Add Parameter" → "String Parameter"

#### **Parameter 1: Application Name**
```
Name: APP_NAME
Default Value: my-web-app
Description: Name of the application to build
```

#### **Parameter 2: Environment**
```
Name: ENVIRONMENT
Default Value: development
Description: Target environment (development, staging, production)
```

#### **Parameter 3: Version**
```
Name: VERSION
Default Value: 1.0.0
Description: Application version to build
```

#### **Parameter 4: Build Options**
```
Name: BUILD_OPTIONS
Default Value: clean compile
Description: Maven build options (e.g., clean compile test package)
```

#### **Parameter 5: Deploy Target**
```
Name: DEPLOY_TARGET
Default Value: localhost
Description: Server hostname or IP address for deployment
```

### **Step 3: Build Environment**

```bash
✅ Delete workspace before build starts
✅ Add timestamps to the Console Output

# Additional Environment Variables
BUILD_USER=jenkins
JAVA_OPTS=-Xmx1024m
```

### **Step 4: Build Steps**

#### **Build Step 1: Display Parameters**

```bash
#!/bin/bash
echo "========================================="
echo "    PARAMETERIZED BUILD INFORMATION"
echo "========================================="
echo "Application Name: $APP_NAME"
echo "Environment: $ENVIRONMENT"
echo "Version: $VERSION"
echo "Build Options: $BUILD_OPTIONS"
echo "Deploy Target: $DEPLOY_TARGET"
echo "Build Number: $BUILD_NUMBER"
echo "Job Name: $JOB_NAME"
echo "Workspace: $WORKSPACE"
echo "Build User: $BUILD_USER"
echo "========================================="
echo ""
```

#### **Build Step 2: Validate Parameters**

```bash
#!/bin/bash
echo "=== Parameter Validation ==="

# Validate APP_NAME
if [ -z "$APP_NAME" ]; then
    echo "❌ ERROR: APP_NAME parameter is required"
    exit 1
else
    echo "✅ APP_NAME: $APP_NAME"
fi

# Validate ENVIRONMENT
case "$ENVIRONMENT" in
    development|staging|production)
        echo "✅ ENVIRONMENT: $ENVIRONMENT (valid)"
        ;;
    *)
        echo "❌ ERROR: Invalid environment '$ENVIRONMENT'. Must be: development, staging, or production"
        exit 1
        ;;
esac

# Validate VERSION format (basic check)
if [[ ! "$VERSION" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "⚠️  WARNING: VERSION '$VERSION' doesn't follow semantic versioning (x.y.z)"
else
    echo "✅ VERSION: $VERSION (valid format)"
fi

# Validate DEPLOY_TARGET
if [ -z "$DEPLOY_TARGET" ]; then
    echo "❌ ERROR: DEPLOY_TARGET parameter is required"
    exit 1
else
    echo "✅ DEPLOY_TARGET: $DEPLOY_TARGET"
fi

echo "✅ All parameters validated successfully!"
echo ""
```

#### **Build Step 3: Environment-Specific Configuration**

```bash
#!/bin/bash
echo "=== Environment-Specific Configuration ==="

# Set environment-specific variables
case "$ENVIRONMENT" in
    development)
        DB_HOST="dev-db.company.com"
        DB_PORT="3306"
        LOG_LEVEL="DEBUG"
        REPLICAS="1"
        ;;
    staging)
        DB_HOST="staging-db.company.com"
        DB_PORT="3306"
        LOG_LEVEL="INFO"
        REPLICAS="2"
        ;;
    production)
        DB_HOST="prod-db.company.com"
        DB_PORT="3306"
        LOG_LEVEL="WARN"
        REPLICAS="3"
        ;;
esac

echo "Database Host: $DB_HOST"
echo "Database Port: $DB_PORT"
echo "Log Level: $LOG_LEVEL"
echo "Replicas: $REPLICAS"

# Create environment configuration file
cat > app-config.properties << EOF
# Application Configuration for $ENVIRONMENT
app.name=$APP_NAME
app.version=$VERSION
app.environment=$ENVIRONMENT

# Database Configuration
db.host=$DB_HOST
db.port=$DB_PORT

# Logging Configuration
logging.level=$LOG_LEVEL

# Deployment Configuration
deploy.target=$DEPLOY_TARGET
deploy.replicas=$REPLICAS

# Build Information
build.number=$BUILD_NUMBER
build.timestamp=$(date)
build.user=$BUILD_USER
EOF

echo "✅ Configuration file created: app-config.properties"
cat app-config.properties
echo ""
```

#### **Build Step 4: Simulate Build Process**

```bash
#!/bin/bash
echo "=== Simulated Build Process ==="

# Create application directory structure
mkdir -p build/$APP_NAME-$VERSION

# Simulate Maven build with parameters
echo "🔨 Running Maven build with options: $BUILD_OPTIONS"
echo "mvn $BUILD_OPTIONS -Dapp.name=$APP_NAME -Dapp.version=$VERSION -Dapp.env=$ENVIRONMENT"

# Simulate build artifacts
echo "Creating build artifacts..."
echo "Application: $APP_NAME" > build/$APP_NAME-$VERSION/app-info.txt
echo "Version: $VERSION" >> build/$APP_NAME-$VERSION/app-info.txt
echo "Environment: $ENVIRONMENT" >> build/$APP_NAME-$VERSION/app-info.txt
echo "Build Number: $BUILD_NUMBER" >> build/$APP_NAME-$VERSION/app-info.txt

# Create mock JAR file
echo "Mock JAR content for $APP_NAME version $VERSION" > build/$APP_NAME-$VERSION/$APP_NAME-$VERSION.jar

# Copy configuration
cp app-config.properties build/$APP_NAME-$VERSION/

echo "✅ Build completed successfully!"
echo "📦 Artifacts created in: build/$APP_NAME-$VERSION/"
ls -la build/$APP_NAME-$VERSION/
echo ""
```

#### **Build Step 5: Deployment Simulation**

```bash
#!/bin/bash
echo "=== Deployment Simulation ==="

echo "🚀 Deploying $APP_NAME version $VERSION to $ENVIRONMENT environment"
echo "Target server: $DEPLOY_TARGET"

# Simulate deployment based on environment
case "$ENVIRONMENT" in
    development)
        echo "📋 Development deployment - no approval required"
        echo "scp build/$APP_NAME-$VERSION/* user@$DEPLOY_TARGET:/opt/dev/$APP_NAME/"
        ;;
    staging)
        echo "📋 Staging deployment - automated deployment"
        echo "scp build/$APP_NAME-$VERSION/* user@$DEPLOY_TARGET:/opt/staging/$APP_NAME/"
        echo "ssh user@$DEPLOY_TARGET 'systemctl restart $APP_NAME-staging'"
        ;;
    production)
        echo "📋 Production deployment - requires manual approval"
        echo "⚠️  Production deployment would require additional approval steps"
        echo "Deployment command: scp build/$APP_NAME-$VERSION/* user@$DEPLOY_TARGET:/opt/prod/$APP_NAME/"
        ;;
esac

# Create deployment summary
cat > deployment-summary.txt << EOF
Deployment Summary
==================
Application: $APP_NAME
Version: $VERSION
Environment: $ENVIRONMENT
Target: $DEPLOY_TARGET
Build Number: $BUILD_NUMBER
Deployment Time: $(date)
Status: Simulated Success
EOF

echo "✅ Deployment simulation completed!"
cat deployment-summary.txt
echo ""
```

### **Step 5: Post-build Actions**

#### **Archive Artifacts**
```
Files to archive: build/**/*.*, *.properties, deployment-summary.txt
```

#### **Email Notification**
```
Recipients: dev-team@company.com
Subject: Build Complete - $APP_NAME v$VERSION ($ENVIRONMENT)
Send email for: Failure, Unstable, Back to Normal
```

### **Step 6: Test Your Parameterized Freestyle Job**

1. **Save the job configuration**
2. **Click "Build with Parameters"**
3. **Try different parameter combinations:**
   - APP_NAME: `user-service`, ENVIRONMENT: `development`
   - APP_NAME: `payment-api`, ENVIRONMENT: `staging`, VERSION: `2.1.0`
   - APP_NAME: `web-frontend`, ENVIRONMENT: `production`, VERSION: `1.5.2`

### **Expected Freestyle Output:**
```
Started by user admin
Building in workspace /var/lib/jenkins/workspace/parameterized-build-freestyle
[parameterized-build-freestyle] $ /bin/bash /tmp/jenkins456.sh
=========================================
    PARAMETERIZED BUILD INFORMATION
=========================================
Application Name: user-service
Environment: staging
Version: 2.1.0
Build Options: clean compile test package
Deploy Target: staging-server.company.com
Build Number: 5
Job Name: parameterized-build-freestyle
Workspace: /var/lib/jenkins/workspace/parameterized-build-freestyle
Build User: jenkins
=========================================

=== Parameter Validation ===
✅ APP_NAME: user-service
✅ ENVIRONMENT: staging (valid)
✅ VERSION: 2.1.0 (valid format)
✅ DEPLOY_TARGET: staging-server.company.com
✅ All parameters validated successfully!

=== Environment-Specific Configuration ===
Database Host: staging-db.company.com
Database Port: 3306
Log Level: INFO
Replicas: 2
✅ Configuration file created: app-config.properties

=== Simulated Build Process ===
🔨 Running Maven build with options: clean compile test package
mvn clean compile test package -Dapp.name=user-service -Dapp.version=2.1.0 -Dapp.env=staging
Creating build artifacts...
✅ Build completed successfully!
📦 Artifacts created in: build/user-service-2.1.0/

=== Deployment Simulation ===
🚀 Deploying user-service version 2.1.0 to staging environment
Target server: staging-server.company.com
📋 Staging deployment - automated deployment
scp build/user-service-2.1.0/* user@staging-server.company.com:/opt/staging/user-service/
ssh user@staging-server.company.com 'systemctl restart user-service-staging'
✅ Deployment simulation completed!

Archiving artifacts
Finished: SUCCESS
```

---

## 📜 **Method 2: Convert to Pipeline**

Now let's convert the same functionality to a Pipeline:

### **Step 1: Create Pipeline Job**

1. **Create new item:** `parameterized-build-pipeline`
2. **Select:** "Pipeline"
3. **Click:** "OK"

### **Step 2: Pipeline Script**

```groovy
pipeline {
    agent any
    
    parameters {
        string(
            name: 'APP_NAME',
            defaultValue: 'my-web-app',
            description: 'Name of the application to build'
        )
        string(
            name: 'ENVIRONMENT',
            defaultValue: 'development',
            description: 'Target environment (development, staging, production)'
        )
        string(
            name: 'VERSION',
            defaultValue: '1.0.0',
            description: 'Application version to build'
        )
        string(
            name: 'BUILD_OPTIONS',
            defaultValue: 'clean compile',
            description: 'Maven build options (e.g., clean compile test package)'
        )
        string(
            name: 'DEPLOY_TARGET',
            defaultValue: 'localhost',
            description: 'Server hostname or IP address for deployment'
        )
    }
    
    environment {
        BUILD_USER = 'jenkins'
        JAVA_OPTS = '-Xmx1024m'
    }
    
    options {
        buildDiscarder(logRotator(numToKeepStr: '10'))
        timestamps()
    }
    
    stages {
        stage('📋 Display Parameters') {
            steps {
                echo '========================================='
                echo '    PARAMETERIZED BUILD INFORMATION'
                echo '========================================='
                echo "Application Name: ${params.APP_NAME}"
                echo "Environment: ${params.ENVIRONMENT}"
                echo "Version: ${params.VERSION}"
                echo "Build Options: ${params.BUILD_OPTIONS}"
                echo "Deploy Target: ${params.DEPLOY_TARGET}"
                echo "Build Number: ${env.BUILD_NUMBER}"
                echo "Job Name: ${env.JOB_NAME}"
                echo "Workspace: ${env.WORKSPACE}"
                echo "Build User: ${env.BUILD_USER}"
                echo '========================================='
            }
        }
        
        stage('✅ Validate Parameters') {
            steps {
                echo '=== Parameter Validation ==='
                script {
                    // Validate APP_NAME
                    if (!params.APP_NAME?.trim()) {
                        error("❌ ERROR: APP_NAME parameter is required")
                    }
                    echo "✅ APP_NAME: ${params.APP_NAME}"
                    
                    // Validate ENVIRONMENT
                    def validEnvironments = ['development', 'staging', 'production']
                    if (!validEnvironments.contains(params.ENVIRONMENT)) {
                        error("❌ ERROR: Invalid environment '${params.ENVIRONMENT}'. Must be: ${validEnvironments.join(', ')}")
                    }
                    echo "✅ ENVIRONMENT: ${params.ENVIRONMENT} (valid)"
                    
                    // Validate VERSION format
                    if (!params.VERSION.matches(/^\d+\.\d+\.\d+$/)) {
                        echo "⚠️  WARNING: VERSION '${params.VERSION}' doesn't follow semantic versioning (x.y.z)"
                    } else {
                        echo "✅ VERSION: ${params.VERSION} (valid format)"
                    }
                    
                    // Validate DEPLOY_TARGET
                    if (!params.DEPLOY_TARGET?.trim()) {
                        error("❌ ERROR: DEPLOY_TARGET parameter is required")
                    }
                    echo "✅ DEPLOY_TARGET: ${params.DEPLOY_TARGET}"
                    
                    echo "✅ All parameters validated successfully!"
                }
            }
        }
        
        stage('⚙️ Environment Configuration') {
            steps {
                echo '=== Environment-Specific Configuration ==='
                script {
                    def config = [:]
                    
                    switch(params.ENVIRONMENT) {
                        case 'development':
                            config = [
                                dbHost: 'dev-db.company.com',
                                dbPort: '3306',
                                logLevel: 'DEBUG',
                                replicas: '1'
                            ]
                            break
                        case 'staging':
                            config = [
                                dbHost: 'staging-db.company.com',
                                dbPort: '3306',
                                logLevel: 'INFO',
                                replicas: '2'
                            ]
                            break
                        case 'production':
                            config = [
                                dbHost: 'prod-db.company.com',
                                dbPort: '3306',
                                logLevel: 'WARN',
                                replicas: '3'
                            ]
                            break
                    }
                    
                    echo "Database Host: ${config.dbHost}"
                    echo "Database Port: ${config.dbPort}"
                    echo "Log Level: ${config.logLevel}"
                    echo "Replicas: ${config.replicas}"
                    
                    // Store config for later stages
                    env.DB_HOST = config.dbHost
                    env.DB_PORT = config.dbPort
                    env.LOG_LEVEL = config.logLevel
                    env.REPLICAS = config.replicas
                }
                
                // Create configuration file
                writeFile file: 'app-config.properties', text: """# Application Configuration for ${params.ENVIRONMENT}
app.name=${params.APP_NAME}
app.version=${params.VERSION}
app.environment=${params.ENVIRONMENT}

# Database Configuration
db.host=${env.DB_HOST}
db.port=${env.DB_PORT}

# Logging Configuration
logging.level=${env.LOG_LEVEL}

# Deployment Configuration
deploy.target=${params.DEPLOY_TARGET}
deploy.replicas=${env.REPLICAS}

# Build Information
build.number=${env.BUILD_NUMBER}
build.timestamp=${new Date()}
build.user=${env.BUILD_USER}
"""
                
                echo "✅ Configuration file created: app-config.properties"
                sh 'cat app-config.properties'
            }
        }
        
        stage('🔨 Build Process') {
            steps {
                echo '=== Simulated Build Process ==='
                sh """
                    # Create application directory structure
                    mkdir -p build/${params.APP_NAME}-${params.VERSION}
                    
                    echo "🔨 Running Maven build with options: ${params.BUILD_OPTIONS}"
                    echo "mvn ${params.BUILD_OPTIONS} -Dapp.name=${params.APP_NAME} -Dapp.version=${params.VERSION} -Dapp.env=${params.ENVIRONMENT}"
                    
                    # Simulate build artifacts
                    echo "Creating build artifacts..."
                    echo "Application: ${params.APP_NAME}" > build/${params.APP_NAME}-${params.VERSION}/app-info.txt
                    echo "Version: ${params.VERSION}" >> build/${params.APP_NAME}-${params.VERSION}/app-info.txt
                    echo "Environment: ${params.ENVIRONMENT}" >> build/${params.APP_NAME}-${params.VERSION}/app-info.txt
                    echo "Build Number: ${env.BUILD_NUMBER}" >> build/${params.APP_NAME}-${params.VERSION}/app-info.txt
                    
                    # Create mock JAR file
                    echo "Mock JAR content for ${params.APP_NAME} version ${params.VERSION}" > build/${params.APP_NAME}-${params.VERSION}/${params.APP_NAME}-${params.VERSION}.jar
                    
                    # Copy configuration
                    cp app-config.properties build/${params.APP_NAME}-${params.VERSION}/
                    
                    echo "✅ Build completed successfully!"
                    echo "📦 Artifacts created in: build/${params.APP_NAME}-${params.VERSION}/"
                    ls -la build/${params.APP_NAME}-${params.VERSION}/
                """
            }
        }
        
        stage('🚀 Deployment') {
            steps {
                echo '=== Deployment Simulation ==='
                echo "🚀 Deploying ${params.APP_NAME} version ${params.VERSION} to ${params.ENVIRONMENT} environment"
                echo "Target server: ${params.DEPLOY_TARGET}"
                
                script {
                    switch(params.ENVIRONMENT) {
                        case 'development':
                            echo "📋 Development deployment - no approval required"
                            echo "scp build/${params.APP_NAME}-${params.VERSION}/* user@${params.DEPLOY_TARGET}:/opt/dev/${params.APP_NAME}/"
                            break
                        case 'staging':
                            echo "📋 Staging deployment - automated deployment"
                            echo "scp build/${params.APP_NAME}-${params.VERSION}/* user@${params.DEPLOY_TARGET}:/opt/staging/${params.APP_NAME}/"
                            echo "ssh user@${params.DEPLOY_TARGET} 'systemctl restart ${params.APP_NAME}-staging'"
                            break
                        case 'production':
                            echo "📋 Production deployment - requires manual approval"
                            echo "⚠️  Production deployment would require additional approval steps"
                            echo "Deployment command: scp build/${params.APP_NAME}-${params.VERSION}/* user@${params.DEPLOY_TARGET}:/opt/prod/${params.APP_NAME}/"
                            break
                    }
                }
                
                // Create deployment summary
                writeFile file: 'deployment-summary.txt', text: """Deployment Summary
==================
Application: ${params.APP_NAME}
Version: ${params.VERSION}
Environment: ${params.ENVIRONMENT}
Target: ${params.DEPLOY_TARGET}
Build Number: ${env.BUILD_NUMBER}
Deployment Time: ${new Date()}
Status: Simulated Success
"""
                
                echo "✅ Deployment simulation completed!"
                sh 'cat deployment-summary.txt'
            }
        }
    }
    
    post {
        always {
            archiveArtifacts artifacts: 'build/**/*.*, *.properties, deployment-summary.txt', allowEmptyArchive: true
        }
        success {
            echo "✅ Parameterized build completed successfully!"
            emailext (
                subject: "✅ Build Complete - ${params.APP_NAME} v${params.VERSION} (${params.ENVIRONMENT})",
                body: """
                    Build completed successfully!
                    
                    Application: ${params.APP_NAME}
                    Version: ${params.VERSION}
                    Environment: ${params.ENVIRONMENT}
                    Build Number: ${env.BUILD_NUMBER}
                    
                    Build URL: ${env.BUILD_URL}
                """,
                to: "dev-team@company.com"
            )
        }
        failure {
            echo "❌ Parameterized build failed!"
        }
    }
}
```

---

## 📊 **Comparison: Freestyle vs Pipeline Parameters**

### **Freestyle Parameter Advantages:**
- 🎯 **Visual Interface** - Easy parameter setup through GUI
- 🔧 **Quick Configuration** - Point and click parameter addition
- 👥 **User Friendly** - Non-technical users can configure
- 📊 **Immediate Feedback** - See parameter form immediately
- 🔄 **Simple Testing** - Easy to test different parameter values

### **Pipeline Parameter Advantages:**
- ✅ **Version Controlled** - Parameters defined in code
- ✅ **Complex Validation** - Advanced parameter validation logic
- ✅ **Dynamic Behavior** - Parameters can influence pipeline structure
- ✅ **Better Integration** - Seamless integration with pipeline logic
- ✅ **Reusable** - Parameter definitions can be shared

---

## 🎯 **Parameter Best Practices**

### **Parameter Design:**
- 📝 **Clear Names** - Use descriptive parameter names
- 📋 **Good Descriptions** - Provide helpful parameter descriptions
- 🔧 **Sensible Defaults** - Always provide reasonable default values
- ✅ **Validation** - Validate parameters before use
- 🔒 **Security** - Never expose sensitive data in parameters

### **Parameter Usage:**
- 🎯 **Environment Specific** - Use parameters for environment differences
- 🔄 **Version Control** - Use parameters for version management
- 🚀 **Deployment Targets** - Parameterize deployment destinations
- 🔧 **Build Options** - Make build processes configurable
- 📊 **Feature Flags** - Use boolean parameters for feature toggles

---

## 🚀 **Hands-On Exercises**

### **Exercise 1: Basic Parameters**
1. Create both Freestyle and Pipeline versions
2. Test with different parameter combinations
3. Compare the user experience

### **Exercise 2: Parameter Validation**
1. Add validation for all parameters
2. Test with invalid values
3. Compare error handling approaches

### **Exercise 3: Advanced Parameters**
1. Add choice parameters for environment
2. Add boolean parameters for features
3. Create conditional logic based on parameters

---

## 📊 **Expected Learning Outcomes**

After completing this project, you will understand:

### **Parameter Mastery**
- ✅ **Parameter Types** - String, choice, boolean, file parameters
- ✅ **Parameter Usage** - How to use parameters in builds
- ✅ **Validation Techniques** - Parameter validation strategies
- ✅ **Best Practices** - Professional parameter design

### **Dynamic Builds**
- ✅ **Flexible Automation** - Creating adaptable build processes
- ✅ **Environment Management** - Handling multiple environments
- ✅ **User Interaction** - Building user-friendly automation
- ✅ **Conditional Logic** - Parameter-driven decision making

---

## ➡️ **Next Steps**

Once you've mastered string parameters:

1. **Try Choice Parameters** - Dropdown selections
2. **Add Boolean Parameters** - Feature toggles
3. **Experiment with File Parameters** - File uploads
4. **Proceed to Next Project** - [5.2 Tag Parameters](../5.2_tag_parameter/README.md)

---

<div align="center">

### 🎯 **Build Dynamic, Flexible Automation!**
*Parameterized builds are essential for professional CI/CD systems.*

**Next: [5.2 Tag Parameters](../5.2_tag_parameter/README.md)**

</div>
