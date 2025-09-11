# 📊 ELK Stack Project - Complete Monitoring Solution

<div align="center">

![ELK](https://img.shields.io/badge/ELK-Stack-005571?style=for-the-badge&logo=elastic&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-Compose-2496ED?style=for-the-badge&logo=docker&logoColor=white)

**🎯 Elasticsearch + Logstash + Kibana | 📈 Log Analysis | 🔍 Real-time Monitoring**

</div>

---

## 🎯 **Project Overview**

Set up a complete ELK (Elasticsearch, Logstash, Kibana) stack using Docker Compose for log monitoring and analysis.

### **What You'll Build**
- Elasticsearch cluster for data storage
- Logstash for log processing
- Kibana dashboard for visualization
- Spring Boot app with log monitoring

---

## 🚀 **Quick Setup**

### **Prerequisites**
```bash
# Install Docker and Docker Compose
sudo apt update
sudo apt install docker.io docker-compose -y
sudo usermod -aG docker $USER
```

### **Step 1: Clone and Setup**
```bash
# Clone the project
git clone https://github.com/manikcloud/elk-stack.git
cd elk-stack

# Configure Elasticsearch
sudo sysctl -w vm.max_map_count=262144
```

### **Step 2: Start ELK Stack**
```bash
# Start all services
docker-compose up -d

# Verify services are running
docker ps
```

### **Step 3: Access Dashboards**
- **Kibana**: http://localhost:5601
- **Elasticsearch**: http://localhost:9200
- **Spring Boot App**: http://localhost:81

---

## 📋 **Docker Compose Configuration**

```yaml
version: '2'
services:
  elasticsearch:
    image: docker.elastic.co/elasticsearch/elasticsearch:7.17.0
    ports:
      - '9200:9200'
      - '9300:9300'
    environment:
      - discovery.type=single-node
      - "ES_JAVA_OPTS=-Xms512m -Xmx512m"
    
  kibana:
    image: docker.elastic.co/kibana/kibana:7.17.0
    ports:
      - '5601:5601'
    depends_on:
      - elasticsearch
    environment:
      - ELASTICSEARCH_HOSTS=http://elasticsearch:9200
    
  logstash:
    image: docker.elastic.co/logstash/logstash:7.17.0
    ports:
      - '25826:25826'
    volumes:
      - ./conf.d/:/usr/share/logstash/pipeline/
    depends_on:
      - elasticsearch
```

---

## 🔧 **Logstash Configuration**

Create `conf.d/logstash.conf`:
```ruby
input {
  file {
    path => "/var/log/*.log"
    start_position => "beginning"
  }
}

filter {
  if [path] =~ "access" {
    mutate { replace => { "type" => "apache_access" } }
    grok {
      match => { "message" => "%{COMBINEDAPACHELOG}" }
    }
  }
}

output {
  elasticsearch {
    hosts => ["elasticsearch:9200"]
    index => "logs-%{+YYYY.MM.dd}"
  }
  stdout { codec => rubydebug }
}
```

---

## 📊 **Kibana Setup**

### **Create Index Pattern**
1. Open Kibana: http://localhost:5601
2. Go to **Management** → **Index Patterns**
3. Create pattern: `logs-*`
4. Select timestamp field: `@timestamp`

### **Build Dashboard**
1. Go to **Discover** to explore logs
2. Create visualizations in **Visualize**
3. Build dashboard in **Dashboard**

---

## 🧪 **Testing the Setup**

### **Generate Test Logs**
```bash
# Generate sample logs
for i in {1..100}; do
  echo "$(date) INFO: Test log entry $i" >> /var/log/test.log
done

# Check logs in Kibana
curl -X GET "localhost:9200/logs-*/_search?pretty"
```

### **Spring Boot Integration**
```yaml
# Add to application.yml
logging:
  file:
    name: /var/log/springboot.log
  pattern:
    file: "%d{yyyy-MM-dd HH:mm:ss} [%thread] %-5level %logger{36} - %msg%n"
```

---

## 🔍 **Common Kibana Queries**

### **Search for Errors**
```
level:ERROR
```

### **Time Range Filter**
```
@timestamp:[now-1h TO now]
```

### **Application Logs**
```
source:"/var/log/springboot.log" AND level:INFO
```

---

## 🛠️ **Troubleshooting**

### **Elasticsearch Won't Start**
```bash
# Increase virtual memory
sudo sysctl -w vm.max_map_count=262144
echo 'vm.max_map_count=262144' | sudo tee -a /etc/sysctl.conf
```

### **Check Service Health**
```bash
# Elasticsearch health
curl http://localhost:9200/_health

# View logs
docker-compose logs elasticsearch
docker-compose logs kibana
docker-compose logs logstash
```

### **Reset Everything**
```bash
# Stop and remove all containers
docker-compose down -v

# Remove all data
docker system prune -a

# Start fresh
docker-compose up -d
```

---

## 🎯 **Project Deliverables**

### **What to Submit**
1. ✅ Working ELK stack with Docker Compose
2. ✅ Custom Kibana dashboard
3. ✅ Log analysis queries
4. ✅ Documentation of setup process
5. ✅ Screenshots of working dashboards

### **Bonus Points**
- Custom log parsing rules
- Alerting configuration
- Performance optimization
- Security hardening

---

## 📚 **Resources**

- [Elasticsearch Guide](https://www.elastic.co/guide/en/elasticsearch/reference/current/index.html)
- [Logstash Configuration](https://www.elastic.co/guide/en/logstash/current/configuration.html)
- [Kibana User Guide](https://www.elastic.co/guide/en/kibana/current/index.html)
- [Docker Compose Reference](https://docs.docker.com/compose/)

---

*Ready to analyze logs like a pro? Let's build the ELK stack!* 📊
