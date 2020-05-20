;;; my/translate/config.el -*- lexical-binding: t; -*-

(use-package! youdao-dictionary
  :defer t
  :init
  (map! :leader
        (:prefix-map ("y" . "translate")
          :desc "Search at point"     "s" (if (featurep! +childframe)
                                              #'youdao-dictionary-search-at-point-posframe
                                            #'youdao-dictionary-search-at-point-tooltip)
          :desc "Search from input"   "S" #'youdao-dictionary-search-from-input
          :desc "Play voice at point" "p" #'youdao-dictionary-play-voice-at-point))
  :config
  (set-popup-rule! "^\\*Youdao Dictionary\\*" :side 'bottom :size 0.3 :select t)
  (let ((credentials (auth-source-user-and-password "openapi.youdao.com")))
    (setq youdao-dictionary-app-key (car credentials)
          youdao-dictionary-secret-key (cadr credentials)))
  (setq url-automatic-caching t
        ;; Set file path for saving search history
        youdao-dictionary-search-history-file (concat doom-cache-dir "youdao")
        ;; Enable Chinese word segmentation support
        youdao-dictionary-use-chinese-word-segmentation t)

  (when (featurep! +childframe)
    (defadvice! +youdao-dictionary--posframe-tip (string)
      "Show STRING using posframe-show."
      :override #'youdao-dictionary--posframe-tip
      (let ((word (youdao-dictionary--region-or-word)))
        (if word
            (progn
              (with-current-buffer (get-buffer-create youdao-dictionary-buffer-name)
                (let ((inhibit-read-only t))
                  (erase-buffer)
                  (youdao-dictionary-mode)
                  (insert (youdao-dictionary--format-result word))
                  (goto-char (point-min))
                  (set (make-local-variable 'current-buffer-word) word)))
              (posframe-show youdao-dictionary-buffer-name
                             :background-color (face-background 'mode-line)
                             :foreground-color (face-foreground 'mode-line)
                             :internal-border-width 10)
              (unwind-protect
                  (push (read-event) unread-command-events)
                (posframe-delete youdao-dictionary-buffer-name)))
          (message "Nothing to look up"))))))

;; company-english-helper
(use-package! company-english-helper
  :commands toggle-company-english-helper
  :init
  (map! :leader
        (:prefix-map ("y" . "translate")
          :desc "Toggle company english" "t" #'toggle-company-english-helper)))

;; insert-translated-name
(use-package! insert-translated-name
  :custom
  (insert-translated-name-default-style 'origin)
  :init
  (map! :leader
        (:prefix-map ("y" . "translate")
          :desc "Insert translated name" "i" #'insert-translated-name-insert)))
