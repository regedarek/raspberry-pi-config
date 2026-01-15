# Raspberry Pi 5 Configuration

Configuration files for setting up Raspberry Pi 5 with Raspberry Pi Imager.

## Quick Setup

### 1. Use with Raspberry Pi Imager

**Method 1: Use custom file**
1. Download `pi5main-config.json`
2. Open Raspberry Pi Imager
3. Click gear icon ⚙️ or press `Cmd+Shift+X`
4. Click "LOAD FROM FILE"
5. Select `pi5main-config.json`
6. Verify settings and flash

**Method 2: Use custom URL**
1. Open Raspberry Pi Imager
2. Click "USE CUSTOM URL"
3. Paste: `https://raw.githubusercontent.com/regedarek/raspberry-pi-config/main/pi5main-config.json`
4. Flash

### 2. Before Flashing - Update Credentials

Edit `pi5main-config.json` and replace:
- `YOUR_PASSWORD_HERE` → Your secure password
- `YOUR_WIFI_SSID` → Your WiFi network name
- `YOUR_WIFI_PASSWORD` → Your WiFi password

### 3. What's Pre-Configured

✅ **Hostname**: pi5main  
✅ **Username**: rege  
✅ **SSH**: Enabled with public key authentication  
✅ **WiFi**: Auto-connect on first boot  
✅ **Timezone**: Europe/Warsaw  
✅ **Keyboard**: US layout  

### 4. After First Boot

```bash
# Wait ~2 minutes, then connect
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

## Files

- `pi5main-config.json` - Raspberry Pi Imager configuration
- `README.md` - This file

## SSH Key

The configuration includes the SSH public key from the original pi5main setup.

If you need to use a different SSH key, update the `authorized_keys` field in the JSON file with your public key:

```bash
# Get your SSH public key on Mac
cat ~/.ssh/id_ed25519.pub
```

## Based On

Extracted from actual pi5main.local configuration:
- Debian 13 (Trixie) - Raspberry Pi OS
- NVMe SSD boot
- 16GB RAM
- WiFi connection

## License

MIT
