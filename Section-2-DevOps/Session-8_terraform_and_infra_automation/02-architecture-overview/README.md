# 🏗️ Module 2: Architecture Overview (8 minutes)

<div align="center">

![Architecture](https://img.shields.io/badge/Module_2-Architecture-purple?style=for-the-badge&logo=terraform&logoColor=white)
![Duration](https://img.shields.io/badge/Duration-8_Minutes-green?style=for-the-badge&logo=clock&logoColor=white)

**🎯 Core Components | 🔄 Workflow Understanding | 📊 System Design**

</div>

---

## 🎯 **Learning Objectives**

By the end of this module, you'll understand:
- ✅ Terraform's core architecture components
- ✅ How the Terraform workflow operates
- ✅ Provider ecosystem and state management
- ✅ The relationship between configuration, state, and infrastructure

---

## 🏗️ **Terraform Core Architecture**

### **High-Level System Overview**

```mermaid
graph TB
    subgraph "User Interface"
        A[Terraform CLI]
        B["Configuration Files (.tf files)"]
    end
    
    subgraph "Terraform Core"
        C[Configuration Parser]
        D[Resource Graph Builder]
        E[State Manager]
        F[Plan Engine]
        G[Apply Engine]
    end
    
    subgraph "Provider Layer"
        H[AWS Provider]
        I[Azure Provider]
        J[GCP Provider]
        K[Kubernetes Provider]
        L["3000+ Other Providers"]
    end
    
    subgraph "Infrastructure"
        M[AWS Resources]
        N[Azure Resources]
        O[GCP Resources]
        P[K8s Resources]
        Q[Other Resources]
    end
    
    subgraph "State Storage"
        R[Local State]
        S["Remote State (S3, Terraform Cloud)"]
    end
    
    A --> C
    B --> C
    C --> D
    D --> E
    E --> F
    F --> G
    
    G --> H
    G --> I
    G --> J
    G --> K
    G --> L
    
    H --> M
    I --> N
    J --> O
    K --> P
    L --> Q
    
    E --> R
    E --> S
    
    style A fill:#e3f2fd
    style C fill:#f3e5f5
    style E fill:#fff3e0
    style H fill:#e8f5e8
    style R fill:#fce4ec
```

---

## 🔧 **Core Components Deep Dive**

### **1. Terraform CLI**
The command-line interface that users interact with directly.

**Key Responsibilities:**
- Parse user commands and options
- Coordinate between core components
- Display output and error messages
- Handle user authentication

**Common Commands:**
```bash
terraform init      # Initialize working directory
terraform plan      # Create execution plan
terraform apply     # Apply changes
terraform destroy   # Destroy infrastructure
terraform show      # Show current state
terraform validate  # Validate configuration
```

### **2. Configuration Parser**
Reads and interprets Terraform configuration files written in HCL.

```mermaid
graph LR
    A[.tf files] --> B[Lexical Analysis]
    B --> C[Syntax Parsing]
    C --> D[Semantic Analysis]
    D --> E[Configuration Tree]
    
    style A fill:#e3f2fd
    style E fill:#e8f5e8
```

**What it processes:**
- Resource definitions
- Variable declarations
- Output specifications
- Provider configurations
- Module references

### **3. Resource Graph Builder**
Creates a dependency graph of all resources to determine execution order.

```mermaid
graph TB
    subgraph "Resource Dependencies"
        A[VPC] --> B[Subnet]
        B --> C[Security Group]
        C --> D[EC2 Instance]
        A --> E[Internet Gateway]
        E --> F[Route Table]
        F --> B
    end
    
    subgraph "Execution Order"
        G[1. VPC] --> H[2. Internet Gateway]
        H --> I[3. Route Table]
        I --> J[4. Subnet]
        J --> K[5. Security Group]
        K --> L[6. EC2 Instance]
    end
```

### **4. State Manager**
Tracks the current state of infrastructure and maps it to configuration.

**State File Contents:**
- Resource metadata
- Attribute values
- Dependencies
- Provider information
- Terraform version

### **5. Plan Engine**
Compares desired state (configuration) with current state to create execution plan.

```mermaid
graph LR
    A["Current State (terraform.tfstate)"] --> C[Plan Engine]
    B["Desired State (.tf files)"] --> C
    C --> D[Execution Plan]
    
    D --> E[Resources to Create]
    D --> F[Resources to Update]
    D --> G[Resources to Delete]
    
    style A fill:#ffebee
    style B fill:#e8f5e8
    style C fill:#fff3e0
    style D fill:#f3e5f5
```

### **6. Apply Engine**
Executes the plan by making API calls through providers.

**Execution Process:**
1. Validate execution plan
2. Acquire state lock (if remote state)
3. Execute changes in dependency order
4. Update state file
5. Release state lock

---

## 🔌 **Provider Ecosystem**

### **What are Providers?**
Providers are plugins that enable Terraform to interact with APIs of various services.

```mermaid
graph TB
    subgraph "Terraform Core"
        A[Terraform Engine]
    end
    
    subgraph "Official Providers"
        B["AWS Provider (hashicorp/aws)"]
        C["Azure Provider (hashicorp/azurerm)"]
        D["GCP Provider (hashicorp/google)"]
    end
    
    subgraph "Partner Providers"
        E["Kubernetes (hashicorp/kubernetes)"]
        F["Datadog (datadog/datadog)"]
        G["MongoDB (mongodb/mongodbatlas)"]
    end
    
    subgraph "Community Providers"
        H[Custom Provider 1]
        I[Custom Provider 2]
        J[Custom Provider 3]
    end
    
    A --> B
    A --> C
    A --> D
    A --> E
    A --> F
    A --> G
    A --> H
    A --> I
    A --> J
    
    style B fill:#ff9900
    style C fill:#0078d4
    style D fill:#4285f4
    style E fill:#326ce5
```

### **Provider Categories**

| Category | Examples | Use Cases |
|----------|----------|-----------|
| **Cloud Providers** | AWS, Azure, GCP | Infrastructure provisioning |
| **SaaS Providers** | Datadog, PagerDuty | Service configuration |
| **Network Providers** | Cloudflare, F5 | Network management |
| **Database Providers** | MongoDB, PostgreSQL | Database setup |
| **Monitoring Providers** | Grafana, New Relic | Observability |
| **Security Providers** | Vault, Auth0 | Security configuration |

### **Provider Configuration Example**
```hcl
# Configure the AWS Provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}
```

---

## 📊 **State Management Deep Dive**

### **What is Terraform State?**
State is Terraform's way of tracking which real-world resources correspond to your configuration.

```mermaid
graph TB
    subgraph "Configuration (.tf files)"
        A["resource aws_instance web {
          ami = ami-12345
          instance_type = t2.micro
        }"]
    end
    
    subgraph "State File (terraform.tfstate)"
        B["JSON state data with
        resource mappings and
        current infrastructure state"]
    end
    
    subgraph "Real Infrastructure"
        C["EC2 Instance
        ID: i-1234567890abcdef0
        AMI: ami-12345
        Type: t2.micro"]
    end
    
    A -.->|"Desired State"| B
    B -.->|"Current State"| C
    C -.->|"Actual Resources"| A
    
    style A fill:#e8f5e8
    style B fill:#fff3e0
    style C fill:#e3f2fd
```

### **State Storage Options**

```mermaid
graph TB
    subgraph "Local State"
        A["terraform.tfstate (Local File)"]
        A1[✅ Simple setup]
        A2[❌ No collaboration]
        A3[❌ No locking]
        A4[❌ Security risk]
    end
    
    subgraph "Remote State"
        B["S3 + DynamoDB (AWS Backend)"]
        B1[✅ Team collaboration]
        B2[✅ State locking]
        B3[✅ Encryption]
        B4[✅ Versioning]
        
        C["Terraform Cloud (SaaS Backend)"]
        C1[✅ Managed service]
        C2[✅ UI interface]
        C3[✅ Policy enforcement]
        C4[✅ Cost estimation]
    end
    
    style A fill:#ffebee
    style B fill:#e8f5e8
    style C fill:#e3f2fd
```

### **State File Structure**
```json
{
  "version": 4,
  "terraform_version": "1.5.0",
  "serial": 1,
  "lineage": "unique-id",
  "outputs": {},
  "resources": [
    {
      "mode": "managed",
      "type": "aws_instance",
      "name": "web",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 1,
          "attributes": {
            "id": "i-1234567890abcdef0",
            "ami": "ami-12345",
            "instance_type": "t2.micro"
          }
        }
      ]
    }
  ]
}
```

---

## 🔄 **Terraform Workflow**

### **Complete Workflow Visualization**

```mermaid
sequenceDiagram
    participant User
    participant CLI as Terraform CLI
    participant Core as Terraform Core
    participant Provider as AWS Provider
    participant AWS as AWS API
    participant State as State Backend
    
    Note over User,State: 1. INITIALIZATION PHASE
    User->>CLI: terraform init
    CLI->>Core: Initialize working directory
    Core->>Provider: Download required providers
    Provider-->>Core: Providers ready
    Core-->>CLI: Initialization complete
    CLI-->>User: Ready to use
    
    Note over User,State: 2. PLANNING PHASE
    User->>CLI: terraform plan
    CLI->>Core: Create execution plan
    Core->>State: Read current state
    State-->>Core: Current resource state
    Core->>Provider: Query existing resources
    Provider->>AWS: API calls to check resources
    AWS-->>Provider: Current resource details
    Provider-->>Core: Resource information
    Core-->>CLI: Execution plan created
    CLI-->>User: Display planned changes
    
    Note over User,State: 3. APPLY PHASE
    User->>CLI: terraform apply
    CLI->>Core: Execute planned changes
    Core->>State: Acquire state lock
    State-->>Core: Lock acquired
    Core->>Provider: Execute resource changes
    Provider->>AWS: Create/Update/Delete resources
    AWS-->>Provider: Operation results
    Provider-->>Core: Changes completed
    Core->>State: Update state with new information
    State-->>Core: State updated
    Core->>State: Release state lock
    State-->>Core: Lock released
    Core-->>CLI: Apply completed
    CLI-->>User: Infrastructure updated
```

### **Workflow Commands Deep Dive**

#### **1. terraform init**
```mermaid
graph LR
    A[terraform init] --> B[Download Providers]
    B --> C[Initialize Backend]
    C --> D[Download Modules]
    D --> E[Create .terraform/]
    E --> F[Ready to Plan]
    
    style A fill:#e3f2fd
    style F fill:#e8f5e8
```

**What happens:**
- Downloads required providers
- Initializes backend configuration
- Downloads referenced modules
- Creates `.terraform/` directory
- Prepares working directory

#### **2. terraform plan**
```mermaid
graph TB
    A[terraform plan] --> B[Read Configuration]
    B --> C[Read Current State]
    C --> D[Query Real Infrastructure]
    D --> E[Compare States]
    E --> F[Generate Plan]
    F --> G[Display Changes]
    
    G --> H[+ Resources to Create]
    G --> I[~ Resources to Update]
    G --> J[- Resources to Delete]
    
    style A fill:#fff3e0
    style H fill:#e8f5e8
    style I fill:#e3f2fd
    style J fill:#ffebee
```

**Plan Output Symbols:**
- `+` Create new resource
- `~` Update existing resource
- `-` Delete existing resource
- `+/-` Replace resource (delete then create)

#### **3. terraform apply**
```mermaid
graph LR
    A[terraform apply] --> B[Show Plan]
    B --> C[User Confirmation]
    C --> D[Execute Changes]
    D --> E[Update State]
    E --> F[Show Results]
    
    style A fill:#e8f5e8
    style C fill:#fff3e0
    style F fill:#e3f2fd
```

#### **4. terraform destroy**
```mermaid
graph LR
    A[terraform destroy] --> B[Create Destroy Plan]
    B --> C[Show Resources to Delete]
    C --> D[User Confirmation]
    D --> E[Delete Resources]
    E --> F[Update State]
    
    style A fill:#ffebee
    style E fill:#ffebee
```

---

## 🔍 **Resource Graph & Dependencies**

### **Dependency Resolution**

```mermaid
graph TB
    subgraph "Implicit Dependencies"
        A[aws_vpc.main] --> B[aws_subnet.public]
        B --> C[aws_instance.web]
        A --> D[aws_internet_gateway.gw]
        D --> E[aws_route_table.public]
        E --> B
    end
    
    subgraph "Explicit Dependencies"
        F[aws_instance.web] -.->|depends_on| G[aws_security_group.web]
        H[aws_eip.web] -.->|depends_on| F
    end
    
    style A fill:#e3f2fd
    style C fill:#e8f5e8
    style G fill:#fff3e0
```

### **Parallel Execution**
Terraform can create resources in parallel when there are no dependencies:

```mermaid
graph TB
    subgraph "Parallel Creation"
        A[VPC] --> B[Subnet 1]
        A --> C[Subnet 2]
        A --> D[Subnet 3]
        
        B --> E[Instance 1]
        C --> F[Instance 2]
        D --> G[Instance 3]
    end
    
    subgraph "Timeline"
        H[Time 0: VPC]
        I[Time 1: All Subnets in Parallel]
        J[Time 2: All Instances in Parallel]
    end
```

---

## 📁 **Configuration Structure**

### **Typical Project Layout**
```
terraform-project/
├── main.tf              # Primary configuration
├── variables.tf         # Input variables
├── outputs.tf          # Output values
├── terraform.tfvars    # Variable values
├── versions.tf         # Provider requirements
├── .terraform/         # Provider plugins (auto-generated)
├── terraform.tfstate   # State file (if local)
└── .terraform.lock.hcl # Dependency lock file
```

### **Configuration File Types**

| File | Purpose | Example Content |
|------|---------|-----------------|
| **main.tf** | Primary resources | `resource "aws_instance" "web" {...}` |
| **variables.tf** | Input definitions | `variable "instance_type" {...}` |
| **outputs.tf** | Output definitions | `output "instance_ip" {...}` |
| **terraform.tfvars** | Variable values | `instance_type = "t2.micro"` |
| **versions.tf** | Provider versions | `terraform { required_providers {...} }` |

---

## ✅ **Module 2 Checkpoint**

### **Knowledge Check**
Before moving to Module 3, ensure you understand:

- [ ] What are the core components of Terraform architecture?
- [ ] How does the Terraform workflow operate (init, plan, apply)?
- [ ] What is the role of providers in Terraform?
- [ ] How does Terraform state management work?
- [ ] What is the difference between local and remote state?
- [ ] How does Terraform handle resource dependencies?

### **Key Takeaways**
- 🏗️ **Terraform architecture** is modular with clear separation of concerns
- 🔄 **Workflow is predictable** with init → plan → apply → destroy cycle
- 🔌 **Providers enable** interaction with any API-driven service
- 📊 **State management** is critical for tracking infrastructure
- 🔗 **Dependency resolution** ensures correct resource creation order
- ⚡ **Parallel execution** optimizes deployment speed

---

<div align="center">

### 🚀 **Ready to Learn Essential Commands?**

**Next Module: [03 - Basic Commands](../03-basic-commands/README.md)**

*Master the Terraform CLI and essential workflows*

</div>

---

**Module Duration**: 8 minutes  
**Difficulty**: Beginner  
**Prerequisites**: Module 1 completed
