;;; my/magit/config.el -*- lexical-binding: t; -*-

;; magit
(after! magit
  (setq magit-revision-show-gravatars nil))

;; magit-todos
(if (executable-find "nice")
    (setq magit-todos-nice t))
(if (executable-find "rg")
    (setq magit-todos-scanner 'magit-todos--scan-with-rg))

;; magit-svn
(use-package! magit-svn
  :when (executable-find "svn")
  :after magit
  :config
  (add-hook! 'magit-mode-hook #'magit-svn-mode))
