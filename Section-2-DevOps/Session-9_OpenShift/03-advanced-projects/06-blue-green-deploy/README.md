# 🔄 **Project 6: Blue-Green Deployment**

## **What You'll Build**
Learn zero-downtime deployments by switching between two app versions.

## **Components**
- Blue version (v1.0) - Original app
- Green version (v2.0) - New app version
- Service that switches between versions

## **Quick Deploy**
```bash
# Create project
oc new-project blue-green-$(whoami)

# Deploy blue version
oc apply -f blue-version.yaml

# Test blue version
oc get route app

# Deploy green version
oc apply -f green-version.yaml

# Switch to green (zero downtime!)
oc patch service app -p '{"spec":{"selector":{"version":"green"}}}'
```

## **Switch Between Versions**
```bash
# Switch to blue
oc patch service app -p '{"spec":{"selector":{"version":"blue"}}}'

# Switch to green  
oc patch service app -p '{"spec":{"selector":{"version":"green"}}}'
```

## **Time**: 12 minutes
## **Skills**: Zero-downtime deployment, Traffic switching, Version management
