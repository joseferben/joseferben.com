+++
title = "Installing Only Certain Packages from Unstable on NixOS"
author = ["Josef Erben"]
date = 2021-11-23
tags = ["linux", "nixos"]
draft = false
+++

Following the [NixOS installation](https://nixos.org/manual/nixos/stable/index.html#ch-installation) guide I ended up with a setup using a stable NixOS channel that just keeps giving. Sometimes however, it can be necessary to include packages from an unstable channel.

<!--more-->

This is the snippet that you can use in your nix configuration if you want to install unstable neovim:

```nix
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