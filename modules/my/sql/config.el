;;; my/sql/config.el -*- lexical-binding: t; -*-

;; sql
(after! sql
  (setq sql-product 'mysql))

(use-package! sqlup-mode
  :defer t
  :init
  (add-hook! '(sql-mode-hook sql-interactive-mode-hook) :append #'sqlup-mode)
  :config
  (setq sqlup-blacklist (append sqlup-blacklist '("name" "user"))))

(after! flycheck
  (add-hook! 'sql-mode-hook
    (defun sql-disable-flycheck ()
      "Disable `flycheck' for the current buffer."
      (flycheck-mode -1))))
