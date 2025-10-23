#!/bin/bash
# ==========================================================
# Script Name: node-exporter-install.sh
# Description: Install and run Node Exporter for Prometheus
# Author: Moamen Nasser
# ==========================================================

set -e

NODE_VERSION="1.6.1"

echo "🔹 Creating system user..."
sudo useradd --system --no-create-home --shell /bin/false node_exporter

echo "🔹 Downloading Node Exporter..."
wget https://github.com/prometheus/node_exporter/releases/download/v${NODE_VERSION}/node_exporter-${NODE_VERSION}.linux-amd64.tar.gz
tar -xvf node_exporter-${NODE_VERSION}.linux-amd64.tar.gz
sudo mv node_exporter-${NODE_VERSION}.linux-amd64/node_exporter /usr/local/bin/

echo "🔹 Creating systemd service..."
cat <<EOF | sudo tee /etc/systemd/system/node_exporter.service
[Unit]
Description=Node Exporter
After=network-online.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable node_exporter
sudo systemctl start node_exporter

echo "✅ Node Exporter is running at: http://<server-ip>:9100"

