;;; my/translate/config.el -*- lexical-binding: t; -*-

(use-package! youdao-dictionary
  :defer t
  :init
  (map! :leader
        (:prefix-map ("y" . "youdao")
          :desc "Search at point"     "s" (if (featurep! +childframe)
                                              #'youdao-dictionary-search-at-point-posframe
                                            #'youdao-dictionary-search-at-point-tooltip)
          :desc "Search from input"   "i" #'youdao-dictionary-search-from-input
          :desc "Play voice at point" "p" #'youdao-dictionary-play-voice-at-point))
  :config
  (set-popup-rule! "^\\*Youdao Dictionary\\*" :side 'right :size 0.4 :select t)
  (setq url-automatic-caching t
        ;; Set file path for saving search history
        youdao-dictionary-search-history-file (concat doom-cache-dir "youdao")
        ;; Enable Chinese word segmentation support
        youdao-dictionary-use-chinese-word-segmentation t)

  (when (and (featurep! +childframe)
             (featurep! :completion ivy +childframe))

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
                             :font ivy-posframe-font
                             :background-color (face-attribute 'ivy-posframe :background nil t)
                             :foreground-color (face-attribute 'ivy-posframe :foreground nil t)
                             :internal-border-width ivy-posframe-border-width
                             :internal-border-color (face-attribute 'ivy-posframe-border :background nil t))
              (unwind-protect
                  (push (read-event) unread-command-events)
                (posframe-delete youdao-dictionary-buffer-name)))
          (message "Nothing to look up"))))))

;; company-english-helper
(use-package! company-english-helper
  :commands toggle-company-english-helper)

;; insert-translated-name
(use-package! insert-translated-name
  :config
  (setq insert-translated-name-default-style "origin"))
