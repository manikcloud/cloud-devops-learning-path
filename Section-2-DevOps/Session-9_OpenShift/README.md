# 🔴 **Session 9: OpenShift - Enterprise Kubernetes Platform**

## **Overview**
OpenShift is Red Hat's enterprise Kubernetes platform that provides additional developer and operational tools on top of Kubernetes. This session covers the fundamentals of working with OpenShift.

## **What You'll Learn**
- OpenShift vs Kubernetes differences
- OpenShift CLI (oc) usage
- Basic application deployment
- Routes and networking
- OpenShift-specific features

## **Prerequisites**
- Basic Kubernetes knowledge
- OpenShift Sandbox account (free)
- `oc` CLI installed

## **Session Structure**

### **📖 Theory: Kubernetes to OpenShift**
- [Understanding OpenShift](./01-kubernetes-to-openshift/)
- Architecture differences
- Enterprise features
- Security enhancements

### **🚀 Hands-On: Getting Started**
- [Project 0: Getting Started](./00-getting-started/)
- CLI login and basic commands
- Simple application deployment
- Route creation and HTTPS

## **Key Concepts**

### **OpenShift vs Kubernetes**
- **Routes**: OpenShift's ingress solution
- **Source-to-Image (S2I)**: Build process automation
- **Templates**: Application deployment patterns
- **Projects**: Enhanced namespaces with RBAC
- **Security**: Built-in security contexts and policies

### **Essential Commands**
```bash
# Login
oc login --token=<token> --server=<server>

# Deploy from image
oc new-app <image-name>

# Deploy from source
oc new-app <git-url>

# Expose service
oc expose svc/<service-name>

# Get route URL
oc get route <route-name>
```

## **Learning Outcomes**
- ✅ Understand OpenShift architecture and features
- ✅ Deploy applications using OpenShift CLI
- ✅ Create and manage routes for external access
- ✅ Work with OpenShift projects and security
- ✅ Use Source-to-Image builds

## **Next Steps**
- Explore OpenShift Web Console
- Learn about OpenShift Pipelines (Tekton)
- Study OpenShift Operators
- Practice with more complex deployments

## **Resources**
- [OpenShift Documentation](https://docs.openshift.com/)
- [OpenShift Developer Sandbox](https://developers.redhat.com/developer-sandbox)
- [OpenShift CLI Reference](https://docs.openshift.com/container-platform/latest/cli_reference/openshift_cli/getting-started-cli.html)

---

**Duration:** 2 weeks  
**Difficulty:** Intermediate  
**Focus:** Enterprise Kubernetes platform fundamentals
