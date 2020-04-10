;;; my/tools/config.el -*- lexical-binding: t; -*-

;; exec-path-from-shell
(use-package! exec-path-from-shell
  :init
  (when (or IS-LINUX IS-MAC)
    (setq exec-path-from-shell-check-startup-files nil)
    (setq exec-path-from-shell-arguments '("-l"))
    (setq exec-path-from-shell-variables '("TERM" "PATH" "MANPATH"))
    (exec-path-from-shell-initialize)))
