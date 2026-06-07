#!/bin/bash
set -e

# Update package lists
apt-get update -y

# Install Java 11 runtime, Ruby, wget, and curl for CodeDeploy agent installation
apt-get install -y openjdk-11-jre-headless ruby wget curl

# Create application directory and set ownership
mkdir -p /home/ubuntu/student
chown -R ubuntu:ubuntu /home/ubuntu/student

# Install the AWS CodeDeploy agent if not already installed
REGION=$(curl -s http://169.254.169.254/latest/dynamic/instance-identity/document | grep region | awk -F'"' '{print $4}')
CODEDEPLOY_INSTALL_URL="https://aws-codedeploy-${REGION}.s3.${REGION}.amazonaws.com/latest/install"

cd /home/ubuntu
if [ ! -f /etc/systemd/system/codedeploy-agent.service ] && [ ! -f /etc/init.d/codedeploy-agent ]; then
  wget "$CODEDEPLOY_INSTALL_URL" -O install_codedeploy_agent.sh
  chmod +x install_codedeploy_agent.sh
  ./install_codedeploy_agent.sh auto
fi

systemctl enable codedeploy-agent
systemctl start codedeploy-agent

# Verify installation
java -version
systemctl status codedeploy-agent --no-pager || true

echo "Ubuntu EC2 setup completed: Java 11 and CodeDeploy agent installed."
