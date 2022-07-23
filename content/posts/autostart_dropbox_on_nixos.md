+++
title = "Autostart Dropbox on NixOS using I3WM"
author = ["Josef Erben"]
date = 2021-08-13
tags = ["linux", "nixos"]
draft = false
+++

Install Dropbox using NixOS in your preferred way.

<!--more-->

At the top of your i3wm configuration file add

```cfg
exec dropbox &
```