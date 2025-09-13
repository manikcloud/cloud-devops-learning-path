#!/bin/bash

# Start Apache
service apache2 start

# Start Nagios
/opt/nagios/bin/nagios -d /opt/nagios/etc/nagios.cfg

# Keep container running
tail -f /opt/nagios/var/nagios.log
