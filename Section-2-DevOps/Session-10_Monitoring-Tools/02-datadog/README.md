# 🐕 DataDog Integration Project

**Learn enterprise monitoring with DataDog integration**

---

## 🚀 Quick Start

```bash
# Build and start
docker-compose up --build

# View application
echo "Sample App: http://localhost:5000"
echo "Metrics: http://localhost:5000/metrics"
```

---

## 🎯 What You'll Learn

- DataDog agent setup
- Application instrumentation
- Custom metrics creation
- Enterprise monitoring patterns

---

## 📊 What's Included

- **Flask application** with DataDog instrumentation
- **Prometheus metrics** endpoint
- **DataDog agent** configuration
- **Custom metrics** examples

---

## 🛠️ Getting Started

### **Step 1: Start Application**
```bash
docker-compose up --build
```

### **Step 2: Generate Traffic**
```bash
# Make requests to generate metrics
curl http://localhost:5000/
curl http://localhost:5000/slow
curl http://localhost:5000/error
```

### **Step 3: View Metrics**
- Application: http://localhost:5000
- Prometheus metrics: http://localhost:5000/metrics

---

## 📈 Application Endpoints

| Endpoint | Purpose | Response Time |
|----------|---------|---------------|
| `/` | Normal response | ~100ms |
| `/slow` | Slow response | 1-3 seconds |
| `/error` | Error response | 500 status |
| `/metrics` | Prometheus metrics | - |

---

## 🔧 Files

- **app.py** - Flask application with instrumentation
- **Dockerfile** - Application container
- **requirements.txt** - Python dependencies
- **docker-compose.yml** - Service definition

---

## 📊 Metrics Generated

```python
# Request counter
http_requests_total

# Response time histogram
http_request_duration_seconds

# Custom business metrics
user_registrations_total
order_value_dollars
```

---

## 🧹 Cleanup

```bash
docker-compose down
```

---

*Great for learning enterprise monitoring patterns!* 🐕
