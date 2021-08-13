+++
title = "Autostart Dropbox on NixOS using I3WM"
author = ["Josef Erben"]
date = 2021-08-13T00:00:00
tags = ["nixos"]
draft = false
+++

Install Dropbox using NixOS in your preferred way.

At the top of your i3wm configuration file add

```conf
exec dropbox &
```
