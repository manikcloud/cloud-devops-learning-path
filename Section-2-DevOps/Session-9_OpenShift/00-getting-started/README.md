# 🚀 **Project 0: Getting Started with OpenShift**

## **What You'll Learn**
- Login to OpenShift from CLI
- Deploy custom Docker image
- Expose application with public URL
- Basic OpenShift commands

## **Prerequisites**
- OpenShift Sandbox account
- `oc` CLI installed

## **Quick Start**
```bash
# 1. Login to OpenShift
oc login --token=<your-token> --server=<your-server>

# 2. Deploy the blue httpd image
oc new-app --name=blue-web varunmanik/httpd:blue

# 3. Expose to get public URL
oc expose svc/blue-web

# 4. Get your URL
echo "Your app: http://$(oc get route blue-web -o jsonpath='{.spec.host}')"
```

## **Alternative: Use YAML**
```bash
# Deploy using YAML file
oc apply -f blue-web.yaml

# Get URL
oc get route blue-web
```

## **Time**: 3 minutes
## **Skills**: CLI login, Image deployment, Route creation
