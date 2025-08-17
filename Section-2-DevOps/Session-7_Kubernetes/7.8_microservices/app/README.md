# 📁 Application Code Directory

This directory contains the actual application code that gets deployed to Kubernetes.

## 🏗️ Structure

```
app/
├── frontend/           # Frontend web application
│   ├── index.html     # Main HTML page
│   ├── style.css      # CSS styling
│   ├── script.js      # JavaScript functionality
│   └── nginx.conf     # NGINX configuration
├── api/               # Backend API service
│   ├── server.js      # Node.js Express server
│   └── package.json   # Node.js dependencies
└── README.md          # This file
```

## 🌐 Frontend (app/frontend/)

**Technology**: HTML + CSS + JavaScript + NGINX

**Files**:
- `index.html` - Main web page with todo interface
- `style.css` - Beautiful styling with gradients and animations
- `script.js` - JavaScript for API calls and DOM manipulation
- `nginx.conf` - NGINX configuration for serving files and proxying API

**Features**:
- ✅ Responsive design (works on mobile)
- ✅ Real-time todo management
- ✅ Beautiful UI with animations
- ✅ Error handling and status messages
- ✅ API integration

## 🔧 API (app/api/)

**Technology**: Node.js + Express + PostgreSQL

**Files**:
- `server.js` - Express server with REST API endpoints
- `package.json` - Dependencies and scripts

**Endpoints**:
- `GET /health` - Health check
- `GET /todos` - Get all todos
- `POST /todos` - Add new todo
- `DELETE /todos/:id` - Delete todo

**Features**:
- ✅ RESTful API design
- ✅ PostgreSQL database integration
- ✅ CORS enabled for frontend
- ✅ Error handling
- ✅ Input validation

## 🚀 How It Works

1. **Frontend** serves the web interface via NGINX
2. **NGINX** proxies `/api/*` requests to the API service
3. **API** handles business logic and database operations
4. **Database** stores todo data persistently

## 🔄 Development Workflow

If you want to modify the application:

1. **Edit files** in this `app/` directory
2. **Update ConfigMaps** in the Kubernetes YAML files
3. **Redeploy** using `./deploy-todo-app.sh`

## 📚 Learning Value

This structure teaches:
- **Separation of concerns** - Frontend, API, and data layers
- **Microservices architecture** - Independent, communicating services
- **Container orchestration** - How Kubernetes manages the services
- **Real-world patterns** - Industry-standard application structure

## 🎯 For Students

You can:
- **Modify the CSS** to change the look and feel
- **Add new features** to the JavaScript
- **Extend the API** with new endpoints
- **Learn by doing** - see how changes affect the running app

This is **real application code** that demonstrates professional development practices!
