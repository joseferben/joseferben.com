+++
title = "Ignoring Files with Dropbox on Linux"
author = ["Josef Erben"]
date = 2021-11-22
tags = ["linux"]
draft = false
+++

On Linux you can set attributes to ignore files for syncing.

<!--more-->

To ignore a file on Linux:

```nil
attr -s com.dropbox.ignored -V 1 /path/to/file
```

To unignore a file on Linux:

```nil
attr -r com.dropbox.ignored /path/to/file
```