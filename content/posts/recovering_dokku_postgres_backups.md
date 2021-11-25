+++
title = "Recovering Dokku Postgres Backups"
author = ["Josef Erben"]
date = 2021-11-25
tags = ["dokku"]
draft = false
+++

[Dokku](https://dokku.com/) with its Postgres plugin can be used to manage Postgres databases, this includes [automated backups](https://github.com/dokku/dokku-postgres#backups).

<!--more-->

Once automated backups are implemented, you end up having encrypted database dumps in your backup location (which usually is some S3 storage). These are the steps needed to decrypt, unpack and apply the backups to Postgres instance managed by Dokku that the backup was created of.

-   `gpg --pinentry-mode=loopback --passphrase "<passphrase>" -d -o <outfile>.tgz <backup>.tgz.gpg`
-   `mkdir <output>`
-   `tar zxvf <backup>.tgz -C <output>`
-   `docker exec -i <container_name> pg_restore -U admin -d dev --no-owner < <dump.sql>`

    I feel like these steps could be part of the great [Dokku Postgres Plugin](https://github.com/dokku/dokku-postgres#backups).