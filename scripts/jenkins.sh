#!/bin/bash
# ==========================================================
# Script Name: jenkins-install.sh
# Description: Install Jenkins on Ubuntu 22.04 with Temurin JDK 17
# Author: Moamen Nasser
# ==========================================================

set -e  # Exit if any command fails

echo "🔹 Updating system packages..."
sudo apt update -y

echo "🔹 Installing Temurin JDK 17..."
wget -O - https://packages.adoptium.net/artifactory/api/gpg/key/public | sudo tee /etc/apt/keyrings/adoptium.asc
echo "deb [signed-by=/etc/apt/keyrings/adoptium.asc] https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" | sudo tee /etc/apt/sources.list.d/adoptium.list
sudo apt update -y
sudo apt install temurin-17-jdk -y

echo "✅ Java installed successfully."
java --version

echo "🔹 Installing Jenkins..."
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update -y
sudo apt-get install jenkins -y

echo "🔹 Starting Jenkins service..."
sudo systemctl enable jenkins
sudo systemctl start jenkins
sudo systemctl status jenkins --no-pager

echo "✅ Jenkins installation completed successfully!"

