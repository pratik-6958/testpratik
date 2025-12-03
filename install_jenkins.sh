#!/bin/bash

# Exit on any error
set -e

echo "----------------------------------------"
echo " Updating system packages"
echo "----------------------------------------"
sudo apt update -y
sudo apt upgrade -y

echo "----------------------------------------"
echo " Installing Java (JDK 17)"
echo "----------------------------------------"
sudo apt install -y openjdk-17-jdk

echo "----------------------------------------"
echo " Adding Jenkins repository and GPG key"
echo "----------------------------------------"
curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee \
    /usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
    https://pkg.jenkins.io/debian binary/ | sudo tee \
    /etc/apt/sources.list.d/jenkins.list > /dev/null

echo "----------------------------------------"
echo " Updating package list"
echo "----------------------------------------"
sudo apt update -y

echo "----------------------------------------"
echo " Installing Jenkins"
echo "----------------------------------------"
sudo apt install -y jenkins

echo "----------------------------------------"
echo " Starting and enabling Jenkins service"
echo "----------------------------------------"
sudo systemctl start jenkins
sudo systemctl enable jenkins

echo "----------------------------------------"
echo " Installation Completed!"
echo "----------------------------------------"
echo "Jenkins is running on:  http://<your-server-ip>:8080"
echo "To get initial admin password, run:"
echo "  sudo cat /var/lib/jenkins/secrets/initialAdminPassword"

#!/bin/bash

# Exit on error
set -e

echo "----------------------------------------"
echo " Updating system"
echo "----------------------------------------"
sudo apt update -y
sudo apt upgrade -y

echo "----------------------------------------"
echo " Installing required packages"
echo "----------------------------------------"
sudo apt install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

echo "----------------------------------------"
echo " Adding Docker’s official GPG key"
echo "----------------------------------------"
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo "----------------------------------------"
echo " Setting up the Docker repository"
echo "----------------------------------------"
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "----------------------------------------"
echo " Updating package index"
echo "----------------------------------------"
sudo apt update -y

echo "----------------------------------------"
echo " Installing Docker Engine + Compose"
echo "----------------------------------------"
sudo apt install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-buildx-plugin \
    docker-compose-plugin

echo "----------------------------------------"
echo " Adding current user to docker group"
echo "----------------------------------------"
sudo usermod -aG docker $USER

echo "----------------------------------------"
echo " Enabling and starting Docker service"
echo "----------------------------------------"
sudo systemctl enable docker
sudo systemctl start docker

echo "----------------------------------------"
echo " Docker Installation Completed!"
echo "----------------------------------------"
echo "Verify by running: docker --version"
echo "Logout or reboot required for group changes to take effect."
