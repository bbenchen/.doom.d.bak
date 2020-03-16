;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

;; (setq warning-minimum-level :error)

(setq fill-column 120)

(setq user-full-name "Chen Xianbin"
      user-mail-address "517926804@qq.com"
      epa-file-encrypt-to user-mail-address)

(setq default-directory "~/"
      org-directory "~/Documents/org")

(when IS-MAC
  (setq module-file-suffix ".so"
        delete-by-moving-to-trash t)
  (if (boundp 'mac-system-move-file-to-trash-use-finder)
      (setq mac-system-move-file-to-trash-use-finder t)))

;; display line number
(setq display-line-numbers-type 'relative)

;; theme
(setq doom-theme 'doom-one)

;; fonts
(when (and IS-LINUX (display-graphic-p))
  (setq doom-font (font-spec :family "Hack Nerd Font" :size 10))
  (setq doom-big-font (font-spec :family "Hack Nerd Font" :size 14))
  (+set-monospaced-font "Hack Nerd Font" "Noto Sans Mono CJK SC" 10 12))
(when (and IS-MAC (display-graphic-p))
  (setq doom-font (font-spec :family "Hack Nerd Font" :size 12))
  (setq doom-big-font (font-spec :family "Hack Nerd Font" :size 16))
  (+set-monospaced-font "Hack Nerd Font" "Hiragino Sans GB" 12 14))

(when (display-graphic-p)
  ;; no broder
  (set-frame-parameter nil 'undecorated t)
  (add-to-list 'default-frame-alist '(undecorated . t))
  (add-to-list 'default-frame-alist '(fullscreen . maximized))
  (add-hook! 'emacs-startup-hook
             ;; maximized frame
             (toggle-frame-maximized)))

;; frame
(add-hook 'after-make-frame-functions #'(lambda (frame)
                                          (when (not (display-graphic-p frame))
                                            (select-frame frame)
                                            (doom/reload-theme))))

;; workspaces
(setq +workspaces-on-switch-project-behavior t)

;; projectile
(after! projectile
  (setq projectile-project-search-path '("~/")
        projectile-files-cache-expire 3600)

  (add-to-list 'projectile-project-root-files-bottom-up ".projectile")

  (dolist (suffix '(".bak" ".exe"))
    (add-to-list 'projectile-globally-ignored-file-suffixes suffix)))

;; company
(after! company
  (setq company-idle-delay 1))
