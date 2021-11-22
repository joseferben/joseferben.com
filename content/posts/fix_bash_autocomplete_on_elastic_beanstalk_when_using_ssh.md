+++
title = "Fixing Bash Autocompletion on Elastic Beanstalk When Using SSH"
author = ["Josef Erben"]
date = 2021-11-21
tags = ["linux", "aws"]
draft = false
+++

If you use urxvt to connect to your EC2 instance through Elastic Beanstalk, running

```bash
eb ssh
```

will give you a shell where autocomplete does not work.

Fix that by running

```bash
TERM='xterm-256color' eb ssh
```
