module.exports = {
  apps: [{
    name: 'PersonalCFORT',
    script: 'personal_bot.py',
    env: {
      NEW_TOKEN: '8341597401:AAEHAO6LBnfVUE1swTXGsY1Y4sezMNtPzH0',
      NODE_ENV: 'production'
    },
    autorestart: true,
    max_memory_restart: '200M'
  }]
};
