#!/usr/bin/env bash

# This script template is expected to be populated during the setup of a
# Heracles control. It runs on host startup.

# Log everything we do.
set -x
exec > /var/log/user-data.log 2>&1

# Allow the ec2-user to sudo without a tty, which is required when we run post
# install scripts on the server.
echo Defaults:ec2-user \!requiretty >> /etc/sudoers

# Setup AZ
mkdir -p /etc/aws/
cat > /etc/aws/aws.conf <<- EOF
[Global]
Zone = ${availability_zone}
EOF

# Update Repos
yum update -y

# Install Cloudwatch
yum install -y awslogs

# Configure Cloudwatch
mkdir -p /var/awslogs/state

cat > /etc/awslogs/awslogs.conf <<- EOF
[general]
state_file = /var/awslogs/state/agent-state
use_gzip_http_content_encoding = true

[/var/log/messages]
log_stream_name = ${log_stream_name}
log_group_name = /var/log/messages
file = /var/log/messages
datetime_format = %b %d %H:%M:%S
buffer_duration = 5000
initial_position = start_of_file

[/var/log/user-data.log]
log_stream_name = ${log_stream_name}
log_group_name = /var/log/user-data.log
file = /var/log/user-data.log
EOF

cat > /etc/awslogs/awscli.conf <<- EOF
[plugins]
cwlogs = cwlogs
[default]
region = ${region}
EOF

# Start the awslogsd service, also start on reboot.
# NOTE: Errors go to /var/log/awslogs.log
systemctl enable awslogsd.service
systemctl start awslogsd

# Configure Prompt
sudo cat > /etc/bashrc <<- EOF
# Configure Prompt
PS1="[control][\u@\h \W]\\$ "
EOF