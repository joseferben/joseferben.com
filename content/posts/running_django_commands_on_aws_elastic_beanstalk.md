+++
title = "Running Django Commands on AWS Elastic Beanstalk"
author = ["Josef Erben"]
date = 2021-08-13
draft = false
+++

AWS Elastic Beanstalk is a service that takes care of setting up all the AWS resources to host a typical web app.

When hosting Django applications, it is often required to run commands on the server to do some maintenance tasks. Beanstalk provisions EC2 instances which are running the web server processes. Django commands need to run in the same environment.

You might want to fix your shell first.

After connecting using SSH with

```nil
eb ssh
```

load the environment variables using

```nil
export $(cat /opt/elasticbeanstalk/deployment/env | xargs)
```

then load the Python environment using

```nil
source /var/app/venv
```

and finally run your Django command

```nil
python /var/app/current/manage.py runserver
```
