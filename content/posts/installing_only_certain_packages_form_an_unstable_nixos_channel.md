+++
title = "Installing Only Certain Packages from Unstable on NixOS"
author = ["Josef Erben"]
date = 2021-11-23
tags = ["linux", "nixos"]
draft = true
+++

This is how you can mainly run on a stable NixOS channel and still use some packages from unstable:

```nil
{ config, pkgs, ... }:
let
  unstableTarball =
    fetchTarball
      https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz;
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  nixpkgs.config = {
    packageOverrides = pkgs: with pkgs; {
      unstable = import unstableTarball {
        config = config.nixpkgs.config;
      };
    };
  };
  environment.systemPackages = with pkgs; [
    unstable.neovim
    emacs
  ];
}
```
