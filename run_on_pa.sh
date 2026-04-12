#!/bin/bash
# 🐍 PythonAnywhere Launcher • Secure • 24/7 Ready

cd ~/cyberfortress-2026

# Загрузка токена (пароль вводится один раз при старте консоли)
if [ -z "$SILENTNET_TOKEN" ]; then
    echo "🔐 Введите пароль шифрования:"
    read -s BOT_PASS
    export SILENTNET_TOKEN=$(openssl enc -d -aes-256-cbc -pbkdf2 -in ~/.silentnet_token.enc -pass pass:"$BOT_PASS" 2>/dev/null)
    unset BOT_PASS
fi

if [ -z "$SILENTNET_TOKEN" ]; then
    echo "❌ Ошибка расшифровки токена"
    exit 1
fi

# Настройка прокси (если нужно)
if [ "$BOT_PROXY_TYPE" = "socks5" ]; then
    export HTTPS_PROXY="socks5://${BOT_PROXY_HOST:-127.0.0.1}:${BOT_PROXY_PORT:-9050}"
    echo "🌐 Прокси: $HTTPS_PROXY"
fi

# Запуск бота
echo "🚀 Запуск бота на PythonAnywhere..."
python3 immortal_bot.py
