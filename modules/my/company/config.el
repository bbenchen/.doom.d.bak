;;; my/company/config.el -*- lexical-binding: t; -*-

(after! prog-mode
  (set-company-backend! 'prog-mode '(:separate company-yasnippet company-capf)))

(after! company
  (setq company-minimum-prefix-length 2
        company-selection-wrap-around t)
  (add-to-list #'company-transformers #'delete-dups))

(after! company-yasnippet
  (defadvice! company-yasnippet-disable-inline-a (fn cmd &optional arg &rest _ignore)
    "Enable yasnippet but disable it inline."
    :around #'company-yasnippet
    (if (eq cmd  'prefix)
        (when-let ((prefix (funcall fn 'prefix)))
          (unless (memq (char-before (- (point) (length prefix)))
                        '(?. ?< ?> ?\( ?\) ?\[ ?{ ?} ?\" ?' ?`))
            prefix))
      (progn
        (when (and (bound-and-true-p lsp-mode)
                   arg (not (get-text-property 0 'yas-annotation-patch arg)))
          (let* ((name (get-text-property 0 'yas-annotation arg))
                 (snip (format "%s (Snippet)" name))
                 (len (length arg)))
            (put-text-property 0 len 'yas-annotation snip arg)
            (put-text-property 0 len 'yas-annotation-patch t arg)))
        (funcall fn cmd  arg)))))
