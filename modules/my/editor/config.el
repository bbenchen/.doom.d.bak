;;; my/multiple-cursors/config.el -*- lexical-binding: t; -*-

;; iedit
(setq iedit-toggle-key-default nil)

;; multiple-cursors
(after! multiple-cursors-core
  (add-to-list 'mc/cmds-to-run-once 'counsel-M-x)
  (add-to-list 'mc/cmds-to-run-for-all 'hungry-delete-forward)
  (add-to-list 'mc/cmds-to-run-for-all 'hungry-delete-backward))

;; hungry-delete
(use-package! hungry-delete
  :hook ((prog-mode text-mode conf-mode) . hungry-delete-mode)
  :config
  (setq-default hungry-delete-chars-to-skip " \t\f\v"))
