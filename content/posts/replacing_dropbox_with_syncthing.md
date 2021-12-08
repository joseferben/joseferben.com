+++
title = "Replacing Dropbox With Syncthing"
author = ["Josef Erben"]
date = 2021-11-27
tags = ["linux"]
draft = false
+++

Dropbox has [some well known issues](https://200ok.ch/posts/2019-11-24%5Ftrigger%5Fdropbox%5Fon%5Flinux%5Fafter%5Fsuspend%5Fhibernate.html) on Linux which made me look at alternatives. I found an alternative that I am very happy with.

<!--more-->


## Requirements {#requirements}

I use [Getting Things Done](https://gettingthingsdone.com/) (GTD) which requires me to take notes. In order to reduce the barrier to take notes, I need to be able to quickly pull up my note taking tool and start writing.

Reducing this barrier for note taking is one of the key insights of GTD that helped me incorporate the framework into my life. It is important that I am able to capture a thought quickly and _reliably_.

Reliability is important, because in order to free my brain from thought I have to make sure that I put it somewhere safe. So the notes need to be backed up.

In separate sessions I go through the notes and create actionable items, usually on my laptop, so I want to have the same list of notes on both machines.


## Syncthing is Ticking All the Boxes {#syncthing-is-ticking-all-the-boxes}

For 2-3 years I have used Dropbox. Unfortunately, it sometimes did not sync up properly when Linux woke up from sleep/hibernation, which causes quite some merge conflicts and once even data loss.

The alternative should be a ubiquitous as Dropbox, meaning it should be available on all major platforms.

Fortunately, I found [Syncthing](https://syncthing.net/). It is a piece of software runs on the devices the need to be kept in sync. There is no central server involved.

I have used it for 3 months to sync files on my phone and my laptop. So far so great, but it only works because my phone is almost always online. It kind of takes the role of a server.


## Fully Replacing Dropbox With Syncthing {#fully-replacing-dropbox-with-syncthing}

I decided to install Syncthing on a small VPS that is online 24/7. This makes sure that all my devices get the recent versions of the files. Additionally I am using the VPS provider's service to take snapshot backups.

Setting Syncthing up on a VPS running Ubuntu and connecting it to my phone and my laptop took 2 minutes. You can follow a [guide](https://computingforgeeks.com/how-to-install-and-use-syncthing-on-ubuntu/) to install Syncthing and then open an SSH tunnel to access the GUI for setup.

```bash
ssh -L 8888:127.0.0.1:8384 root@host
```

Open <http://127.0.0.1:8888> to start the setup process.

Add your existing devices to the server, which will make sure that the devices know about each other.


### No Need to Trust the Server {#no-need-to-trust-the-server}

Encryption is the feature that sold me on Syncthing. It has built in support for untrusted devices that don't have access to the decrypted files.

When you add the untrusted device, make sure to tick the `Untrusted` box. In the list of folders simply set a password on the trusted device for the folders that you want to share with untrusted devices.

The folder type on the untrusted device should be `Receive Encrypted`.
