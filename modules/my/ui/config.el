;;; my/tools/config.el -*- lexical-binding: t; -*-

(setq-default fill-column 120)

;; display line number
(setq display-line-numbers-type 'relative)

(use-cjk-char-width-table 'zh_CN)

(when (display-graphic-p)
  ;; fonts
  (let ((font "Sarasa Mono SC Nerd"))
    (cond (IS-LINUX (setq doom-font (font-spec :family font :size 11)
                          doom-variable-pitch-font doom-font))
          (IS-MAC (setq doom-font (font-spec :family font :size (if (> (display-pixel-width) 1920) 14 12))
                        doom-variable-pitch-font doom-font)))
    (add-hook! 'after-setting-font-hook :append
      (set-fontset-font t 'cjk-misc font nil 'prepend)
      (set-fontset-font t 'han font nil 'prepend)))

  (if (featurep! :ui zen)
      (setq writeroom-width 120
            +zen-text-scale 1))

  ;; no broder
  ;; (set-frame-parameter nil 'undecorated t)
  ;; (add-to-list 'initial-frame-alist '(undecorated . t))

  ;; transparency
  ;; (set-frame-parameter nil 'alpha 85)

  ;; maximize the window
  (add-to-list 'initial-frame-alist '(fullscreen . maximized))

  ;; (when (and (> (length (display-monitor-attributes-list)) 1)
  ;;            (> (display-pixel-width) 1920))
  ;;   (set-frame-parameter nil 'left -3840))

  (cond (IS-MAC (pcase (frame-parameter nil 'ns-appearance)
                  ('light (setq doom-theme 'doom-nord-light))
                  (_ (setq doom-theme 'doom-nord)))
                (if (boundp 'ns-system-appearance-change-functions)
                    (add-hook! 'ns-system-appearance-change-functions
                               #'(lambda (appearance)
                                   (mapc #'disable-theme custom-enabled-themes)
                                   (pcase appearance
                                     ('light (load-theme 'doom-nord-light t))
                                     ('dark (load-theme 'doom-nord t)))))))
        (t (setq doom-theme 'doom-nord)))

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
  )

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
        doom-modeline-buffer-file-name-style 'truncate-with-project))

;; centered-cursor
(use-package! centered-cursor-mode
  :commands (centered-cursor-mode
             global-centered-cursor-mode)
  :init
  (map! :leader
        :desc "Centered point" "C--" #'centered-cursor-mode)
  :config
  (setq ccm-recenter-at-end-of-file t))
