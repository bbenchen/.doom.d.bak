;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

;; (setq warning-minimum-level :error)

(setq user-full-name "Mike Chen"
      user-mail-address "517926804@qq.com"
      epa-file-encrypt-to user-mail-address
      auth-sources '("~/.authinfo.gpg"))

;; (setq default-directory "~/"
;;       org-directory "~/Documents/org"
;;       org-id-locations-file (expand-file-name ".orgids" org-directory)
;;       +org-capture-journal-file (expand-file-name "journal.org" org-directory)
;;       org-agenda-files (list org-directory)
;;       org-roam-directory (expand-file-name "roam" org-directory))

(setq default-directory "~/")

(setq system-time-locale "zh_CN")

(setq confirm-kill-processes nil
      confirm-kill-emacs nil
      x-select-enable-clipboard-manager nil)

;; workspaces
(setq +workspaces-on-switch-project-behavior t)

;; projectile
(after! projectile
  (setq projectile-project-search-path '("~/"))

  (dolist (suffix '(".bak" ".exe"))
    (add-to-list 'projectile-globally-ignored-file-suffixes suffix)))

(if (modulep! :editor file-templates)
    (set-file-template! "/pom\\.xml$" :trigger "__pom.xml" :mode 'nxml-mode))

(after! nxml-mode
  (setq nxml-auto-insert-xml-declaration-flag nil
        nxml-slash-auto-complete-flag nil))

(after! recentf
  (add-to-list 'recentf-exclude "\\.mail")
  (add-to-list 'recentf-exclude "/var")
  (add-to-list 'recentf-exclude "/autosave"))

