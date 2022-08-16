;;; my/sql/config.el -*- lexical-binding: t; -*-

;; sql
(after! sql
  (setq sql-product 'mysql)

  ;; (if (modulep! :checkers syntax)
  ;;   (add-hook! '(sql-mode-hook sql-interactive-mode-hook) :append
  ;;     (defun sql-disable-flycheck()
  ;;       "Disable `flycheck' for the current buffer."
  ;;       (flycheck-mode -1))))
  )

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

(use-package! ejc-sql
  :defer t
  :commands ejc-sql-mode ejc-connect
  :init
  (add-hook! sql-mode :append #'ejc-sql-mode)
  :config
  (setq clomacs-httpd-default-port 18090
        ejc-completion-system 'standard
        ejc-temp-editor-file-path (expand-file-name "ejc-sql/" doom-cache-dir)
        ejc-jdbc-drivers '("sqlite"     [org.xerial/sqlite-jdbc "3.23.1"]
                           "h2"         [com.h2database/h2 "1.4.199"]
                           "mysql"      [mysql/mysql-connector-java "8.0.28"]
                           "postgresql" [postgresql/postgresql "9.3-1102.jdbc41"]
                           "sqlserver"  [com.microsoft.sqlserver/mssql-jdbc "6.2.2.jre8"]
                           "oracle"     [com.oracle.database.jdbc/ojdbc8 "19.14.0.0"])))
