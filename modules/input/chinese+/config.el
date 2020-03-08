;;; input/chinese+/config.el -*- lexical-binding: t; -*-

(use-package! pyim
  :after liberime                       ;
  :after-call after-find-file pre-command-hook
  :config
  (setq pyim-dcache-directory (expand-file-name "pyim/" doom-cache-dir)
        pyim-dcache-backend 'pyim-dregcache
        default-input-method "pyim"
        pyim-default-scheme 'rime
        pyim-page-length 9
        pyim-page-tooltip 'posframe)
  (setq-default pyim-english-input-switch-functions
                '(pyim-probe-program-mode
                  pyim-probe-org-speed-commands
                  pyim-probe-org-structure-template)))

;; liberime
(setq liberime-user-data-dir (expand-file-name "rime/" doom-private-dir))
(use-package! liberime
  :defer 1
  :init
  (add-hook 'liberime-after-start-hook #'(lambda ()
                                           (liberime-select-schema "wubi86_jidian_pinyin"))))

;;; Hacks
(defadvice! +chinese--org-html-paragraph-a (args)
  "Join consecutive Chinese lines into a single long line without unwanted space
when exporting org-mode to html."
  :filter-args #'org-html-paragraph
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
