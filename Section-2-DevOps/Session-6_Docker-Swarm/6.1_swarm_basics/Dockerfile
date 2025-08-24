# Use Apache HTTP Server (Alpine for smaller size)
FROM httpd:2.4-alpine

# Set working directory
WORKDIR /usr/local/apache2/htdocs/

# Copy HTML file to Apache document root
COPY index.html .

# Set proper permissions
RUN chmod 644 index.html

# Expose port 80
EXPOSE 80

# Add health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost/ || exit 1

# Start Apache in foreground
CMD ["httpd-foreground"]
