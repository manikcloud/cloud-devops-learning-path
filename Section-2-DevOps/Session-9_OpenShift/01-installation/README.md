# OpenShift Installation Guide

## Quick Setup

### Install OpenShift CLI
```bash
# Download and install oc CLI
curl -LO https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-client-linux.tar.gz
tar -xzf openshift-client-linux.tar.gz
sudo mv oc kubectl /usr/local/bin/

# Verify installation
oc version
```

### Local Development Setup
```bash
# Install CodeReady Containers (CRC) for local development
curl -LO https://developers.redhat.com/content-gateway/rest/mirror/pub/openshift-v4/clients/crc/latest/crc-linux-amd64.tar.xz
tar -xf crc-linux-amd64.tar.xz
sudo mv crc-linux-*/crc /usr/local/bin/

# Setup CRC
crc setup
crc start
```

## Resources
- [OpenShift Installation Guide](https://docs.openshift.com/container-platform/latest/installing/index.html)
- [CodeReady Containers](https://developers.redhat.com/products/codeready-containers/overview)
