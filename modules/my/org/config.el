;;; my/org/config.el -*- lexical-binding: t; -*-

(use-package! valign
  :config
  (after! org
    (add-hook! 'org-mode-hook :append
      (display-line-numbers-mode -1)
      ;; (org-indent-mode -1)
      (valign-mode +1))))
