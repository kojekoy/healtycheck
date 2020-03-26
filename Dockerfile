FROM node:8
RUN apt-get update && apt-get -y install cron 
RUN mkdir /tes 
COPY package.json /tes
WORKDIR /tes
RUN  npm install
COPY . .
ADD cronjob /etc/cron.d/cronjob
RUN chmod +x /etc/cron.d/cronjob && chmod +x /tes/update.sh && touch /var/log/cron.log
RUN crontab /etc/cron.d/cronjob && rm -rf /var/lib/apt/list/*
EXPOSE 3000
CMD node app.js > /var/log/cron.log

