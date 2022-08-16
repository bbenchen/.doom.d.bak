;;; my/web/config.el -*- lexical-binding: t; -*-

(when (modulep! :lang web +lsp)
  (remove-hook! 'web-mode-local-vars-hook #'lsp!)

  (add-hook! 'web-mode-local-vars-hook (when (and (string-match-p "^org-msg" (buffer-name))
                                                  (not (bound-and-true-p org-msg-mode)))
                                         (lsp!))))
