;;; my/sql/config.el -*- lexical-binding: t; -*-

;; sql
(after! sql
  (setq sql-product 'mysql)

  (if (featurep! :checkers syntax)
    (add-hook! '(sql-mode-hook sql-interactive-mode-hook) :append
      (defun sql-disable-flycheck()
        "Disable `flycheck' for the current buffer."
        (flycheck-mode -1)))))

(use-package! sqlup-mode
  :defer t
  :init
  (add-hook! '(sql-mode-hook sql-interactive-mode-hook) :append #'sqlup-mode)
  :config
  (setq sqlup-blacklist (append sqlup-blacklist '("name" "user"))))

(use-package! sql-indent
  :defer t
  :init
  (add-hook! 'sql-mode-hook :append #'sqlind-minor-mode))

(use-package! ob-sql-mode)
