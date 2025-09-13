FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    apache2 \
    build-essential \
    wget \
    unzip \
    openssl \
    libssl-dev \
    iputils-ping \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Create nagios user
RUN useradd -m -s /bin/bash nagios
RUN groupadd nagcmd
RUN usermod -a -G nagcmd nagios
RUN usermod -a -G nagcmd www-data

# Download and install Nagios Core
WORKDIR /tmp
RUN wget https://github.com/NagiosEnterprises/nagioscore/archive/nagios-4.4.6.tar.gz
RUN tar xzf nagios-4.4.6.tar.gz
WORKDIR /tmp/nagioscore-nagios-4.4.6
RUN ./configure --with-command-group=nagcmd
RUN make all
RUN make install
RUN make install-init
RUN make install-config
RUN make install-commandmode
RUN make install-webconf

# Download and install Nagios Plugins
WORKDIR /tmp
RUN wget https://github.com/nagios-plugins/nagios-plugins/archive/release-2.3.3.tar.gz
RUN tar xzf release-2.3.3.tar.gz
WORKDIR /tmp/nagios-plugins-release-2.3.3
RUN ./tools/setup
RUN ./configure
RUN make
RUN make install

# Set up web authentication
RUN htpasswd -cb /opt/nagios/etc/htpasswd.users admin nagios123

# Copy configuration files
COPY config/ /opt/nagios/etc/objects/

# Set permissions
RUN chown -R nagios:nagios /opt/nagios
RUN chmod -R 755 /opt/nagios

# Enable Apache modules
RUN a2enmod rewrite
RUN a2enmod cgi

# Start script
COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 80

CMD ["/start.sh"]
