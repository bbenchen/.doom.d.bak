;;; my/magit/config.el -*- lexical-binding: t; -*-

;; magit
(after! magit
  (setq magit-revision-show-gravatars nil))

;; magit-todos
(if (executable-find "nice")
    (setq magit-todos-nice t))
(if (executable-find "rg")
    (setq magit-todos-scanner 'magit-todos--scan-with-rg))
