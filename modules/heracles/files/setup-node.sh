#!/usr/bin/env bash

# This script template is expected to be populated during the setup of a
# Heracles  node. It runs on host startup.

# Log everything we do.
set -x
exec > /var/log/user-data.log 2>&1

mkdir -p /etc/aws/
cat > /etc/aws/aws.conf <<- EOF
[Global]
Zone = ${availability_zone}
EOF

# Create initial logs config.
cat > ./awslogs.conf <<- EOF
[general]
state_file = /var/awslogs/state/agent-state

[/var/log/messages]
log_stream_name = openshift-node-{instance_id}
log_group_name = /var/log/messages
file = /var/log/messages
datetime_format = %b %d %H:%M:%S
buffer_duration = 5000
initial_position = start_of_file

[/var/log/user-data.log]
log_stream_name = openshift-node-{instance_id}
log_group_name = /var/log/user-data.log
file = /var/log/user-data.log
EOF

# Download and run the AWS logs agent.
curl https://s3.amazonaws.com/aws-cloudwatch/downloads/latest/awslogs-agent-setup.py -O
python ./awslogs-agent-setup.py --non-interactive --region us-east-1 -c ./awslogs.conf

# Start the awslogs service, also start on reboot.
# Note: Errors go to /var/log/awslogs.log
service awslogs start
chkconfig awslogs on

# Install Docker
yum update -y
yum install -y docker
service docker start
usermod -a -G docker ec2-user
chkconfig docker on

# Install Docker Compose
curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Install MID Server
useradd -c "midserver" midserver -U -m -s /bin/bash
usermod -aG wheel midserver
URL="https://install.service-now.com/glide/distribution/builds/package/app-signed/mid-linux-installer/2021/06/07/mid-linux-installer.quebec-12-09-2020__patch4-hotfix1-06-03-2021_06-07-2021_1407.linux.x86-64.rpm"
wget --progress=bar:force --no-check-certificate ${URL} -O mid.rpm
rpm -ivh --nodeps mid.rpm
chown -R midserver:midserver /opt/servicenow
chmod -R 775 /opt/servicenow/mid/agent/*.sh

# Allow the ec2-user to sudo without a tty, which is required when we run post
# install scripts on the server.
echo Defaults:ec2-user \!requiretty >> /etc/sudoers
