#!/bin/bash
cd ~/cyberfortress-2026

# Расшифровка токена из Secrets Replit
if [ -n "$SILENTNET_TOKEN_ENC" ] && [ -n "$SILENTNET_PASS" ]; then
    echo "$SILENTNET_TOKEN_ENC" | openssl enc -d -aes-256-cbc -pbkdf2 -pass pass:"$SILENTNET_PASS" 2>/dev/null > /tmp/token.txt
    export SILENTNET_TOKEN=$(cat /tmp/token.txt)
    rm -f /tmp/token.txt
fi

if [ -z "$SILENTNET_TOKEN" ]; then
    echo "❌ Токен не загружен"
    exit 1
fi

python3 immortal_bot.py
