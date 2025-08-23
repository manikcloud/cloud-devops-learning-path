# Use Apache HTTP Server
FROM httpd:2.4-alpine

# Copy HTML file
COPY index.html /usr/local/apache2/htdocs/

# Create startup script to inject container info
RUN cat > /usr/local/bin/start.sh << 'EOF'
#!/bin/sh
# Get hostname (container ID)
HOSTNAME=$(hostname)
CONTAINER_ID=$(hostname | cut -c1-12)

# Replace placeholders in HTML
sed -i "s/CONTAINER_ID_PLACEHOLDER/$CONTAINER_ID/g" /usr/local/apache2/htdocs/index.html
sed -i "s/HOSTNAME_PLACEHOLDER/$HOSTNAME/g" /usr/local/apache2/htdocs/index.html

# Start Apache
httpd-foreground
EOF

# Make script executable
RUN chmod +x /usr/local/bin/start.sh

# Expose port 80
EXPOSE 80

# Start with custom script
CMD ["/usr/local/bin/start.sh"]
