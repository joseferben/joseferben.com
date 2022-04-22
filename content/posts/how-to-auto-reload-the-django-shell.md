+++
title = "How to auto-reload the Django shell"
author = ["Josef Erben"]
date = 2022-04-22
draft = false
+++

The Django shell `python manage.py shell` is a very powerful tool that increases developer productivity if used correctly. With a few lines of configuration, you don't have to leave the shell anymore to apply code changes.

<!--more-->

I highly recommend to use [shell_plus](https://django-extensions.readthedocs.io/en/latest/shell_plus.html) which auto-imports your models and commonly used helpers. In order to reload the code base without leaving the shell, you need to use the `autoreload` extension of IPython.

First, make sure you are using IPython by adding the line `SHELL_PLUS = "ipython"` to your Django config.

Create a file `.iptyhon/profile_default/ipython_config.py` with following content:

```nil
c.InteractiveShellApp.extensions = ["autoreload"]
c.InteractiveShellApp.exec_lines = ["%autoreload 2"]
```

Open the shell using `IPYTHONDIR=.ipython python manage.py shell_plus`, make a code change and re-run the code in the shell. Magic!
