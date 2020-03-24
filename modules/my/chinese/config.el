;;; my/chinese/config.el -*- lexical-binding: t; -*-

;; rime
(use-package! rime
  :defer t
  :custom
  (default-input-method "rime")
  (rime-librime-root (if IS-MAC (expand-file-name "librime/dist/" doom-etc-dir)))
  (rime-user-data-dir (expand-file-name "rime/" doom-etc-dir))
  (rime-show-candidate (if (featurep! +childframe) 'posframe))
  (rime-inline-ascii-trigger 'control-l)
  (rime-disable-predicates '(rime-predicate-prog-in-code-p))
  :hook
  ('after-init . (lambda ()
                   (when (fboundp 'rime-lib-sync-user-data)
                     (ignore-errors (rime-sync)))))
  ('kill-emacs . (lambda ()
                   (when (fboundp 'rime-lib-sync-user-data)
                     (ignore-errors (rime-sync)))))
  :config
  (setq rime-posframe-properties
        (list :background-color (face-attribute 'default :background nil t)
              :foreground-color (face-attribute 'default :foreground nil t)
              :internal-border-width 10))

  (unless (fboundp 'rime--posframe-display-content)
    (error "Function `rime--posframe-display-content' is not available."))

  (defadvice! +rime--posframe-display-content-a (args)
    "给 `rime--posframe-display-content' 传入的字符串加一个全角空
格，以解决 `posframe' 偶尔吃字的问题。"
    :filter-args #'rime--posframe-display-content
    (cl-destructuring-bind (content) args
      (let ((newresult (if (string-blank-p content)
                           content
                         (concat content "　"))))
        (list newresult)))))

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
