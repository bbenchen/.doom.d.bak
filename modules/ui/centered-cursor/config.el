;;; ui/centered-cursor/packages.el -*- lexical-binding: t; -*-

(use-package! centered-cursor-mode
  :commands (centered-cursor-mode
             global-centered-cursor-mode)
  :config
  (setq ccm-recenter-at-end-of-file t))

(map! :leader
      :desc "Centered point" "-" #'centered-cursor-mode)
