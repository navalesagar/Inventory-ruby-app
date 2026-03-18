#!/bin/bash

set -e

echo "Installing Jenkins..."

# Update package manager
sudo apt update

# Install Java (Jenkins requires Java)
echo "Installing Java..."
sudo apt install -y openjdk-17-jdk

# Add Jenkins repository key
echo "Adding Jenkins repository..."
sudo wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -

# Add Jenkins repository
sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'

# Update package manager again
sudo apt update

# Install Jenkins
echo "Installing Jenkins package..."
sudo apt install -y jenkins

# Start Jenkins service
echo "Starting Jenkins..."
sudo systemctl start jenkins
sudo systemctl enable jenkins

# Print Jenkins status
echo "Jenkins installation complete!"
sudo systemctl status jenkins

# Display access information
echo ""
echo "Jenkins is running on http://localhost:8080"
echo "To get the initial admin password, run:"
echo "sudo cat /var/lib/jenkins/secrets/initialAdminPassword"


# sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
#   https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key
# echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc]" \
#   https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
#   /etc/apt/sources.list.d/jenkins.list > /dev/null
# sudo apt update
# sudo apt install jenkins
