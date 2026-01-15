# Raspberry Pi 5 Configuration

Automated configuration setup for Raspberry Pi 5 with secrets management.

## Prerequisites
- Raspberry Pi 5
- microSD card (32GB+ recommended)
- Computer with Raspberry Pi Imager
- WiFi credentials

## Quick Setup

### 1. Configure Secrets

Create and edit `secrets.env` with your actual credentials:

```bash
nano secrets.env
```

Add your values:
```bash
USER_PASSWORD=your_secure_password
WIFI_SSID=your_wifi_name
WIFI_PASSWORD=your_wifi_password
SSH_PUBLIC_KEY="ssh-ed25519 YOUR_KEY_HERE"  # optional
```

**Note**: `secrets.env` is gitignored and won't be committed.

### 2. Generate Configuration (Automated)

Use the provided script to automatically generate your config:

```bash
./generate-config.sh
```

This script:
- Reads your secrets from `secrets.env`
- Replaces placeholders in `pi5main-config.json`
- Creates `pi5main-config.local.json` (gitignored)

### 3. Flash with Raspberry Pi Imager

**Recommended Method:**
1. Open Raspberry Pi Imager
2. Press `Cmd+Shift+X` (Mac) or `Ctrl+Shift+X` (Windows/Linux)
3. Click "LOAD FROM FILE"
4. Select `pi5main-config.local.json`
5. Flash to SD card

**Alternative (manual):**
- Load `pi5main-config.json` in imager
- Manually update credentials in the interface

### 4. Boot & Connect

```bash
# Wait ~2 minutes after powering on
ssh rege@pi5main.local

# Install Docker and essentials
curl -fsSL https://get.docker.com | sudo sh
sudo usermod -aG docker rege
sudo apt-get install -y docker-compose-plugin ufw fail2ban htop

# Configure firewall
sudo ufw allow 22 && sudo ufw allow 80 && sudo ufw allow 443
sudo ufw --force enable

# Logout and login for docker group
exit
ssh rege@pi5main.local

# Verify
docker --version
```

## Pre-configured Settings

✅ **Hostname**: pi5main  
✅ **Username**: rege  
✅ **SSH**: Enabled with public key authentication  
✅ **WiFi**: Auto-connect on first boot  
✅ **Timezone**: Europe/Warsaw  
✅ **Keyboard**: US layout  

## Files

- `pi5main-config.json` - Template configuration (safe to commit)
- `secrets.env` - Your local secrets (gitignored)
- `generate-config.sh` - Script to generate config from secrets
- `pi5main-config.local.json` - Generated config (gitignored, auto-created)
- `.gitignore` - Protects secrets and generated files
- `README.md` - This file

## Workflow Summary

```bash
# 1. Edit your secrets
nano secrets.env

# 2. Generate config
./generate-config.sh

# 3. Use in Raspberry Pi Imager
# Load: pi5main-config.local.json
```

## SSH Key Setup

To use your own SSH key:

```bash
# Get your SSH public key
cat ~/.ssh/id_ed25519.pub

# Add it to secrets.env
nano secrets.env
# Update the SSH_PUBLIC_KEY line

# Regenerate config
./generate-config.sh
```

The script will automatically replace the default SSH key with yours.

## Security Notes

- ⚠️ Never commit `secrets.env` or `*.local.json` files
- Use strong, unique passwords
- SSH key authentication is pre-configured
- Change default password immediately after first boot
- Keep your system updated regularly

## Based On

Extracted from actual pi5main.local configuration:
- Debian 13 (Trixie) - Raspberry Pi OS
- NVMe SSD boot
- 16GB RAM
- WiFi connection

## License

MIT