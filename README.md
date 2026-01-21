# Raspberry Pi Auto Config

**Zero-config** Pi Imager setup. Auto-detects WiFi, fetches passwords from keychain, injects SSH keys.

## ⚡ 30-Second Setup

```bash
./gen server          # 1. Generate config
./gen serve           # 2. Start HTTP server
# 3. Pi Imager → Cmd+Shift+X → Use custom URL:
#    http://localhost:8000/pi-config-server.json
# 4. Choose "Raspberry Pi OS Lite (64-bit)"
# 5. Flash!
```

## 🚀 Quick Start

```bash
./gen              # Server config (headless)
./gen desktop      # Desktop config (GUI)
```

That's it! The script automatically:
- ✅ Detects your WiFi network
- ✅ Fetches WiFi password from macOS Keychain (one prompt per session)
- ✅ Finds your SSH key from `~/.ssh/`
- ✅ Generates optimized config
- ✅ Copies to clipboard

## 📋 Config Types

### 🖥️ Server (Headless)
```bash
./gen server
./gen server pi5backup  # Custom hostname
```

**Recommended OS:** Raspberry Pi OS Lite (64-bit) - No desktop

**Optimizations:**
- Bluetooth disabled
- Audio disabled  
- GPU memory: 16MB (minimal)
- Splash screen disabled
- Fast boot (0s delay)
- SSH-only access

**Use for:** Web servers, Docker hosts, headless automation

### 🖥️ Desktop (GUI)
```bash
./gen desktop
./gen desktop pi5dev  # Custom hostname
```

**Recommended OS:** Raspberry Pi OS (64-bit) - Full desktop

**Optimizations:**
- GPU memory: 256MB
- HDMI hotplug enabled
- Overscan disabled
- Full desktop environment

**Use for:** Development workstation, media center, GUI apps

## 🔧 Manual Override

### Environment Variables
```bash
PI_PASSWORD=mypass ./gen server
PI_PASSWORD=x SSID=MyWifi WIFI_PASS=secret ./gen
```

### Secrets File (Optional)
Create `secrets.env`:
```bash
PI_PASSWORD=byledozimy
```

The script will auto-load it if present.

## 📥 Load in Pi Imager

### Method 1: Use Custom URL (Recommended)

1. Generate config: `./gen server`
2. Start HTTP server: `./gen serve`
3. Open Raspberry Pi Imager
4. **Choose OS:**
   - **Server:** Raspberry Pi OS Lite (64-bit)
   - **Desktop:** Raspberry Pi OS (64-bit) with desktop
5. **Choose Storage:** Your SD card
6. Press `Cmd+Shift+X` (Mac) or `Ctrl+Shift+X` (Windows/Linux)
7. Select "Use custom URL"
8. Enter: `http://localhost:8000/pi-config-server.json`
9. Click "Yes" to apply settings
10. Flash!

### Method 2: Load from File

1. Open Raspberry Pi Imager
2. Choose appropriate OS (see recommendations above)
3. Choose Storage
4. Press `Cmd+Shift+X` (Mac) or `Ctrl+Shift+X` (Windows/Linux)
5. Click "Load from file" → Select `/tmp/pi-config-server.json`
6. Flash!

## 🔐 Security

- SSH key never committed
- WiFi password from keychain (macOS prompts once per session)
- Optional `secrets.env` is gitignored
- Password auth disabled (SSH key only)

## 📁 Files

- `config-server.json` - Server template
- `config-desktop.json` - Desktop template
- `gen` - Magic generator script
- `secrets.env` - Optional password storage (gitignored)

## ⚙️ Default Settings

- **Hostname**: `pi5main` (customizable)
- **Username**: `rege`
- **SSH**: Enabled (public key only)
- **WiFi**: Auto-detected
- **Timezone**: `Europe/Warsaw`
- **Keyboard**: `us`

## 🛠️ Requirements

- macOS (for WiFi/keychain auto-detection)
- SSH key in `~/.ssh/id_ed25519.pub` or `~/.ssh/id_rsa.pub`
- Python 3 (for HTTP server - built into macOS)

Linux users: Script will prompt for WiFi password.

## 💡 Tips

**Change defaults:** Edit `config-server.json` or `config-desktop.json`

**Multiple Pis:** Run script multiple times with different hostnames
```bash
./gen server pi5web
./gen server pi5db
./gen desktop pi5dev
```

Each generates a separate config file.

**Serve multiple configs:** Generate several configs, then run `./gen serve` to serve them all via HTTP. Pi Imager can then load any of them by URL.

## 🎯 OS Selection Guide

| Config Type | Recommended OS | Use Case |
|-------------|---------------|----------|
| **Server** | Raspberry Pi OS Lite (64-bit) | Web servers, Docker, headless automation |
| **Desktop** | Raspberry Pi OS (64-bit) | Development, GUI apps, media center |
| **Server** | Ubuntu Server 24.04 LTS | Advanced server setups, Kubernetes |
| **Desktop** | Raspberry Pi OS Full (64-bit) | Maximum software, LibreOffice, games |

💡 **Tip:** Always choose 64-bit OS for Pi 4/5 for better performance.