+++
title = "Switching from elpy to anaconda-mode"
author = ["Josef Erben"]
date = 2021-12-08
tags = ["emacs", "python"]
draft = false
+++

I am using Emacs with [elpy](https://github.com/jorgenschaefer/elpy) as my Python IDE. Minor issues that appeared lately made me explore other options for developing Python in Emacs. I ended up switching to a custom configuration based on [anaconda-mode.](https://github.com/pythonic-emacs/anaconda-mode)

<!--more-->


## Elpy {#elpy}

Elpy is great to get started. Having an Emacs mode that you configure with

```elisp
(use-package elpy
  :ensure t
  :init
  (elpy-enable))
```

and that sets up the basic stuff for you is amazing. Elpy showed me tools like [flake8](https://flake8.pycqa.org/en/latest/) and [black](https://black.readthedocs.io/en/stable/).

Lately, elpy had some issues finding installed Python packages. Also syntax and error checking worked on and off.

My main complaint, however, is a conceptual one. I disagree with elpy's default choice to create a global virtualenv for developer packages like linters and formatters. There is a way to configure elpy to use the local project virtualenv, but then it does not seem to work if there is no local virtualenv at all. I would like to have control over the version of the packages I use. Unfortunately this is not what elpy expects.

These points made me have a glance over the fence to check what else is out there. Googling _python emacs reddit_ brought up some good discussions between real people talking about Emacs as Python IDE. I quickly stumbled upon anaconda-mode.

I learned that both [prelude-mode](https://github.com/bbatsov/prelude) and [Spacemacs](https://www.spacemacs.org/) are using anaconda-mode as their default Python mode. That was quite surprising, I assumed that elpy was the most popular Python mode (and de-facto standard) based on GitHub stars.

On a second thought, it makes sense for Emacs distributions to use a set of focused packaged instead of a god package like elpy. The distributions themselves aim to offer a user experience on the similar level to elpy.

Thanks to elpy I learned what I can (and should) expect from a minimal Python IDE. I was finally ready to get out there and pick and choose packages myself.

Years ago elpy allowed me to quickly jump into a data science gig and it made me productive from day one. I still recommend elpy or full-blown Emacs distributions to beginners for this reason.


## Configuration {#configuration}

I don't use a pre-configured Emacs distribution. Instead, I maintain `~/.emacs.d/init.el` myself. It is a bit more work to set things up correctly, but I understand my setup reasonable well and I am quite confident that I can fix things if they go wrong.

This is essentially my custom Python layer that supports

-   auto-complete
-   documentation lookup
-   finding definitions
-   finding usages
-   formatting buffers
-   local virtualenv
-   highlighting indentation

and probably even more.

I omitted the configuration of generic packages such as company or flycheck.

```elisp
(use-package python-black
  :ensure t
  :bind (("C-c b" . python-black-buffer)))

(use-package pyvenv
  :ensure t
  :config
  (pyvenv-mode 1))

(use-package anaconda-mode
  :ensure t
  :bind (("C-c C-x" . next-error))
  :config
  (require 'pyvenv)
  (add-hook 'python-mode-hook 'anaconda-mode))

(use-package company-anaconda
  :ensure t
  :config
  (eval-after-load "company"
   '(add-to-list 'company-backends '(company-anaconda :with company-capf))))

(use-package highlight-indent-guides
  :ensure t
  :config
  (add-hook 'python-mode-hook 'highlight-indent-guides-mode)
  (setq highlight-indent-guides-method 'character))
```
