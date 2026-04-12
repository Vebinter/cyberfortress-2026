#!/bin/bash
# 🔐 Secure Bot Launcher • OpenSSL • Zero-Leak Memory

echo "🚀 Запуск SilentNet_AIBot..."
echo "👉 Введите пароль шифрования (ввод скрыт):"
read -s BOT_PASS
echo ""

# 1. Расшифровка токена в переменную окружения
export SILENTNET_TOKEN=$(openssl enc -d -aes-256-cbc -pbkdf2 -in ~/.silentnet_token.enc -pass pass:"$BOT_PASS" 2>/dev/null)

if [ -z "$SILENTNET_TOKEN" ]; then
    echo "❌ Ошибка: неверный пароль или файл повреждён"
    exit 1
fi

echo "✅ Токен загружен в ОЗУ. Запускаю бота..."
echo "🔒 (токен будет автоматически удалён из памяти при выходе)"
echo ""

# 2. Переход в папку проекта и запуск бота
cd ~/cyberfortress-2026
python3 immortal_bot.py
BOT_EXIT=$?

# 3. Мгновенная очистка памяти
unset SILENTNET_TOKEN
unset BOT_PASS
echo "🧹 Память очищена. Сессия завершена."

exit $BOT_EXIT
