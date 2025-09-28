# 🚀 OpenShift Application Samples - Quick Start Guide

## Overview
Basic console steps to create projects using OpenShift application samples for different programming languages, based on Red Hat OpenShift 4.8+ application samples.

## Prerequisites
- OpenShift Sandbox account or cluster access
- `oc` CLI installed and configured

---

## 🟢 Node.js Project

### Method 1: Using S2I (Source-to-Image)
```bash
# Login to OpenShift
oc login --token=<your-token> --server=<your-server>

# Create new project
oc new-project nodejs-sample

# Create app from Git repository
oc new-app nodejs~https://github.com/sclorg/nodejs-ex.git

# Expose the service
oc expose svc/nodejs-ex

# Get the route URL
oc get route nodejs-ex
```

### Method 2: Using Application Samples
```bash
# Create from sample template
oc new-app --template=nodejs-mongodb-example

# Or use the Red Hat sample
oc new-app https://github.com/nodeshift-starters/nodejs-rest-http-crud
```

---

## 🐍 Python Project

### Method 1: Using S2I
```bash
# Create new project
oc new-project python-sample

# Create Python Django app
oc new-app python~https://github.com/sclorg/django-ex.git

# Expose the service
oc expose svc/django-ex

# Check status
oc status
```

### Method 2: Using Flask Sample
```bash
# Create Flask application
oc new-app python~https://github.com/sclorg/s2i-python-container.git \
  --context-dir=3.9/test/setup-test-app/ \
  --name=python-flask

# Expose service
oc expose svc/python-flask
```

---

## 💎 Ruby Project

### Method 1: Using S2I
```bash
# Create new project
oc new-project ruby-sample

# Create Ruby on Rails app
oc new-app ruby~https://github.com/sclorg/ruby-ex.git

# Expose the service
oc expose svc/ruby-ex

# Monitor build
oc logs -f bc/ruby-ex
```

### Method 2: Using Sinatra Sample
```bash
# Create Sinatra application
oc new-app ruby~https://github.com/sclorg/s2i-ruby-container.git \
  --context-dir=3.0/test/puma-test-app \
  --name=ruby-sinatra

# Expose service
oc expose svc/ruby-sinatra
```

---

## ☕ Java Project

### Method 1: Using S2I
```bash
# Create new project
oc new-project java-sample

# Create Java application
oc new-app java~https://github.com/jboss-openshift/openshift-quickstarts.git \
  --context-dir=undertow-servlet \
  --name=java-app

# Expose service
oc expose svc/java-app
```

### Method 2: Using Spring Boot
```bash
# Create Spring Boot app
oc new-app java~https://github.com/spring-guides/gs-spring-boot.git \
  --context-dir=complete \
  --name=spring-boot

# Expose service
oc expose svc/spring-boot
```

---

## 🐘 PHP Project

### Using S2I
```bash
# Create new project
oc new-project php-sample

# Create PHP application
oc new-app php~https://github.com/sclorg/cakephp-ex.git

# Expose service
oc expose svc/cakephp-ex

# Check deployment
oc get pods
```

---

## 🔧 .NET Core Project

### Using S2I
```bash
# Create new project
oc new-project dotnet-sample

# Create .NET Core app
oc new-app dotnet~https://github.com/redhat-developer/s2i-dotnetcore-ex.git \
  --context-dir=app \
  --name=dotnet-app

# Expose service
oc expose svc/dotnet-app
```

---

## 🚀 Go Project

### Using S2I
```bash
# Create new project
oc new-project go-sample

# Create Go application
oc new-app golang~https://github.com/sclorg/golang-ex.git

# Expose service
oc expose svc/golang-ex

# Get route
oc get route golang-ex
```

---

## 📊 Common Commands for All Projects

### Check Application Status
```bash
# View all resources
oc get all

# Check pod logs
oc logs -f deployment/<app-name>

# Check build logs
oc logs -f bc/<app-name>

# Describe deployment
oc describe deployment <app-name>
```

### Scale Applications
```bash
# Scale up
oc scale deployment <app-name> --replicas=3

# Scale down
oc scale deployment <app-name> --replicas=1
```

### Environment Variables
```bash
# Set environment variable
oc set env deployment/<app-name> ENV_VAR=value

# View environment variables
oc set env deployment/<app-name> --list
```

### Update Applications
```bash
# Trigger new build
oc start-build <app-name>

# Update from new source
oc patch bc/<app-name> -p '{"spec":{"source":{"git":{"uri":"<new-git-url>"}}}}'
```

---

## 🧹 Cleanup Commands

### Delete Specific Application
```bash
# Delete all resources for an app
oc delete all -l app=<app-name>

# Delete project
oc delete project <project-name>
```

### Delete All Sample Projects
```bash
oc delete project nodejs-sample python-sample ruby-sample java-sample php-sample dotnet-sample go-sample
```

---

## 🔍 Troubleshooting

### Common Issues
```bash
# Check events
oc get events --sort-by=.metadata.creationTimestamp

# Check resource limits
oc describe limitrange

# Check quotas
oc describe quota

# Debug pod
oc debug deployment/<app-name>
```

### Build Failures
```bash
# Check build config
oc describe bc/<app-name>

# View build logs
oc logs build/<build-name>

# Cancel build
oc cancel-build <build-name>
```

---

## 📚 Additional Resources

- [OpenShift S2I Documentation](https://docs.openshift.com/container-platform/latest/builds/understanding-image-builds.html)
- [Application Samples Repository](https://github.com/openshift/origin/tree/master/examples)
- [Red Hat Developer Samples](https://developers.redhat.com/topics/containers)

---

**Duration per project:** 5-10 minutes  
**Total setup time:** 30-60 minutes for all samples  
**Repository:** https://github.com/manikcloud/cloud-devops-learning-path/tree/main/Section-2-DevOps/Session-9_OpenShift
