;;; my/translate/config.el -*- lexical-binding: t; -*-

(use-package! youdao-dictionary
  :defer t
  :init
  (map! :leader
        (:prefix-map ("y" . "translate")
         :desc "Search at point"     "s" #'youdao-dictionary-search-at-point-posframe
         :desc "Search from input"   "S" #'youdao-dictionary-search-from-input
         :desc "Play voice at point" "p" #'youdao-dictionary-play-voice-at-point))
  :config
  (set-popup-rule! "^\\*Youdao Dictionary\\*" :side 'bottom :size 0.3 :select t)
  (after! auth-source
    (let ((credentials (auth-source-user-and-password "openapi.youdao.com")))
      (setq youdao-dictionary-app-key (car credentials)
            youdao-dictionary-secret-key (cadr credentials))))

  (setq url-automatic-caching t
        ;; Set file path for saving search history
        youdao-dictionary-search-history-file (concat doom-cache-dir "youdao")
        ;; Enable Chinese word segmentation support
        youdao-dictionary-use-chinese-word-segmentation t)

  (defadvice! +youdao-dictionary--posframe-tip-a (string)
    "Show STRING using posframe-show."
    :override #'youdao-dictionary--posframe-tip
    (let ((word (youdao-dictionary--region-or-word)))
      (if word
          (progn
            (with-current-buffer (get-buffer-create youdao-dictionary-buffer-name)
              (let ((inhibit-read-only t))
                (erase-buffer)
                (youdao-dictionary-mode)
                (insert string)
                (goto-char (point-min))
                (set (make-local-variable 'youdao-dictionary-current-buffer-word) word)))
            (posframe-show youdao-dictionary-buffer-name
                           :background-color (face-background 'mode-line)
                           :foreground-color (face-foreground 'mode-line)
                           :internal-border-width 10)
            (unwind-protect
                (push (read-event) unread-command-events)
              (progn
                (posframe-delete youdao-dictionary-buffer-name)
                (other-frame 0))))
        (message "Nothing to look up")))))

;; company-english-helper
(use-package! company-english-helper
  :defer t
  :commands toggle-company-english-helper
  :init
  (map! :leader
        (:prefix-map ("y" . "translate")
         :desc "Toggle company english" "t" #'toggle-company-english-helper)))

;; insert-translated-name
(use-package! insert-translated-name
  :init
  (map! :leader
        (:prefix-map ("y" . "translate")
         :desc "Insert translated name" "i" #'insert-translated-name-insert))
  :config
  (setq insert-translated-name-default-style 'origin))

(use-package! english-teacher
  :defer t
  :hook ((Info-mode
          helpful-mode
          Man-mode
          Woman-mode) . english-teacher-follow-mode)
  :config
  (setq english-teacher-backend 'google))
