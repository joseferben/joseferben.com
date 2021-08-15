+++
title = "Running Django Commands on AWS Elastic Beanstalk"
author = ["Josef Erben"]
date = 2021-08-13
tags = ["django", "aws"]
draft = false
+++

When hosting Django applications on AWS Elastic Beanstalk, it is often required to run commands on the server to do some maintenance tasks.

<!--more-->

Beanstalk provisions EC2 instances which are running the web server processes. Django commands need to run in the same environment.

You might want to fix your shell first.

After connecting using SSH with

```shell
eb ssh
```

load the environment variables using

```shell
export $(cat /opt/elasticbeanstalk/deployment/env | xargs)
```

then load the Python environment using

```shell
source /var/app/venv
```

and finally run your Django command

```shell
python /var/app/current/manage.py runserver
```
