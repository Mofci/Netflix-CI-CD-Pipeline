#!/bin/bash
# ==========================================================
# Script Name: sonar-container-setup.sh
# Description: Run SonarQube container using Docker
# Author: Moamen Nasser
# ==========================================================

set -e

echo "🔹 Installing Docker if not already installed..."
sudo apt-get update
sudo apt-get install -y docker.io
sudo usermod -aG docker $USER
sudo chmod 777 /var/run/docker.sock

echo "🔹 Running SonarQube container..."
docker run -d --name sonar -p 9000:9000 sonarqube:lts-community

echo "✅ SonarQube is now running at: http://<server-ip>:9000 (username: admin / password: admin)"

