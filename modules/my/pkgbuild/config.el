;;; my/pkgbuild/config.el -*- lexical-binding: t; -*-

(use-package! pkgbuild-mode
  :defer t
  :init
  (setq pkgbuild-update-sums-on-save nil)
  :config
  (add-hook! 'pkgbuild-mode-hook
    (setq mode-name "PKGBUILD"
      mode-line-process nil)))
