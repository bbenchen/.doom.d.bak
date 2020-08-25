;;; my/tools/config.el -*- lexical-binding: t; -*-

;; exec-path-from-shell
(use-package! exec-path-from-shell
  :init
  (when (or IS-LINUX IS-MAC)
    (setq exec-path-from-shell-check-startup-files nil)
    (setq exec-path-from-shell-arguments '("-l"))
    (setq exec-path-from-shell-variables '("LANG" "LC_ALL" "TERM" "PATH" "MANPATH"))
    (exec-path-from-shell-initialize)))

(use-package! command-log-mode
  :commands global-command-log-mode
  :config
  (setq command-log-mode-auto-show t))
