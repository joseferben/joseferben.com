+++
title = "Play Anno 1404 Venice on Proton"
author = ["Josef Erben"]
date = 2021-08-15
tags = ["linux", "game"]
draft = false
+++

In order to play Anno 1404 on [Proton](https://www.protondb.com/app/33350), follow these steps.

<!--more-->


## Install DirectX {#install-directx}

```shell
WINEPREFIX=/home/<user>/.local/share/Steam/steamapps/compatdata/33350/pfx
```

```shell
wine /home/<user>/.local/share/Steam/steamapps/common/Anno\ 1404/DirectX/DXSETUP.exe
```


## Edit Engine.ini file {#edit-engine-dot-ini-file}

The content of the file

```nil
/home/<user>/.local/share/Steam/steamapps/common/Anno\ 1404/Engine.ini
```

```nil
<InitFile>
<DirectXVersion>9</DirectXVersion>
<UbiSurveyTime>-1</UbiSurveyTime>
<UbiSurveyTimeStatus>2</UbiSurveyTimeStatus>
</InitFile>
```
