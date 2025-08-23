# Use Apache HTTP Server
FROM httpd:2.4-alpine

# Copy HTML file
COPY index.html /usr/local/apache2/htdocs/

# Create startup script to inject container info
RUN echo '#!/bin/sh' > /usr/local/bin/start.sh && \
    echo 'HOSTNAME=$(hostname)' >> /usr/local/bin/start.sh && \
    echo 'CONTAINER_ID=$(hostname | cut -c1-12)' >> /usr/local/bin/start.sh && \
    echo 'sed -i "s/CONTAINER_ID_PLACEHOLDER/$CONTAINER_ID/g" /usr/local/apache2/htdocs/index.html' >> /usr/local/bin/start.sh && \
    echo 'sed -i "s/HOSTNAME_PLACEHOLDER/$HOSTNAME/g" /usr/local/apache2/htdocs/index.html' >> /usr/local/bin/start.sh && \
    echo 'httpd-foreground' >> /usr/local/bin/start.sh && \
    chmod +x /usr/local/bin/start.sh

# Expose port 80
EXPOSE 80

# Start with custom script
CMD ["/usr/local/bin/start.sh"]
