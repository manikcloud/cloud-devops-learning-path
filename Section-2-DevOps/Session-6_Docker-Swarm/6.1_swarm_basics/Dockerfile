# Use Apache HTTP Server
FROM httpd:2.4-alpine

# Copy HTML file
COPY index.html /usr/local/apache2/htdocs/

# Create a startup script that injects hostname
RUN echo '#!/bin/sh' > /usr/local/bin/start.sh && \
    echo 'HOSTNAME=$(hostname)' >> /usr/local/bin/start.sh && \
    echo 'sed -i "s/CONTAINER_HOSTNAME_PLACEHOLDER/$HOSTNAME/g" /usr/local/apache2/htdocs/index.html' >> /usr/local/bin/start.sh && \
    echo 'sed -i "s/Loading.../$HOSTNAME/g" /usr/local/apache2/htdocs/index.html' >> /usr/local/bin/start.sh && \
    echo 'httpd-foreground' >> /usr/local/bin/start.sh && \
    chmod +x /usr/local/bin/start.sh

# Expose port 80
EXPOSE 80

# Use custom startup script
CMD ["/usr/local/bin/start.sh"]
