#!/bin/bash
# ==========================================================
# Script Name: grafana-install.sh
# Description: Install Grafana OSS and integrate with Prometheus
# Author: Moamen Nasser
# ==========================================================

set -e

echo "🔹 Installing dependencies..."
sudo apt-get install -y apt-transport-https software-properties-common wget

echo "🔹 Adding Grafana repository..."
wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -
echo "deb https://packages.grafana.com/oss/deb stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list

echo "🔹 Installing Grafana..."
sudo apt-get update
sudo apt-get install grafana -y

sudo systemctl enable grafana-server
sudo systemctl start grafana-server

echo "✅ Grafana is running at: http://<server-ip>:3000 (user: admin / pass: admin)"

