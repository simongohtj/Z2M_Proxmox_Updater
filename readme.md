# Proxmox Zigbee2MQTT Unattended Auto-Updater

A lightweight automation script designed to run inside a **Zigbee2MQTT Virtual Machine (VM)** created via the popular Proxmox VE Helper Scripts. 

This script automates the weekly application update process headlessly, overrides interactive CLI prompts, logs output details, and pushes real-time status alerts directly to your **Home Assistant** notification panel.

---

## Installation & Setup

### 1. Prerequisites
- A Zigbee2MQTT environment deployed as a VM using the Proxmox VE Helper Scripts framework.
- A **Long-Lived Access Token** generated from your Home Assistant profile page.
- The local IP address and port (default: `8123`) of your Home Assistant server.

### 2. Add the Script
Clone or download `z2m_autoupdate.sh` into your VM. We recommend moving it into your system binaries folder:

```bash
sudo mv z2m_autoupdate.sh /usr/local/bin/z2m_autoupdate.sh
```

### 3. Configure Variables
Open the script and populate your Home Assistant parameters:
```bash
sudo nano /usr/local/bin/z2m_autoupdate.sh
```
Update these specific lines:
```bash
TOKEN="YOUR_LONG_LIVED_ACCESS_TOKEN"
HA_URL="http://YOUR_HOME_ASSISTANT_IP:8123/api/services/persistent_notification/create"
```

### 4. Set Execution Permissions
Authorize the system daemon to run the script files:
```bash
sudo chmod +x /usr/local/bin/z2m_autoupdate.sh
```

---

## Scheduling Automation (Cron)

To automatically run this script every **Sunday at 3:00 AM**, add it to your system crontab scheduler.

1. Open the crontab configuration editor:
   ```bash
   crontab -e
   ```
2. Append the following entry to the absolute bottom of the file:
   ```text
   0 3 * * 0 /usr/local/bin/z2m_autoupdate.sh
   ```
3. Save and close the editor.

---

## Manual Testing & Diagnostics

You can verify execution paths manually at any time by running the script file directly from your VM terminal prompt:
```bash
/usr/local/bin/z2m_autoupdate.sh
```
*Note: The script runs silently because terminal prints are redirected to log layouts. To stream progress logs live during manual tests, run:*
```bash
/usr/local/bin/z2m_autoupdate.sh & tail -f /var/log/z2m_update.log
```
