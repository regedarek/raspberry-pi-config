#!/bin/bash

# Generate Raspberry Pi configuration from template and secrets
# Usage: ./generate-config.sh

set -e

SECRETS_FILE="secrets.env"
TEMPLATE_FILE="pi5main-config.json"
OUTPUT_FILE="pi5main-config.local.json"

# Check if secrets file exists
if [ ! -f "$SECRETS_FILE" ]; then
    echo "Error: $SECRETS_FILE not found!"
    echo "Please create it from the template first."
    exit 1
fi

# Check if template file exists
if [ ! -f "$TEMPLATE_FILE" ]; then
    echo "Error: $TEMPLATE_FILE not found!"
    exit 1
fi

echo "Loading secrets from $SECRETS_FILE..."

# Source the secrets file
set -a
source "$SECRETS_FILE"
set +a

# Check required variables
if [ -z "$USER_PASSWORD" ] || [ -z "$WIFI_SSID" ] || [ -z "$WIFI_PASSWORD" ]; then
    echo "Error: Missing required secrets in $SECRETS_FILE"
    echo "Required: USER_PASSWORD, WIFI_SSID, WIFI_PASSWORD"
    exit 1
fi

echo "Generating $OUTPUT_FILE from template..."

# Read template and replace placeholders
cp "$TEMPLATE_FILE" "$OUTPUT_FILE"

# Replace placeholders with actual values
sed -i.bak "s|YOUR_PASSWORD_HERE|$USER_PASSWORD|g" "$OUTPUT_FILE"
sed -i.bak "s|YOUR_WIFI_SSID|$WIFI_SSID|g" "$OUTPUT_FILE"
sed -i.bak "s|YOUR_WIFI_PASSWORD|$WIFI_PASSWORD|g" "$OUTPUT_FILE"

# Replace SSH key if provided
if [ -n "$SSH_PUBLIC_KEY" ]; then
    # Escape special characters for sed
    ESCAPED_KEY=$(echo "$SSH_PUBLIC_KEY" | sed 's/[\/&]/\\&/g')
    sed -i.bak "s|YOUR_SSH_PUBLIC_KEY_HERE|$ESCAPED_KEY|g" "$OUTPUT_FILE"
fi

# Remove backup file
rm -f "${OUTPUT_FILE}.bak"

echo "✓ Configuration generated successfully!"
echo ""
echo "Next steps:"
echo "1. Open Raspberry Pi Imager"
echo "2. Click gear icon (⚙️) or press Cmd+Shift+X"
echo "3. Click 'LOAD FROM FILE'"
echo "4. Select: $OUTPUT_FILE"
echo "5. Flash to your SD card"
echo ""
echo "Note: $OUTPUT_FILE is gitignored and will not be committed"