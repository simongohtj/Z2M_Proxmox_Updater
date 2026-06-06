#!/bin/bash

# Ensure pipes return the correct exit status code
set -o pipefail

# Define variables for clean layout
TOKEN="YOUR_LONG_LIVED_ACCESS_TOKEN"
HA_URL="http://YOUR_HA_IP:8123/api/services/persistent_notification/create"
LOG_FILE="/var/log/z2m_update.log"

# Run the update command sequence
if yes | /usr/bin/update > "$LOG_FILE" 2>&1; then
    # Send Success Notification
    curl -X POST -H "Authorization: Bearer $TOKEN" \
         -H "Content-Type: application/json" \
         -d '{"title": "Zigbee2MQTT Status", "message": "Automatic update completed successfully via Proxmox script."}' \
         "$HA_URL"
else
    # Send Failure Notification
    curl -X POST -H "Authorization: Bearer $TOKEN" \
         -H "Content-Type: application/json" \
         -d '{"title": "⚠️ Zigbee2MQTT Error", "message": "Automatic update FAILED. Check /var/log/z2m_update.log"}' \
         "$HA_URL"
fi