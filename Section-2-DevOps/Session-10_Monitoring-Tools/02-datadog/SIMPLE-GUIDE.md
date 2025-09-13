# 🐕 DataDog Simple Example for Students

## 🎯 **What You'll Learn**
- Send **custom metrics** to DataDog
- Track **application performance** (response times, errors)
- Monitor **business metrics** (users, revenue)
- Compare DataDog with Prometheus/Grafana

---

## 🚀 **Quick Start (5 Minutes)**

### **Step 1: Start the Demo App**
```bash
# Build and start the application
docker-compose up --build -d

# Check if it's running
docker-compose ps
```

### **Step 2: Test the Application**
```bash
# Visit the home page (sends metrics)
curl http://localhost:5001/

# Try the slow endpoint
curl http://localhost:5001/slow

# Try the error endpoint  
curl http://localhost:5001/error

# Send custom business metrics
curl http://localhost:5001/metrics
```

### **Step 3: View in Browser**
- **Demo App**: http://localhost:5001
- **Prometheus**: http://localhost:9091 (compare with DataDog)
- **Grafana**: http://localhost:3001 (admin/admin123)

---

## 📊 **What Metrics Are Sent**

### **Application Metrics**
```python
# Page visits counter
statsd.increment('app.page.visits', tags=['page:home'])

# Response time tracking
statsd.histogram('app.response.time', response_time, tags=['endpoint:home'])

# Error counting
statsd.increment('app.errors.total', tags=['type:demo_error'])
```

### **Business Metrics**
```python
# Active users (gauge - current value)
statsd.gauge('app.users.active', user_count)

# Daily revenue (histogram - distribution)
statsd.histogram('app.revenue.daily', revenue, tags=['currency:usd'])
```

---

## 🔧 **Code Walkthrough**

### **Simple Flask App Structure**
```python
from flask import Flask
from datadog import initialize, statsd

# Initialize DataDog
initialize(api_key='your-key', app_key='your-app-key')

@app.route('/')
def home():
    # Count visits
    statsd.increment('app.page.visits')
    
    # Track response time
    start_time = time.time()
    # ... do work ...
    response_time = time.time() - start_time
    statsd.histogram('app.response.time', response_time)
    
    return "Hello World!"
```

### **Key DataDog Concepts**
- **increment()** - Count events (page visits, errors)
- **histogram()** - Track distributions (response times, revenue)
- **gauge()** - Current values (active users, CPU usage)
- **tags** - Add context to metrics (page:home, currency:usd)

---

## 📈 **What You'll See in DataDog**

### **Metrics Dashboard**
- `app.page.visits` - How many times each page was visited
- `app.response.time` - How fast your app responds
- `app.errors.total` - How many errors occurred
- `app.users.active` - Current number of active users
- `app.revenue.daily` - Revenue distribution

### **Tags for Filtering**
- Filter by `page:home` vs `page:slow`
- Filter by `endpoint:home` vs `endpoint:slow`
- Filter by `currency:usd` for revenue metrics

---

## 🎓 **Learning Exercises**

### **Exercise 1: Add New Metrics**
Add a new endpoint that tracks:
```python
@app.route('/signup')
def signup():
    # Track new user signups
    statsd.increment('app.signups.total', tags=['source:web'])
    return "Welcome new user!"
```

### **Exercise 2: Add Custom Tags**
Modify existing metrics to include more context:
```python
# Add user type and region tags
statsd.increment('app.page.visits', 
                tags=['page:home', 'user_type:premium', 'region:us-east'])
```

### **Exercise 3: Business Metrics**
Add metrics that matter to business:
```python
# Track feature usage
statsd.increment('app.feature.used', tags=['feature:checkout'])

# Track conversion rates
statsd.histogram('app.conversion.rate', conversion_percentage)
```

---

## 🔍 **Compare with Other Tools**

### **DataDog vs Prometheus**
| Feature | DataDog | Prometheus |
|---------|---------|------------|
| **Setup** | Cloud service | Self-hosted |
| **Cost** | Paid service | Free |
| **Features** | Full APM suite | Metrics only |
| **Ease of Use** | Very easy | More complex |

### **When to Use DataDog**
- ✅ **Enterprise environments** with budget
- ✅ **Complex applications** needing APM
- ✅ **Teams wanting** managed service
- ✅ **Advanced features** like AI anomaly detection

### **When to Use Prometheus**
- ✅ **Cost-conscious** projects
- ✅ **Simple monitoring** needs
- ✅ **Self-hosted** environments
- ✅ **Open source** preference

---

## 🧹 **Cleanup**
```bash
# Stop all services
docker-compose down

# Remove images (optional)
docker-compose down --rmi all
```

---

## 🎯 **Key Takeaways**

1. **DataDog is simple** - Just add a few lines of code
2. **Metrics tell stories** - Track what matters to your business
3. **Tags add context** - Filter and group your data
4. **Real-time insights** - See your app's health immediately
5. **Enterprise ready** - Scales from startup to Fortune 500

---

*Start simple, think big. Every metric tells a story about your application.* 🐕
