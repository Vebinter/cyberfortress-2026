#!/usr/bin/env python3
import telebot, hashlib, time, subprocess, os, signal, sys
from telebot import types

MY_USER_ID = 8031607305
MY_SECRET = "tetrisubuntu-CyberFortress2026-26.01.2026-Eternal"
BOT_TOKEN = "8341597401:AAEHAO6LBnfVUE1swTXGsY1Y4sezMNtPzH0"

def is_me(user_id):
    timestamp = str(int(time.time() // 3600))
    check_hash = hashlib.sha256(f"{user_id}:{MY_SECRET}:{timestamp}".encode()).hexdigest()[:8]
    return user_id == MY_USER_ID and check_hash.startswith('a1b2')

bot = telebot.TeleBot(BOT_TOKEN)

@bot.message_handler(commands=['start', 'status'])
def private_only(message):
    if not is_me(message.from_user.id):
        bot.reply_to(message, "❌ 404")
        return
    status = f"🪤 CFORT {time.strftime('%H:%M')}:\n"
    status += f"🔒 UFW: {subprocess.getoutput('sudo ufw status numbered | wc -l')}\n"
    status += f"🪤 Honey: {subprocess.getoutput('ps aux | grep 1561 | wc -l')}\n"
    status += f"🤖 PM2: {subprocess.getoutput('pm2 status | grep Personal | wc -l')}"
    bot.reply_to(message, status)

print("🤖 ВЕЧНЫЙ БОТ 24/7 запущен!")
bot.infinity_polling()
