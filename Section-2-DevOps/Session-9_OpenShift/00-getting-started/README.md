# 🚀 **Project 0: Getting Started with OpenShift**

## **What You'll Learn**
- Login to OpenShift from CLI
- Deploy web application
- Expose application with HTTPS URL
- Basic OpenShift commands

## **Prerequisites**
- OpenShift Sandbox account
- `oc` CLI installed

## **Quick Start**
```bash
# 1. Login to OpenShift
oc login --token=<your-token> --server=<your-server>

# 2. Deploy the web application
oc apply -f blue-web.yaml

# 3. Get your HTTPS URL
echo "Your app: https://$(oc get route blue-web -o jsonpath='{.spec.host}')"
```

## **Alternative: CLI Commands**
```bash
# Deploy nginx with proper port
oc new-app --name=blue-web nginx:alpine
oc patch deployment blue-web -p '{"spec":{"template":{"spec":{"containers":[{"name":"blue-web","ports":[{"containerPort":8080}],"env":[{"name":"PORT","value":"8080"}]}]}}}}'
oc expose svc/blue-web
oc create route edge --service=blue-web
```

## **Time**: 3 minutes
## **Skills**: CLI login, HTTPS deployment, Route creation
