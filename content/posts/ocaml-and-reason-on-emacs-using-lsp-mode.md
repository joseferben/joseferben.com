+++
title = "OCaml and Reason on Emacs using lsp-mode"
author = ["Josef Erben"]
date = 2022-05-26
tags = ["emacs", "ocaml"]
draft = false
+++

This year I started consolidating all the major modes by using `lsp-mode` and `apheleia` for all the programming language I use. The switch from OCaml's `merlin-mode` was surprisingly painless.

<!--more-->

Let's start with the default major modes that provide syntax highlighting and a few other things. I have `tuareg` for OCaml, `dune-format` to format dune files and `reason-mode` for ReasonML.

```elisp
(use-package tuareg
  :ensure t
  :custom
  (tuareg-opam-insinuate t)
  :config)

(use-package dune-format
  :ensure t)

(use-package reason-mode
  :ensure t)
```

My `lsp-mode` setup is the same for every language so I get a consistent experience. I am using `ocamllsp` as the LSP server implementation, this is the one that the official VS Code extension uses as well.

```elisp
(defun my-lsp-fix-buffer ()
  "Formats buffer and organizes imports."
  (interactive)
  (lsp-organize-imports)
  (lsp-format-buffer))

(use-package lsp-mode
  :ensure t
  :after flycheck
  :commands lsp
  :bind (("C-c l n" . flycheck-next-error)
         ("C-c l d" . lsp-find-definition)
         ("C-c l r" . lsp-find-references)
         ("C-c l h" . lsp-describe-thing-at-point)
         ("C-c l i" . lsp-find-implementation)
         ("C-c l R" . lsp-rename)
         ("C-c l o" . my-lsp-fix-buffer))
  :hook ((tuareg-mode . lsp)
         (caml-mode . lsp)
         (reason-mode . lsp)
         (before-save . lsp-organize-imports))
  :custom
  (lsp-lens-enable t)
  (lsp-log-io nil)
  (lsp-headerline-breadcrumb-enable nil)
  :config
  (lsp-enable-which-key-integration t)
  (lsp-register-client
   (make-lsp-client
    :new-connection (lsp-stdio-connection
                     '("opam" "exec" "--" "ocamllsp"))
    :major-modes '(caml-mode tuareg-mode reason-mode)
    :server-id 'ocamllsp)))
```

For my formatting needs I use the outstanding `apheleia` package. This package is great, especially for slow formatters. With `ocamlformat` you won't get all the benefits because it's quite fast.

`Apheleia` runs the formatting on a buffer in the background and [patches](https://tools.ietf.org/doc/tcllib/html/rcs.html#section4) the current buffer asynchronously. The cursor remains at the same location in the code, which makes it easy to keep track of what is going on.

```elisp
(use-package apheleia
  :ensure t
  :hook
  (caml-mode . apheleia-mode)
  (tuareg-mode . apheleia-mode)
  (reason-mode . apheleia-mode)
  :config
  (setf (alist-get 'ocamlformat apheleia-formatters)
        '("opam" "exec" "--" "ocamlformat" "--impl" "-"))
  (setf (alist-get 'refmt apheleia-formatters)
        '("opam" "exec" "--" "refmt"))
  (setf (alist-get 'tuareg-mode apheleia-mode-alist)
        '(ocamlformat))
  (setf (alist-get 'reason-mode apheleia-mode-alist)
        '(refmt)))
```

I don't use `lsp-ui`, `lsp-mode` on its own does the trick combined with `apheleia`.