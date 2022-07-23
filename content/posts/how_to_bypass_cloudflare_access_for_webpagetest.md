+++
title = "How To Bypass Cloudflare Access For WebPageTest"
author = ["Josef Erben"]
date = 2022-01-01
draft = false
+++

Improving the performance of a website can be hard. Using solid performance analysis tools is a must.

<!--more-->

In order to run performance analysis using [WebPageTest](https://webpagetest.org/) on a website that is protected by [Cloudflare Access](https://www.cloudflare.com/teams/access/), you need to tell WebPageTest to authenticate.

First, manually access the website by entering your email and then the confirmation code. The next request sets a cookie with the key `CF_Authorization`.

That cookie can be set as header when running the performance test. Under _Script_ you are able to define the steps that are taken by WebPageTest during the performance test.

```nil
setCookie https://%HOST% CF_Authorization=<value>
navigate %URL%
```