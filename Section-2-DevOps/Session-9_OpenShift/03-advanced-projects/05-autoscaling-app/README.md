# 📈 **Project 5: Auto-Scaling Web App**

## **What You'll Build**
A simple web app that automatically scales based on CPU usage.

## **Components**
- Web app that can generate CPU load
- Horizontal Pod Autoscaler (HPA)
- Load testing tool

## **Quick Deploy**
```bash
# Create project
oc new-project scaling-demo-$(whoami)

# Deploy app
oc apply -f app.yaml

# Create autoscaler
oc autoscale deployment webapp --cpu-percent=50 --min=1 --max=5

# Generate load and watch scaling
oc apply -f load-test.yaml
```

## **Watch Scaling**
```bash
# Watch pods scale up/down
watch oc get pods

# Check HPA status
oc get hpa
```

## **Time**: 8 minutes
## **Skills**: Auto-scaling, Resource management, Load testing
