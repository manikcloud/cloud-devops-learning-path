FROM httpd:2.4-alpine
COPY index.html /usr/local/apache2/htdocs/
RUN echo '#!/bin/sh' > /start.sh && \
    echo 'sed -i "s/CONTAINER_ID/$(hostname)/" /usr/local/apache2/htdocs/index.html' >> /start.sh && \
    echo 'httpd-foreground' >> /start.sh && \
    chmod +x /start.sh
CMD ["/start.sh"]
