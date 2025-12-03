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
