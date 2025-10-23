#!/bin/bash
# ==========================================================
# Script Name: trivy-install.sh
# Description: Install Trivy vulnerability scanner
# Author: Moamen Nasser
# ==========================================================

set -e

echo "🔹 Installing dependencies..."
sudo apt-get install wget apt-transport-https gnupg lsb-release -y

echo "🔹 Adding Trivy repository..."
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | gpg --dearmor | sudo tee /usr/share/keyrings/trivy.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main" | sudo tee -a /etc/apt/sources.list.d/trivy.list

echo "🔹 Installing Trivy..."
sudo apt-get update
sudo apt-get install trivy -y

echo "✅ Trivy installation completed successfully!"

