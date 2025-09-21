FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# Install only essential packages
RUN apt-get update && apt-get install -y \
    nagios4 \
    nagios-plugins-basic \
    apache2 \
    iputils-ping \
    && rm -rf /var/lib/apt/lists/*

# Enable required Apache modules
RUN a2enmod auth_digest cgi

# Set web password
RUN htpasswd -cb /etc/nagios4/htpasswd.users admin nagios123

# Copy simple config
COPY config/ /etc/nagios4/conf.d/

EXPOSE 80

CMD service apache2 start && nagios4 -d /etc/nagios4/nagios.cfg && tail -f /var/log/nagios4/nagios.log
