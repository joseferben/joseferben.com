+++
title = "Fix Autostart On XFCE"
author = ["Josef Erben"]
date = 2022-01-23
tags = ["linux"]
draft = false
+++

It took me three months and five attempts to fix this issues. Upon reboot two terminal panes and one Emacs instance auto started and I didn't know why.

<!--more-->

Even though I run a comparably lightweight setup on my laptop, consisting mostly of XFCE as desktop manager and i3wm as window manager, it took me way too long to figure out why some things auto started.

In NixOS this is defined by `services.xserver.displayManager.defaultSession = "xfce+i3";`. It is also possible to declaratively run commands after session creation using `services.xserver.displayManager.sessionCommands`. Neither of those configurations should cause two terminals and Emacs to autostart, at least it should be very obvious if that was the case. The problem must come from some mutable state that is outside of the scope of my nix configuration.

Let's open the XFCE Session settings using `xfce4-session-settings`. If there is a tab called "Saved Sessions", we might have saved the session accidentally at some point.
![](/ox-hugo/xfce-sessions-saved.png)

Now if we check the `Automatically save session on logout` setting on the "General" tab, it should be disabled. One would think that this means that the saved sessions are ignored when starting up. But it turns out that the setting literally means that the session is not saved anymore on logout. It will still happily load saved sessions if you have any.
![](/ox-hugo/xfce-sessions-logout.png)

The fix should be quite clear at this point. The auto start can be stopped by deleting all saved sessions. Programmatically this can be done using `rm ~/.cache/sessions/*`.