#!/usr/bin/env python3
import os, telebot, hashlib, time, subprocess

# ТВОИ ЛИЧНЫЕ ХЭШИ (никто не угадает!)
MY_USER_ID = 8031607305
MY_SECRET = "tetrisubuntu-CyberFortress2026-26.01.2026"
BOT_TOKEN = "8341597401:AAEHAO6LBnfVUE1swTXGsY1Y4sezMNtPzH0"  # ТВОЙ ТОКЕН

bot = telebot.TeleBot(BOT_TOKEN)

def is_me(user_id):
    timestamp = str(int(time.time() // 3600))
    check_hash = hashlib.sha256(f"{user_id}:{MY_SECRET}:{timestamp}".encode()).hexdigest()[:8]
    return user_id == MY_USER_ID and check_hash.startswith('a1b2')

@bot.message_handler(commands=['start', 'status'])
def private_only(message):
    if not is_me(message.from_user.id):
        bot.reply_to(message, "❌ Бот не существует. 404.")
        return
    
    status = f"🪤 КРЕПОСТЬ {time.strftime('%H:%M')}:\n"
    status += f"🔒 UFW: {subprocess.check_output('sudo ufw status numbered | wc -l', shell=True).decode().strip()}\n"
    status += f"🪤 Honeypot: {subprocess.check_output('ps aux | grep 1561 | wc -l', shell=True).decode().strip()}\n"
    status += f"🤖 PM2: {subprocess.check_output('pm2 status | grep Personal | wc -l', shell=True).decode().strip()}\n"
    status += f"🌐 IP: {subprocess.check_output('curl -s ifconfig.me', shell=True).decode().strip()}"
    bot.reply_to(message, status)

print("🤖 Личный бот ТОЛЬКО для тебя запущен!")
bot.polling(none_stop=True)
