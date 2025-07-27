# GitLab CI/CD Pipeline Project - Dockerfile
# Multi-stage Docker build for production-ready Flask application

# ============================================================================
# BUILD STAGE
# ============================================================================
FROM python:3.9-slim as builder

# Set build arguments
ARG BUILD_DATE
ARG VERSION
ARG VCS_REF

# Set environment variables for build
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1

# Install build dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    make \
    && rm -rf /var/lib/apt/lists/*

# Create and set working directory
WORKDIR /build

# Copy requirements first for better caching
COPY requirements.txt .

# Install Python dependencies
RUN pip install --upgrade pip && \
    pip install --user --no-cache-dir -r requirements.txt

# ============================================================================
# PRODUCTION STAGE
# ============================================================================
FROM python:3.9-slim as production

# Set build arguments
ARG BUILD_DATE
ARG VERSION="1.0.0"
ARG VCS_REF

# Add metadata labels
LABEL maintainer="DevOps Team <devops@example.com>" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="GitLab CI/CD Demo App" \
      org.label-schema.description="Flask application for demonstrating GitLab CI/CD pipelines" \
      org.label-schema.version=$VERSION \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://gitlab.com/your-group/gitlab-cicd-demo" \
      org.label-schema.schema-version="1.0"

# Set production environment variables
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    FLASK_APP=app.py \
    FLASK_ENV=production \
    ENVIRONMENT=production \
    PORT=5000 \
    WORKERS=4

# Install runtime dependencies only
RUN apt-get update && apt-get install -y \
    curl \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# Create application directory
WORKDIR /app

# Copy Python dependencies from builder stage
COPY --from=builder /root/.local /root/.local

# Create non-root user for security
RUN groupadd -r appgroup && \
    useradd -r -g appgroup -d /app -s /bin/bash appuser && \
    chown -R appuser:appgroup /app

# Copy application files
COPY --chown=appuser:appgroup app.py .
COPY --chown=appuser:appgroup requirements.txt .

# Create necessary directories
RUN mkdir -p /app/logs /app/tmp && \
    chown -R appuser:appgroup /app/logs /app/tmp

# Switch to non-root user
USER appuser

# Add local Python packages to PATH
ENV PATH=/root/.local/bin:$PATH

# Expose application port
EXPOSE $PORT

# Health check configuration
HEALTHCHECK --interval=30s \
            --timeout=10s \
            --start-period=5s \
            --retries=3 \
    CMD curl -f http://localhost:$PORT/health || exit 1

# Create startup script
RUN echo '#!/bin/bash\n\
set -e\n\
\n\
echo "🚀 Starting GitLab CI/CD Demo Application"\n\
echo "Environment: $ENVIRONMENT"\n\
echo "Port: $PORT"\n\
echo "Workers: $WORKERS"\n\
echo "Python version: $(python --version)"\n\
echo "User: $(whoami)"\n\
echo "Working directory: $(pwd)"\n\
\n\
# Run database migrations if needed\n\
# python manage.py db upgrade\n\
\n\
# Start the application\n\
if [ "$ENVIRONMENT" = "development" ]; then\n\
    echo "Starting in development mode..."\n\
    python app.py\n\
else\n\
    echo "Starting in production mode with Gunicorn..."\n\
    exec gunicorn \\\n\
        --bind 0.0.0.0:$PORT \\\n\
        --workers $WORKERS \\\n\
        --worker-class sync \\\n\
        --worker-connections 1000 \\\n\
        --max-requests 1000 \\\n\
        --max-requests-jitter 100 \\\n\
        --timeout 30 \\\n\
        --keep-alive 2 \\\n\
        --log-level info \\\n\
        --access-logfile - \\\n\
        --error-logfile - \\\n\
        --capture-output \\\n\
        app:app\n\
fi' > /app/start.sh && chmod +x /app/start.sh

# Set the default command
CMD ["/app/start.sh"]

# ============================================================================
# DEVELOPMENT STAGE (for local development)
# ============================================================================
FROM production as development

# Switch back to root for development setup
USER root

# Install development dependencies
RUN apt-get update && apt-get install -y \
    vim \
    git \
    htop \
    && rm -rf /var/lib/apt/lists/*

# Install development Python packages
RUN pip install --no-cache-dir \
    pytest \
    pytest-cov \
    black \
    flake8 \
    isort \
    pylint \
    ipython \
    flask-debugtoolbar

# Set development environment
ENV FLASK_ENV=development \
    ENVIRONMENT=development \
    DEBUG=true

# Switch back to app user
USER appuser

# Override command for development
CMD ["python", "app.py"]

# ============================================================================
# TESTING STAGE (for CI/CD testing)
# ============================================================================
FROM development as testing

# Switch to root for test setup
USER root

# Install additional testing tools
RUN pip install --no-cache-dir \
    pytest-xdist \
    pytest-mock \
    coverage \
    bandit \
    safety

# Copy test files
COPY --chown=appuser:appgroup tests/ ./tests/

# Switch back to app user
USER appuser

# Set testing environment
ENV ENVIRONMENT=testing

# Default command for testing
CMD ["pytest", "tests/", "-v", "--cov=.", "--cov-report=html", "--cov-report=term"]

# ============================================================================
# BUILD INFORMATION
# ============================================================================

# Add build information file
RUN echo "{\n\
  \"build_date\": \"$BUILD_DATE\",\n\
  \"version\": \"$VERSION\",\n\
  \"vcs_ref\": \"$VCS_REF\",\n\
  \"python_version\": \"$(python --version)\",\n\
  \"base_image\": \"python:3.9-slim\"\n\
}" > /app/build-info.json

# ============================================================================
# SECURITY CONSIDERATIONS
# ============================================================================

# 1. Non-root user execution
# 2. Minimal base image (slim)
# 3. Multi-stage build to reduce image size
# 4. Health checks for monitoring
# 5. Proper file permissions
# 6. No sensitive data in layers
# 7. Explicit dependency versions
# 8. Security scanning ready

# ============================================================================
# USAGE EXAMPLES
# ============================================================================

# Build for production:
# docker build --target production -t gitlab-cicd-demo:latest .

# Build for development:
# docker build --target development -t gitlab-cicd-demo:dev .

# Build for testing:
# docker build --target testing -t gitlab-cicd-demo:test .

# Run production container:
# docker run -p 5000:5000 -e ENVIRONMENT=production gitlab-cicd-demo:latest

# Run development container:
# docker run -p 5000:5000 -v $(pwd):/app -e ENVIRONMENT=development gitlab-cicd-demo:dev

# Run tests:
# docker run --rm gitlab-cicd-demo:test
