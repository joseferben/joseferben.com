+++
title = "Update NixOS packages individually"
author = ["Josef Erben"]
date = 2022-03-18
tags = ["nixos"]
draft = false
+++

This is how you can selectively install packages from a specific commit or branch.

<!--more-->

```nix
let
  # unstable channel can be used to install out-of-date packages
  unstable = import
    (builtins.fetchTarball https://github.com/nixos/nixpkgs/tarball/2310213ab2c8e00c931d60cd32f6bc1ecf1a1f15)
    # reuse the current configuration
    { config = config.nixpkgs.config; };
in
environment.systemPackages = with pkgs; [
  ...
  unstable.signal-desktop
  ...
]
```
