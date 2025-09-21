# 📊 Logstash Configuration

## 📁 Structure
```
logstash/
├── config/
│   └── logstash.yml      # Main logstash settings
└── pipeline/
    └── logstash.conf     # Log processing pipeline
```

## ⚙️ Pipeline Configuration

### Input
- Reads log files from `/var/log/**/*.log`
- Monitors shared volumes from nginx/apache containers

### Filter
- **Nginx logs**: Parsed with NGINXACCESS pattern
- **Apache logs**: Parsed with COMBINEDAPACHELOG pattern
- **Response categorization**: success/redirect/client_error/server_error
- **Data type conversion**: response codes and bytes to integers

### Output
- **Elasticsearch**: Indexed as `web-logs-YYYY.MM.dd`
- **Stdout**: Debug output to console

## 🔍 Parsed Fields

| Field | Description | Example |
|-------|-------------|---------|
| `clientip` | Client IP address | 172.18.0.1 |
| `method` | HTTP method | GET, POST |
| `request` | Requested URL | /index.html |
| `response` | HTTP status code | 200, 404, 500 |
| `bytes` | Response size | 1234 |
| `log_source` | Source service | nginx, apache |
| `response_category` | Response type | success, client_error |

## 🚀 Testing

```bash
# Check logstash processing
docker logs logstash

# Verify parsed data in Elasticsearch
curl "http://localhost:9200/web-logs-*/_search?pretty&size=5"
```
