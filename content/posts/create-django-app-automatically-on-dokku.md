+++
title = "Deploy a Django app automatically to Dokku"
author = ["Josef Erben"]
date = 2022-03-28
tags = ["dokku", "django"]
draft = false
+++

This is the script I am using to deploy a _dokkuzied_ app to Dokku.

<!--more-->

Let's assume we want to deploy an app called _browsergame_. You can us following script to do the deployment for you.

```sh
#!/bin/sh

DOKKU_HOST="${DOKKU_HOST:-lettuce}"
AWS_S3_BACKUP_PATH="${AWS_S3_BACKUP_PATH:-lettuce-backups/daily}"

echo "create app"
ssh -t dokku@${DOKKU_HOST} apps:create browsergame
ssh -t dokku@${DOKKU_HOST} domains:add browsergame game.joseferben.com

echo "set up database"
ssh -t dokku@${DOKKU_HOST} postgres:create browsergame-database
ssh -t dokku@${DOKKU_HOST} postgres:link browsergame-database browsergame

echo "set up redis"
ssh -t dokku@${DOKKU_HOST} redis:create browsergame-redis
ssh -t dokku@${DOKKU_HOST} redis:link browsergame-redis browsergame

echo "configure app"
ssh -t dokku@${DOKKU_HOST} config:set --no-restart browsergame DJANGO_DEBUG=False
ssh -t dokku@${DOKKU_HOST} config:set --no-restart browsergame DJANGO_SETTINGS_MODULE=config.settings.production
ssh -t dokku@${DOKKU_HOST} config:set --no-restart browsergame DJANGO_SECRET_KEY="$(openssl rand -base64 64 | tr -dc 'A-HJ-NP-Za-km-z2-9' | head -c 64)"
ssh -t dokku@${DOKKU_HOST} config:set --no-restart browsergame DJANGO_ADMIN_URL="$(openssl rand -base64 4096 | tr -dc 'A-HJ-NP-Za-km-z2-9' | head -c 32)/"
ssh -t dokku@${DOKKU_HOST} config:set --no-restart browsergame MAILJET_API_KEY=${MAILJET_API_KEY}
ssh -t dokku@${DOKKU_HOST} config:set --no-restart browsergame MAILJET_SECRET_KEY=${MAILJET_SECRET_KEY}

echo "mount media files to docker volume"
ssh root@${DOKKU_HOST} -f 'mkdir -p /var/lib/dokku/data/storage/browsergame/'
ssh root@${DOKKU_HOST} -f 'chown -R dokku:dokku /var/lib/dokku/data/storage/browsergame/'
ssh -t dokku@${DOKKU_HOST} storage:mount browsergame /var/lib/dokku/data/storage/browsergame:/storage

echo "serve media files using nginx"
ssh root@${DOKKU_HOST} -f 'mkdir -p /home/dokku/browsergame/nginx.conf.d'
ssh root@${DOKKU_HOST} -f 'echo "location /media {" > /home/dokku/browsergame/nginx.conf.d/media.conf'
ssh root@${DOKKU_HOST} -f 'echo "    alias /var/lib/dokku/data/storage/browsergame;" >> /home/dokku/browsergame/nginx.conf.d/media.conf'
ssh root@${DOKKU_HOST} -f 'echo "}" >> /home/dokku/browsergame/nginx.conf.d/media.conf'
ssh root@${DOKKU_HOST} -f 'chown -R dokku:dokku /home/dokku/browsergame/nginx.conf.d/media.conf'

echo "test backup to s3"
ssh -t dokku@${DOKKU_HOST} postgres:backup browsergame-database ${AWS_S3_BACKUP_PATH}

echo "set up daily backups to s3"
ssh -t dokku@${DOKKU_HOST} postgres:backup-set-encryption browsergame-database ${BACKUP_ENCRYPTION_KEY}
ssh -t dokku@${DOKKU_HOST} postgres:backup-auth browsergame-database ${AWS_ACCESS_KEY_ID} ${AWS_SECRET_ACCESS_KEY}
ssh -t dokku@${DOKKU_HOST} postgres:backup-schedule browsergame-database @daily ${AWS_S3_BACKUP_PATH}

echo "add dokku host as git remote"
git remote add dokku dokku@${DOKKU_HOST}:browsergame
```

Run the script after setting the configuration variables.

```sh
$ export AWS_S3_BACKUP_PATH=some/s3/path
$ export DOKKU_HOST=dokku-hostname
$ export AWS_ACCESS_KEY_ID=<key>
$ export AWS_SECRET_ACCESS_KEY=<secret>
$ export BACKUP_ENCRYPTION_KEY=<key>
$ export MAILJET_API_KEY=<key>
$ export MAILJET_SECRET_KEY=<secret>
$ ./scripts/create_dokku_app.sh
$ git push dokku main
```
