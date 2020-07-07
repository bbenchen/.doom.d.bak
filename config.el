;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

;; (setq warning-minimum-level :error)

(setq fill-column 120)

(setq user-full-name "Chen Xianbin"
      user-mail-address "517926804@qq.com"
      epa-file-encrypt-to user-mail-address
      auth-sources '("~/.authinfo.gpg"))

(add-hook! 'emacs-startup-hook (setq default-directory "~/"
                                     org-directory "~/Documents/org"))

;; display line number
(setq display-line-numbers-type 'relative)

;; fonts
(when (and IS-LINUX (display-graphic-p))
  (setq doom-font (font-spec :family "Hack Nerd Font" :size 10)))
(when (and IS-MAC (display-graphic-p))
  (setq doom-font (font-spec :family "Hack Nerd Font" :size 12)))

(when (display-graphic-p)
  ;; no broder
  ;; (set-frame-parameter nil 'undecorated t)
  ;; (add-to-list 'default-frame-alist '(undecorated . t))
  ;; (add-to-list 'default-frame-alist '(fullscreen . maximized))
  (add-hook! 'emacs-startup-hook
             ;; maximized frame
             (toggle-frame-maximized))

  ;; theme
  (pcase (frame-parameter nil 'ns-appearance)
    ('light (setq doom-theme 'doom-one-light))
    (_ (setq doom-theme 'doom-one)))

  (if (and IS-MAC
           (boundp 'ns-system-appearance-change-functions))
      (add-hook! 'ns-system-appearance-change-functions
                 #'(lambda (appearance)
                     (mapc #'disable-theme custom-enabled-themes)
                     (pcase appearance
                       ('light (load-theme 'doom-one-light t))
                       ('dark (load-theme 'doom-one t)))))))

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

  (dolist (suffix '(".bak" ".exe"))
    (add-to-list 'projectile-globally-ignored-file-suffixes suffix)))

;; company
(after! company
  (setq company-idle-delay 1))

;; org
(after! org
  ;; https://manateelazycat.github.io/emacs/2020/04/02/org-font.html
  (defun org-buffer-face-mode-variable ()
    (interactive)
    (when (or IS-LINUX IS-MAC)
      (make-face 'width-font-face)
      (if IS-LINUX
          (set-face-attribute 'width-font-face nil :font "Sarasa Mono SC 10")
        (set-face-attribute 'width-font-face nil :font "Sarasa Mono SC 12"))
      (setq buffer-face-mode-face 'width-font-face)
      (buffer-face-mode)))

  (add-hook! 'org-mode-hook #'org-buffer-face-mode-variable))
