+++
title = "Thinkpad T14 with NixOS and I3WM"
author = ["Josef Erben"]
date = 2021-11-19
tags = ["linux", "nixos"]
draft = true
+++

3 months ago I installed NixOS, i3wm and XFCE on my new Thinkpad T14 (1st Gen). It is my main machine that I use for work and for private stuff. In this blog post I summarize my experience with it.

<!--more-->


## Setup {#setup}

```nil
          ▗▄▄▄       ▗▄▄▄▄    ▄▄▄▖            josef@dijkstra
          ▜███▙       ▜███▙  ▟███▛            --------------
           ▜███▙       ▜███▙▟███▛             OS: NixOS 21.05 (Okapi) x86_64
            ▜███▙       ▜██████▛              Host: 20UD0013MZ ThinkPad T14 Gen 1
     ▟█████████████████▙ ▜████▛     ▟▙        Kernel: 5.14.10
    ▟███████████████████▙ ▜███▙    ▟██▙       Uptime: 17 hours, 35 mins
           ▄▄▄▄▖           ▜███▙  ▟███▛       Packages: 1534 (nix-system), 288 (nix-user)
          ▟███▛             ▜██▛ ▟███▛        Shell: zsh 5.8
         ▟███▛               ▜▛ ▟███▛         Resolution: 1920x1080
▟███████████▛                  ▟██████████▙   DE: Xfce 4.16
▜██████████▛                  ▟███████████▛   WM: i3
      ▟███▛ ▟▙               ▟███▛            Theme: Adwaita-dark [GTK2]
     ▟███▛ ▟██▙             ▟███▛             Icons: Rodent [GTK2]
    ▟███▛  ▜███▙           ▝▀▀▀▀              Terminal: urxvt
    ▜██▛    ▜███▙ ▜██████████████████▛        Terminal Font: Source Code Pro
     ▜▛     ▟████▙ ▜████████████████▛         CPU: AMD Ryzen 7 PRO 4750U with Radeon Graphics
           ▟██████▙       ▜███▙               GPU: AMD ATI 07:00.0 Renoir
          ▟███▛▜███▙       ▜███▙              Memory: 4425MiB / 15232MiB
         ▟███▛  ▜███▙       ▜███▙
         ▝▀▀▀    ▀▀▀▀▘       ▀▀▀▘
```


## Window Manager + Desktop Manager {#window-manager-plus-desktop-manager}

Coming from Arch, I was quite comfortable using the tiled window manager i3wm. After setting it up 4 years ago I was sure I could never go back to normal windows.

However, I always assumed that the trade-off for using such a productive tiled window manager was that you lose convenience. With my Arch setup, I had to mount USB sticks myself, discover, pair and connect Bluetooth devices from the command line and map media keys (such as brightness and audio volume) manually in my `.config/i3/config`.

Little did I know that I was missing a Desktop Manager!

Let me explain in Nix:

```nix
services.xserver.windowManager.i3.enable = true;
services.xserver.desktopManager = {
  xterm.enable = false;
  xfce = {
    enable = true;
    noDesktop = true;
    enableXfwm = false;
  };
};
```

This is all it took to enable i3wm as my tiling _Window Manager_ and XFCE as my _Desktop Manager_. Now XFCE is taking care of all the things like USB stick mounting, login screen, screensaver, centralized settings, external monitors and many things more. All while I divide and conquer my windows with i3wm. Best of both worlds!

To be fair, I recall reading about using XFCE and other desktop environments with tiling managers. But it was NixOS that made the difference between _Desktop Manager_ and _Window Manager_ obvious to me.


## Battery life {#battery-life}

Coming from a T470 with largest external battery (that guy had an internal one too), I am not that happy with the batter of the T14.
Web development, answering emails, light browsing and occasional OCaml compilations drain the battery in about 5-6 hours.

I activated [TLP](https://wiki.archlinux.org/title/TLP) using following flag:

```nix
services.tlp.enable = true;
```

I suspect that I should invest some time into understanding TLP to make most of it.


## CPU {#cpu}

The CPU is hands down my favorite part of the T14. It stays cool and fast. The only time when I hear the fans is when I create OCaml switches.

It compiles [Sihl] in about 15 seconds.


## Screen {#screen}

My second favorite part of this machine is the screen. A bright screen allows me to work in sunny places outside in a coffee place.

When it is really bright I have to switch my Emacs theme to light mode.


## Fingerprint sensor {#fingerprint-sensor}

I managed to get the fingerprint sensor working as well with just three lines:

```nix
services.fprintd.enable = true;
security.pam.services.login.fprintAuth = true;
security.pam.services.xscreensaver.fprintAuth = true;
```

It works well.


## Trackpad {#trackpad}

Don't forget to enable the trackpad, which is not done by the NixOS installer by default:

```nix
services.xserver.libinput.enable = true;
```


## Kernel settings {#kernel-settings}

I adjusted the kernel settings based on some research about how similar Thinkpad models have their `configuration.nix`.

```nix
boot.initrd.availableKernelModules = [ "nvme" "ehci_pci" "xhci_pci" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" "thinkpad_acpi" ];
boot.initrd.kernelModules = [ "acpi_call" ];
boot.kernelModules = [ "kvm-amd" ];
boot.extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];
```


## Summary {#summary}

I am very happy to have decided to buy an AMD Ryzen based Thinkpad. Battery life could be better, but the bright screen and silent but powerful CPU make up for it. Everything else is typical Thinkpad level quality!
