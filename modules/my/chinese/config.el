;;; my/chinese/config.el -*- lexical-binding: t; -*-

;; liberime
(cond (IS-MAC
       (setq liberime-shared-data-dir (file-truename "~/Library/Rime")))
      (IS-LINUX
       (cond ((file-exists-p! "~/.config/ibus/rime")
              (setq liberime-shared-data-dir (file-truename "~/.config/ibus/rmie")))
             ((file-exists-p! "~/.config/fcitx/rime")
              (setq liberime-shared-data-dir (file-truename "~/.config/fcitx/rmie"))))))
(setq liberime-user-data-dir (expand-file-name "rime/" doom-etc-dir))
(use-package! liberime
  :defer 1
  :init
  (add-hook! 'liberime-after-start-hook
    (run-with-timer
     2 nil
     'liberime-select-schema "wubi86_jidian_pinyin")))

;; pyim
(use-package! pyim
  :after liberime                       ;
  :after-call after-find-file pre-command-hook
  :config
  (setq pyim-dcache-directory (expand-file-name "pyim/" doom-cache-dir)
        pyim-dcache-backend 'pyim-dregcache
        default-input-method "pyim"
        pyim-default-scheme 'rime
        pyim-page-length 9)
  (when (featurep! +childframe)
    (setq pyim-page-tooltip 'posframe))
  (setq-default pyim-english-input-switch-functions
                '(pyim-probe-org-speed-commands
                  pyim-probe-org-structure-template))
  (setq-default pyim-punctuation-half-width-functions
                '(pyim-probe-punctuation-line-beginning
                  pyim-probe-punctuation-after-punctuation)))

;;; Hacks
(defadvice! +chinese--org-html-paragraph-a (args)
  "Join consecutive Chinese lines into a single long line without unwanted space
when exporting org-mode to html."
  :filter-args #'org-html-paragraph
  (++chinese--org-paragraph args))

(defadvice! +chinese--org-hugo-paragraph-a (args)
  "Join consecutive Chinese lines into a single long line without unwanted space
when exporting org-mode to html."
  :filter-args #'org-hugo-paragraph
  (++chinese--org-paragraph args))

(defun ++chinese--org-paragraph (args)
  (cl-destructuring-bind (paragraph contents info) args
    (let* ((fix-regexp "[[:multibyte:]]")
           (origin-contents
            (replace-regexp-in-string
             "<[Bb][Rr] */>"
             ""
             contents))
           (fixed-contents
            (replace-regexp-in-string
             (concat "\\(" fix-regexp "\\) *\n *\\(" fix-regexp "\\)")
             "\\1\\2"
             origin-contents)))
      (list paragraph fixed-contents info))))
