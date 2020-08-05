;;; my/tools/config.el -*- lexical-binding: t; -*-

;; centered-cursor
(use-package! centered-cursor-mode
  :commands (centered-cursor-mode
             global-centered-cursor-mode)
  :init
  (map! :leader
        :desc "Centered point" "C--" #'centered-cursor-mode)
  :config
  (setq ccm-recenter-at-end-of-file t))

;; modeline
(after! doom-modeline
  (setq doom-modeline-major-mode-icon t
        doom-modeline-persp-name t
        doom-modeline-enable-word-count t
        doom-modeline-indent-info t))

;; treemacs
(after! treemacs
  (setq treemacs-show-cursor IS-MAC))
