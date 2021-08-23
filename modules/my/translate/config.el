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
  (set-popup-rule! "^\\*Youdao Dictionary\\*" :side 'right :size 0.4 :select t)

  (after! auth-source
    (let ((credentials (auth-source-user-and-password "openapi.youdao.com")))
      (setq youdao-dictionary-app-key (car credentials)
            youdao-dictionary-secret-key (cadr credentials))))

  (setq url-automatic-caching t
        ;; Set file path for saving search history
        youdao-dictionary-search-history-file (concat doom-cache-dir "youdao")
        ;; Enable Chinese word segmentation support
        youdao-dictionary-use-chinese-word-segmentation t)

  (defvar youdao-translate-tooltip-name "*youdao-translate-posframe*"
    "The name of youdao translate tooltip name.")

  (defvar youdao-dictionary-tooltip-last-point 0
    "Hold last point when show tooltip, use for hide tooltip after move point.")

  (defvar youdao-dictionary-tooltip-last-scroll-offset 0
    "Hold last scroll offset when show tooltip, use for hide tooltip after window scroll.")

  (defun youdao-dictionary-hide-tooltip-after-move ()
    (ignore-errors
      (when (get-buffer youdao-translate-tooltip-name)
        (unless (and
                 (equal (point) youdao-dictionary-tooltip-last-point)
                 (equal (window-start) youdao-dictionary-tooltip-last-scroll-offset))
          (posframe-delete youdao-translate-tooltip-name)
          (kill-buffer youdao-translate-tooltip-name)))))

  (defadvice! +youdao-dictionary--posframe-tip-a (text)
    "Show STRING using posframe-show."
    :override #'youdao-dictionary--posframe-tip
    (let ((word (youdao-dictionary--region-or-word)))
      (if word
          (progn
            (posframe-show youdao-translate-tooltip-name
                           :string text
                           :position (point)
                           :timeout 30
                           :background-color (face-background 'mode-line)
                           :foreground-color (face-foreground 'mode-line)
                           :internal-border-width 10)
            (add-hook 'post-command-hook 'youdao-dictionary-hide-tooltip-after-move)
            (setq youdao-dictionary-tooltip-last-point (point))
            (setq youdao-dictionary-tooltip-last-scroll-offset (window-start)))
        (message "Nothing to look up")))))

;; google-translate
(use-package! google-translate
  :defer t
  :commands (google-translate-chinese-at-point++
             google-translate-chinese-at-point)
  :init
  (setq google-translate--tkk-url "https://translate.google.cn/"
        google-translate-base-url "https://translate.google.cn/translate_a/single"
        google-translate-listen-url "https://translate.google.cn/translate_tts"
        ;; google-translate-backend-method 'curl
        google-translate-default-source-language "en"
        google-translate-default-target-language "zh-CN")

  (map! :leader
        :prefix ("y" . "translate")
        "g" #'google-translate-chinese-at-point++
        "G" #'google-translate-chinese-at-point)
  :config
  (setq url-automatic-caching t
        google-translate-listen-program (executable-find "mpv"))

  (defun google-translate--get-b-d1 ()
    ;; TKK='427110.1469889687'
    (list 427110 1477889687))

  (set-popup-rule! "^\\*Google Translate\\*" :side 'right :size 0.4 :select t)

  (defcustom google-translate-tooltip-name "*google-translate-posframe*"
    "The name of google translate tooltip name."
    :type 'string
    :group 'google-translate)

  (defvar google-translate-tooltip-last-point 0
    "Hold last point when show tooltip, use for hide tooltip after move point.")

  (defvar google-translate-tooltip-last-scroll-offset 0
    "Hold last scroll offset when show tooltip, use for hide tooltip after window scroll.")

  (defun google-translate-hide-tooltip-after-move ()
    (ignore-errors
      (when (get-buffer google-translate-tooltip-name)
        (unless (and
                 (equal (point) google-translate-tooltip-last-point)
                 (equal (window-start) google-translate-tooltip-last-scroll-offset))
          (posframe-delete google-translate-tooltip-name)
          (kill-buffer google-translate-tooltip-name)))))

  (defun google-translate-show-posframe-tooltip (text)
    "Show string on posframe buffer."
    ;; Show tooltip at point if word fetch from user cursor.
    (unless (and (require 'posframe nil t) (posframe-workable-p))
      (error "Posframe not workable"))
    (posframe-show google-translate-tooltip-name
                   :string text
                   :position (point)
                   :timeout 30
                   :background-color (face-background 'mode-line)
                   :foreground-color (face-foreground 'mode-line)
                   :internal-border-width 10)
    (add-hook 'post-command-hook 'google-translate-hide-tooltip-after-move)
    (setq google-translate-tooltip-last-point (point))
    (setq google-translate-tooltip-last-scroll-offset (window-start)))

  (defun -region-or-word ()
    (if (use-region-p)
        (buffer-substring-no-properties (region-beginning) (region-end))
      (thing-at-point 'word t)))

  (defun -chinese-word-p (word)
    (if (and word (string-match "\\cc" word)) t nil))

  (defun -translate-request (source-language target-language text)
    (let* ((json (google-translate-request source-language
                                           target-language
                                           text)))
      (if (null json)
          (message "Nothing to translate.")
        (let* ((detailed-translation
                (google-translate-json-detailed-translation json))
               (detailed-definition
                (google-translate-json-detailed-definition json))
               (gtos
                (make-gtos
                 :source-language source-language
                 :target-language target-language
                 :auto-detected-language (aref json 2)
                 :text text
                 :text-phonetic (google-translate-json-text-phonetic json)
                 :translation (google-translate-json-translation json)
                 :translation-phonetic (google-translate-json-translation-phonetic json)
                 :detailed-translation detailed-translation
                 :detailed-definition detailed-definition
                 :suggestion (when (null detailed-translation)
                               (google-translate-json-suggestion json)))))
          (google-translate-posframe-output-translation gtos)))))

  (defun google-translate-posframe-output-translation (gtos)
    "Output translation to the popup tooltip using `popup' package."
    (google-translate-show-posframe-tooltip
     (with-temp-buffer
       (google-translate-buffer-insert-translation gtos)
       (google-translate--trim-string
        (buffer-substring (point-min) (point-max))))))

  (defun %google-translate-at-point++ (override-p reverse-p)
    (let* ((langs (google-translate-read-args override-p reverse-p))
           (source-language (car langs))
           (target-language (cadr langs))
           (bounds nil))
      (-translate-request
       source-language target-language
       (if (use-region-p)
           (buffer-substring-no-properties (region-beginning) (region-end))
         (or (and (setq bounds (bounds-of-thing-at-point 'word))
                  (buffer-substring-no-properties (car bounds) (cdr bounds)))
             (error "No word at point."))))))

  (defun google-translate-at-point++ (&optional override-p)
    "Translate at point and show result with posframe."
    (interactive "P")
    (%google-translate-at-point++ override-p nil))

  (defun google-translate-at-point-reverse++ (&optional override-p)
    "Translate reverse at point and show result with posframe."
    (interactive "P")
    (%google-translate-at-point++ override-p t))

  (defun google-translate-chinese-at-point++ (&optional override-p)
    "如果当前位置是中文，则自动调用反向进行中转英翻译，否则进行正向
英转中翻译。并在posframe提示框里显示结果。此方法只能用于点词翻译，
不能用于划词翻译，至于原因，我还没弄明白。"
    (interactive "P")
    (if (-chinese-word-p(-region-or-word))
        (%google-translate-at-point++ override-p t)
      (%google-translate-at-point++ override-p nil)))

  (defun google-translate-chinese-at-point (&optional override-p)
    "如果当前位置是中文，则自动调用反向进行中转英翻译，否则进行正向
英转中翻译。并在另一个buffer里显示结果。此方法既可用于点词翻译，
也可用于划词翻译。"
    (interactive "P")
    (if (-chinese-word-p(-region-or-word))
        (%google-translate-at-point override-p t)
      (%google-translate-at-point override-p nil))))

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


