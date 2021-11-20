+++
title = "How To Fix Bash Autocomplete on Elastic Beanstalk When Using SSH"
author = ["Josef Erben"]
date = 2021-11-21
tags = ["linux", "aws"]
draft = true
+++

If you use a terminal like urxvt to connect to your EC2 instance through Elastic Beanstalk, running

```nil
eb ssh
```

will give you a shell where auto-complete does not work.

Fix that by running

```nil
TERM='xterm-256color' eb ssh
```
