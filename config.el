;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

;; (setq warning-minimum-level :error)

(setq user-full-name "Chen Xianbin"
      user-mail-address "517926804@qq.com"
      epa-file-encrypt-to user-mail-address
      auth-sources '("~/.authinfo.gpg"))

(add-hook! 'emacs-startup-hook (setq default-directory "~/"
                                     org-directory "~/Documents/org"))

(setq x-select-enable-clipboard-manager nil)

;; workspaces
(setq +workspaces-on-switch-project-behavior t)

;; projectile
(after! projectile
  (setq projectile-project-search-path '("~/")
        projectile-files-cache-expire 3600)

  (dolist (suffix '(".bak" ".exe"))
    (add-to-list 'projectile-globally-ignored-file-suffixes suffix)))

