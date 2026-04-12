#!/bin/bash
# 🎨 MASTERPIECE: Safe Bot Patcher • Proxy Support • Zero Bash Errors
# Запуск: bash ~/cyberfortress-2026/patch_bot.sh

set -e  # Остановиться при ошибке
cd ~/cyberfortress-2026

echo "🎨 Patching immortal_bot.py..."

# 1️⃣ Проверяем зависимости
if ! python3 -c "import telebot, socks" 2>/dev/null; then
    echo "📦 Устанавливаем pysocks..."
    pip3 install --break-system-packages pysocks -q
fi

# 2️⃣ Создаём безопасный шаблон нового immortal_bot.py
cat > immortal_bot_new.py << 'PYEOF'
#!/usr/bin/env python3
# 🔐 SilentNet_AIBot • Secure Token Loading • Proxy Ready
import os, sys, time, signal, hashlib, subprocess, logging

# ─────────────────────────────────────────────────────────────
# 🔐 БЕЗОПАСНАЯ ЗАГРУЗКА ТОКЕНА (только через run_bot.sh)
BOT_TOKEN = os.getenv("SILENTNET_TOKEN")
if not BOT_TOKEN:
    print("❌ ОШИБКА: Токен не найден.")
    print("👉 Запускайте бота ТОЛЬКО через: bash ~/cyberfortress-2026/run_bot.sh")
    sys.exit(1)

# ─────────────────────────────────────────────────────────────
# 🌐 НАСТРОЙКА ПРОКСИ (гибкая конфигурация)
PROXY_TYPE = os.getenv("BOT_PROXY_TYPE", "none").lower()  # none, socks5, http
PROXY_HOST = os.getenv("BOT_PROXY_HOST", "127.0.0.1")
PROXY_PORT = os.getenv("BOT_PROXY_PORT", "9050")
PROXY_USER = os.getenv("BOT_PROXY_USER", "")
PROXY_PASS = os.getenv("BOT_PROXY_PASS", "")

def setup_proxy():
    """Настраивает прокси для telebot"""
    if PROXY_TYPE == "none":
        print("🌐 Бот запущен напрямую (если не работает — настройте прокси)")
        return None
    elif PROXY_TYPE == "socks5":
        auth = f"{PROXY_USER}:{PROXY_PASS}@" if PROXY_USER else ""
        proxy_url = f"socks5://{auth}{PROXY_HOST}:{PROXY_PORT}"
        print(f"🌐 Бот запущен через SOCKS5: {PROXY_HOST}:{PROXY_PORT}")
        return {"https": proxy_url}
    elif PROXY_TYPE == "http":
        auth = f"{PROXY_USER}:{PROXY_PASS}@" if PROXY_USER else ""
        proxy_url = f"http://{auth}{PROXY_HOST}:{PROXY_PORT}"
        print(f"🌐 Бот запущен через HTTP: {PROXY_HOST}:{PROXY_PORT}")
        return {"https": proxy_url}
    else:
        print(f"⚠️ Неизвестный тип прокси: {PROXY_TYPE}. Запускаю напрямую.")
        return None

# ─────────────────────────────────────────────────────────────
# 🤖 ИНИЦИАЛИЗАЦИЯ БОТА
import telebot

proxy_conf = setup_proxy()
if proxy_conf:
    telebot.apihelper.proxy = proxy_conf

bot = telebot.TeleBot(BOT_TOKEN)
print("✅ Бот запущен успешно!")
logging.basicConfig(level=logging.INFO, format="%(asctime)s - %(levelname)s - %(message)s")

# ─────────────────────────────────────────────────────────────
# 📦 ПРИМЕР КОМАНД (замените на вашу логику)
@bot.message_handler(commands=["start"])
def cmd_start(message):
    bot.reply_to(message, "👋 Привет! Я ваш защищённый AI-ассистент.")

@bot.message_handler(commands=["ping"])
def cmd_ping(message):
    bot.reply_to(message, "🏓 Pong! Бот работает и токен защищён.")

@bot.message_handler(func=lambda m: True)
def echo_all(message):
    # Здесь ваша логика обработки сообщений
    logging.info(f"📨 Сообщение от @{message.from_user.username}: {message.text[:50]}...")
    # bot.reply_to(message, f"Вы написали: {message.text}")  # раскомментируйте для эхо-режима

# ─────────────────────────────────────────────────────────────
# ♾️ ВЕЧНЫЙ ЗАПУСК С ПЕРЕПОДКЛЮЧЕНИЕМ
def signal_handler(sig, frame):
    print("\n🛑 Получен сигнал остановки. Очищаю память...")
    os.environ.pop("SILENTNET_TOKEN", None)
    sys.exit(0)

signal.signal(signal.SIGINT, signal_handler)
signal.signal(signal.SIGTERM, signal_handler)

print("🤖 ВЕЧНЫЙ БОТ 24/7 запущен! (Ctrl+C для остановки)")
while True:
    try:
        bot.infinity_polling(timeout=30, long_polling_timeout=30)
    except Exception as e:
        logging.error(f"⚠️ Ошибка polling: {e}. Переподключение через 10 сек...")
        time.sleep(10)
PYEOF

# 3️⃣ Заменяем старый файл на новый (атомарно)
mv immortal_bot_new.py immortal_bot.py
chmod +x immortal_bot.py

echo "✅ immortal_bot.py обновлён!"
echo ""
echo "🎯 КАК ЗАПУСТИТЬ:"
echo "   bash ~/cyberfortress-2026/run_bot.sh"
echo ""
echo "🌐 КАК ВКЛЮЧИТЬ ПРОКСИ (перед запуском):"
echo "   # Для Tor:"
echo "   export BOT_PROXY_TYPE=socks5"
echo "   export BOT_PROXY_HOST=127.0.0.1"
echo "   export BOT_PROXY_PORT=9050"
echo ""
echo "   # Для своего SOCKS5 прокси:"
echo "   export BOT_PROXY_TYPE=socks5"
echo "   export BOT_PROXY_HOST=proxy.example.com"
echo "   export BOT_PROXY_PORT=1080"
echo "   export BOT_PROXY_USER=myuser"
echo "   export BOT_PROXY_PASS=mypass"
echo ""
echo "✅ Готово! Бот защищён, прокси настраивается через переменные окружения."
