;;; my/multiple-cursors/config.el -*- lexical-binding: t; -*-

;; iedit
(setq iedit-toggle-key-default nil)

;; multiple-cursors
(after! multiple-cursors-core
  (if (functionp 'counsel-M-x)
      (add-to-list 'mc/cmds-to-run-once 'counsel-M-x))
  (add-to-list 'mc/cmds-to-run-for-all 'hungry-delete-forward)
  (add-to-list 'mc/cmds-to-run-for-all 'hungry-delete-backward))

(after! smartparens
  (unbind-key "M-<left>" smartparens-mode-map)
  (unbind-key "M-<right>" smartparens-mode-map))

;; hungry-delete
(use-package! hungry-delete
  :config
  (add-hook! (prog-mode text-mode conf-mode) #'hungry-delete-mode)
  (setq-default hungry-delete-chars-to-skip " \t\f\v"))
