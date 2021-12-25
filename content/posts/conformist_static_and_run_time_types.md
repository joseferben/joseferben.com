+++
title = "Conformist - Bridging the Gap Between Static and Run-time Types in OCaml"
author = ["Josef Erben"]
date = 2021-12-20
draft = true
+++

OCaml is a great tool to write statically typed programs, where certain properties are enforced and even mathematically proven at compile-time. What if you want to ensure certain properties at run-time? That's when you would use something like conformist.

<!--more-->


## The Problem {#the-problem}

Let's say you are doing web development and you have some type representing a user. Most of the languages can express things like _the age of the user is an integer_ or the name of the user is a string/ at compile-time. This means, that the compiler or type checker ensures that you don't assign a string to the age of the user _before_ running your application.

What if we wanted to express _the age of the user is an integer between 13 and 120_? My knowledge about more expressive static type systems is very limited, but a
