+++
title = "How to Generate Random Strings on Linux with In Line"
author = ["Josef Erben"]
date = 2021-11-17
tags = ["linux"]
draft = false
+++

With following command you can print a random string of a certain `length` on Linux.

`tr -dc A-Za-z0-9 </dev/urandom | head -c <length> ; echo ''`

The string is safe to use in most web contexts such as HTML forms or environment variables.
