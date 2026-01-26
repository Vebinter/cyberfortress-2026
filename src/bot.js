console.log('🪤 CyberFortress2026 v1.0 — ЖДЕТ TOKEN!');
const { Telegraf } = require('telegraf');
const bot = new Telegraf('8341597401:AAEHAO6LBnfVUE1swTXGsY1Y4sezMNtPzH0');
bot.start((ctx) => ctx.reply('🪤 CyberFortress2026!\n1. TON GameFi\n2. CFORT Farm\n3. Honeypot Data'));
bot.launch().then(() => console.log('🚀 LIVE!'));
