+++
title = "Reloading Flycheck After Loading Virtualenv"
author = ["Josef Erben"]
date = 2022-01-11
tags = ["emacs", "python"]
draft = false
+++

When I open Emacs to edit a Python project, the first command I run is `pyvenv-activate` to activate the virtualenv.

If I have a Python file open of that project before running `pyvenv-activate`, flycheck won't work because I install my development dependencies (which are needed by the checkers) in the local virtualenv.

Luckily [pyvenv](https://github.com/jorgenschaefer/pyvenv) provides a hook that runs whenever a virtualenv was activated.

```elisp
(defun clear-flycheck-auto-disabled-checkers ()
  "Clears any automatically disabled flycheck checkers."
  (setq flycheck--automatically-disabled-checkers nil)
  (message "Cleared all disabled flycheck checkers")
  (flycheck-mode)
  (flycheck-mode))
(setq pyvenv-post-activate-hooks
  (list (lambda () (clear-flycheck-auto-disabled-checkers))))
```