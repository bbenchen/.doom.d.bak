;;; my/tools/config.el -*- lexical-binding: t; -*-

(setq-default fill-column 120)

;; display line number
(setq display-line-numbers-type 'relative)

(use-cjk-char-width-table 'zh_CN)

;; fonts
(let ((font "Sarasa Mono SC Nerd"))
  (cond (IS-LINUX (setq doom-font (font-spec :family font :size 11 :weight 'Regular)))
        (IS-MAC (setq doom-font (font-spec :family font :size (if (> (display-pixel-width) 1920) 14 12) :weight 'Regular))))
  (setq doom-variable-pitch-font doom-font
        doom-serif-font doom-font
        doom-unicode-font doom-font
        doom-big-font doom-font)
  (add-hook! 'after-setting-font-hook :append
    (set-fontset-font t 'cjk-misc font nil 'prepend)
    (set-fontset-font t 'han font nil 'prepend)))

(if (featurep! :ui zen)
    (setq writeroom-width 120
          +zen-text-scale 1))

;; no broder
(when EMACS29+
  (set-frame-parameter nil 'undecorated t)
  (add-to-list 'default-frame-alist '(undecorated . t)))

;; transparency
(set-frame-parameter nil 'alpha 85)
(add-to-list 'default-frame-alist '(alpha . 85))

;; maximize the window
(when (not EMACS29+)
  (set-frame-parameter nil 'fullscreen 'maximized)
  (add-to-list 'default-frame-alist '(fullscreen . maximized)))

;; (when (and (> (length (display-monitor-attributes-list)) 1)
;;            (> (display-pixel-width) 1920))
;;   (set-frame-parameter nil 'left -3840))

(cond (IS-MAC (pcase (frame-parameter nil 'ns-appearance)
                ('light (setq doom-theme 'doom-nord-light))
                (_ (setq doom-theme 'doom-nord-aurora)))
              (if (boundp 'ns-system-appearance-change-functions)
                  (add-hook! 'ns-system-appearance-change-functions
                             #'(lambda (appearance)
                                 (mapc #'disable-theme custom-enabled-themes)
                                 (pcase appearance
                                   ('light (load-theme 'doom-nord-light t))
                                   ('dark (load-theme 'doom-nord-aurora t)))))))
      (t (setq doom-theme 'doom-nord-aurora)))

;; org
;; (after! org
;;   ;; https://manateelazycat.github.io/emacs/2020/04/02/org-font.html
;;   (defun org-buffer-face-mode-variable ()
;;     (interactive)
;;     (when (or IS-LINUX IS-MAC)
;;       (make-face 'width-font-face)
;;       (if IS-LINUX
;;           (set-face-attribute 'width-font-face nil :font "Sarasa Mono SC Nerd 10")
;;         (set-face-attribute 'width-font-face nil :font "Sarasa Mono SC Nerd 12"))
;;       (setq buffer-face-mode-face 'width-font-face)
;;       (buffer-face-mode)))

;;   (add-hook! 'org-mode-hook #'org-buffer-face-mode-variable))

(if (boundp 'pixel-scroll-precision-mode)
    (pixel-scroll-precision-mode t))

;; frame
(add-hook! 'after-make-frame-functions #'(lambda (frame)
                                           (when (not (display-graphic-p frame))
                                             (select-frame frame)
                                             (doom/reload-theme))))

;; modeline
(after! doom-modeline
  (setq doom-modeline-major-mode-icon t
        doom-modeline-persp-name t
        doom-modeline-enable-word-count t
        doom-modeline-indent-info t
        doom-modeline-buffer-file-name-style 'auto
        doom-modeline-gnus-idle 5
        doom-modeline-support-imenu t)

  (setq all-the-icons-scale-factor 1.1)

  ;；set modeline time format
  (setq display-time-format "%D %R")

  (doom-modeline-def-modeline 'main
    '(bar workspace-name window-number modals matches follow buffer-info remote-host buffer-position word-count parrot selection-info)
    '(objed-state misc-info persp-name battery grip mu4e gnus debug repl lsp minor-modes input-method indent-info buffer-encoding major-mode process vcs checker time "    ")))

;; centered-cursor
(use-package! centered-cursor-mode
  :commands (centered-cursor-mode
             global-centered-cursor-mode)
  :init
  (map! :leader
        :desc "Centered point" "C--" #'centered-cursor-mode)
  :config
  (add-hook! 'prog-mode-hook #'centered-cursor-mode)
  (setq ccm-recenter-at-end-of-file t))
