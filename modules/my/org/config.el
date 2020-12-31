;;; my/org/config.el -*- lexical-binding: t; -*-

(use-package! valign
  :config
  (after! org
    (add-hook! 'org-mode-hook :append
      (display-line-numbers-mode -1)
      ;; (org-indent-mode -1)
      (valign-mode +1))))

(use-package! org-link-beautify
  :config
  (setq org-link-beautify-thumbnails-dir (concat doom-cache-dir "thumbnails/"))
  (after! org
    (add-hook! 'org-mode-hook #'org-link-beautify-mode)))
