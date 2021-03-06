+++
title = "How Google Search is making me a better programmer"
author = ["Josef Erben"]
date = 2022-03-23
draft = false
+++

It hit me that the recent [decline of the Google Search result quality](https://twitter.com/mwseibel/status/1477701120319361026) is making me a better programmer. Year old habits are changing. The title should be read as "How _lack of_ Google Search is making me a better programmer".

<!--more-->


## Many eyes on mainstream technologies 👀 {#many-eyes-on-mainstream-technologies}

Up until October 2021, my daily driver as a programmer was an exotic mix of OCaml and [NixOS](http://localhost:1313/tags/nixos/). Few people are using that combination daily. This has some interesting side effects. Google Search delivers either exactly the right answers or nothing at all.

Let's compare the average OCaml programmer with the average Python programmer. The OCaml programmer is probably more experienced on average. Yet, in absolute numbers, there are more experienced Python programmers than OCaml programmers.
Now let's assume both groups are active in forums and discussions. There should be much more high quality content / answers about Python than OCaml. There are just so many more developers using Python than OCaml.

The job of Google Search is to crawl the public Python content. If Google Search does a good job, it shows me relevant quality Python content. But this is not what's happening. Instead, I am given poorly designed [GitHub](https://githubplus.com/) or Stack Overflow clones. Or programming blogs with low effort tutorials trying to sell a course. I mean kudos to them for getting Google to list them before the content that they ripped off. This is what is called SEO garbage or SEO spam.

If there are enough eyes on a language or technology, there is money to be made. If there is money to be made, everything necessary will be done to catch as many eyes as possible.


## SEO spam is changing my habits {#seo-spam-is-changing-my-habits}

I was surprised when I started using Python after years of more niche technologies. Google was not as helpful anymore as it once was for mainstream technologies.

With OCaml and ReasonML, I was getting used to jumping straight into the source code upon encountering a very specific issue. The chance of someone encountering the same issue with the same exotic tech stack _and_ posting about it online was too low to even try.
Yet, Googling OCaml language constructs was still efficient and it took me seconds to find good answers. Hits were usually in documentations of a bigger libraries or frameworks. I kept using Google like a programming language cheat sheet.

I started using [Django](http://localhost:1313/tags/django/) for a new project, which is a Python web framework that [has a lot of eyes on it](https://github.com/django/django/stargazers). I had to ditch Google as a cheat sheet replacement. In fact, I had to ditch Google as a long-term memory replacement.

Back when Google released live search result suggestions that suggested queries _while_ typing, I was excited. It worked surprisingly well, and so I started accepting suggestions for queries that were better than my own. Google knew better than myself _how_ I wanted to search.
The search results kept getting better with every year. At some point the search results were so good that usually the first search result was a hit.

That high quality version of Google Search made me lazy. With Google at hand, I was able to focus on higher level concepts, architecture and design. I could be sure that someone somewhere encountered a somewhat similar issue and Google _would do its magic_.

Don't get me wrong, I don't copy and paste a code snippet without exactly understanding what it does. I admit however, that I don't remember the archaic arguments to extract a tar file or to convert a video with ffmpeg. And that sometimes the accepted answer on Stack Overflow is useful. Especially when abandoned or very young projects lack good documentation.

Things changed and I am starting to remember these things because wasting minutes scrolling through SEO spam _is not worth it_. Back when I was able to find exactly what I needed in _seconds_, Google Search was my general purpose cheat sheet. Today, I've adjusted:

-   I have invested in better tooling to jump reliably into library code and to get inline documentation for dynamic languages
-   I [take notes](https://github.com/joseferben/memb), essentially building my [own knowledge base](https://www.joseferben.com/search/) that slowly trickles into my brain
-   I started exploring the tools I use everyday deeper and using self documentation if available
-   I search very specific communities using Google

To put it in other words, I reduced my reliance on external information. External information outside of my own brain and external information outside of my own notes.

A part of it is perhaps just me maturing as programmer. However, not being able to use Google Search as my general purpose cheat sheet definitely changed my habits.


## How to Google {#how-to-google}

I am not memorizing every dark corner of every standard library of every language that I am using. Nevertheless, the mental model of that _Magical Input Field On White Background That Knows What I Want Before I Start Typing_ is gone. At least when it comes to programming and related subjects.

After having tried Bing and DuckDuckGo I still use Google. Based on anecdotal evidence all the big search engines are having a hard time showing me relevant search results for my queries. I am stuck with Google but my search habits are changing.

-   Append _reddit_ or _hackernews_ to technological queries
-   Use [uBlacklist](https://github.com/iorate/ublacklist) to block sites from showing up in Google Search
-   Use [curated blocklists](https://github.com/arosh/ublacklist-github-translation) to get rid of the GitHub and Stack Overflow clones
-   Start taking notes
-   Go back to your notes before Googling
-   Use tooling that allows you to browse source code of libraries _fast_


## The Next Google {#the-next-google}

I don't know enough about the topic of search to write about the reasons for the outlined issues. Maybe it is the environment that makes it difficult to produce relevant search results, so even a behemoth like Google struggles. It is hard for me to believe that someone can just come out of nowhere and beat Google in general search, but who knows?

Maybe the time has come for [specific search engines](https://twitter.com/paulg/status/1477760548787920901)? Maybe tools like [GitHub Copilot](https://copilot.github.com/) will make general purpose search engines like Google less relevant for programmers?


## Thank you Google {#thank-you-google}

Thank you Google for showing me that my brain can easily store that information that I previously deemed not worthy to store. Thank you for making me explore my everyday [tools deeper](https://www.kernel.org/doc/man-pages/) and use [built-in documentation](https://www.emacswiki.org/emacs/SelfDocumentation) where possible.