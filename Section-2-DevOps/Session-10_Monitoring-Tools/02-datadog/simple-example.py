#!/usr/bin/env python3
"""
Simple DataDog Example for Students
A basic Flask app that sends metrics to DataDog
"""

from flask import Flask
from datadog import initialize, statsd
import time
import random

# Initialize Flask app
app = Flask(__name__)

# Initialize DataDog (use environment variables in production)
initialize(
    api_key='demo-key-12345',  # Replace with your DataDog API key
    app_key='demo-app-67890'   # Replace with your DataDog App key
)

@app.route('/')
def home():
    """Simple home page that tracks visits"""
    
    # Count page visits
    statsd.increment('app.page.visits', tags=['page:home'])
    
    # Track response time
    start_time = time.time()
    
    # Simulate some work
    time.sleep(random.uniform(0.1, 0.3))
    
    # Send response time metric
    response_time = time.time() - start_time
    statsd.histogram('app.response.time', response_time, tags=['endpoint:home'])
    
    return """
    <h1>Simple DataDog Demo</h1>
    <p>Visit count and response time sent to DataDog!</p>
    <p><a href="/slow">Try slow endpoint</a></p>
    <p><a href="/error">Try error endpoint</a></p>
    """

@app.route('/slow')
def slow_endpoint():
    """Slow endpoint to demonstrate performance monitoring"""
    
    # Track slow requests
    statsd.increment('app.page.visits', tags=['page:slow'])
    
    start_time = time.time()
    
    # Simulate slow operation
    time.sleep(random.uniform(1.0, 3.0))
    
    response_time = time.time() - start_time
    statsd.histogram('app.response.time', response_time, tags=['endpoint:slow'])
    
    return "<h1>Slow Response</h1><p>This took a while!</p>"

@app.route('/error')
def error_endpoint():
    """Error endpoint to demonstrate error tracking"""
    
    # Track error requests
    statsd.increment('app.errors.total', tags=['type:demo_error'])
    
    return "<h1>Error!</h1><p>Something went wrong!</p>", 500

@app.route('/metrics')
def custom_metrics():
    """Send some custom business metrics"""
    
    # Simulate business metrics
    user_count = random.randint(100, 500)
    revenue = random.uniform(1000, 5000)
    
    # Send custom metrics
    statsd.gauge('app.users.active', user_count)
    statsd.histogram('app.revenue.daily', revenue, tags=['currency:usd'])
    
    return f"""
    <h1>Custom Metrics Sent!</h1>
    <p>Active Users: {user_count}</p>
    <p>Daily Revenue: ${revenue:.2f}</p>
    """

if __name__ == '__main__':
    print("🐕 Starting Simple DataDog Demo App")
    print("📊 Metrics will be sent to DataDog")
    print("🌐 Open http://localhost:5001 to test")
    
    app.run(host='0.0.0.0', port=5001, debug=True)
