+++
title = "Upgrading NixOS Channels"
author = ["Josef Erben"]
date = 2021-11-24
tags = ["linux", "nixos"]
draft = false
+++

Upgrading NixOS so that it uses a different channel is simple.

When you run following command as root:

```bash
nix-channel --list
```

You should see a list of channels. If you did not touch channels so far, you should see this:

```bash
nixos https://nixos.org/channels/nixos-21.05
```

By running the following command (as root):

```bash
nix-channel --add https://nixos.org/channels/<channel version> nixos
```

you will remove the 21.05 channel and replace it with &lt;channel version&gt;.

To apply the change, you need to run following command:

```bash
nixos-rebuild switch --upgrade
```

which is going to rebuild your system with your current configuration and updated packages from the channel you switched to.