;;; my/chinese/config.el -*- lexical-binding: t; -*-

;; rime
(use-package! rime
  :defer t
  :init
  (setq default-input-method "rime"
        rime-librime-root (if IS-MAC (expand-file-name "librime/dist/" doom-etc-dir))
        rime-user-data-dir (expand-file-name "rime/" doom-etc-dir)
        rime-show-candidate 'posframe
        rime-inline-ascii-trigger 'shift-l
        rime-disable-predicates '(rime-predicate-after-alphabet-char-p
                                  rime-predicate-prog-in-code-p
                                  rime-predicate-ace-window-p
                                  rime-predicate-hydra-p)
        rime-posframe-fixed-position t)
  :config
  (add-hook! '(after-init-hook kill-emacs-hook) :append
    (when (fboundp 'rime-lib-sync-user-data)
      (ignore-errors (rime-sync))))

  (add-hook! 'scala-mode-hook :append
    (add-hook! 'post-command-hook :local
      (if (fboundp 'rime--redisplay)
          (rime--redisplay))))

  (custom-set-faces!
    `(rime-default-face :foreground ,(doom-color 'modeline-fg) :background ,(doom-color 'modeline-bg)))

  (if (fboundp 'rime--posframe-display-content)
      (defadvice! +rime--posframe-display-content-a (args)
        "给 `rime--posframe-display-content' 传入的字符串加一个全角空
格，以解决 `posframe' 偶尔吃字的问题。"
        :filter-args #'rime--posframe-display-content
        (cl-destructuring-bind (content) args
          (let ((newresult (if (string-blank-p content)
                               content
                             (concat content "　"))))
            (list newresult)))))

  (map! (:map rime-mode-map
         (:when IS-MAC
          "M-j" #'rime-force-enable)
         (:unless IS-MAC
          "C-j" #'rime-force-enable)
         "C-`" #'rime-send-keybinding)))

;;; Hacks
(defadvice! +chinese--org-html-paragraph-a (args)
  "Join consecutive Chinese lines into a single long line without unwanted space
when exporting org-mode to html."
  :filter-args #'org-html-paragraph
  (++chinese--org-paragraph args))

(defadvice! +chinese--org-hugo-paragraph-a (args)
  "Join consecutive Chinese lines into a single long line without
unwanted space when exporting org-mode to hugo markdown."
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
