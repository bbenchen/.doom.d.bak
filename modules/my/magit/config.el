;;; my/magit/config.el -*- lexical-binding: t; -*-

;; magit
(after! magit
  (setq magit-revision-show-gravatars nil))

(after! git-commit
  (if (featurep! :checkers spell +flyspell)
      (remove-hook! 'git-commit-mode-hook #'flyspell-mode)))

;; magit-todos
(if (executable-find "nice")
    (setq magit-todos-nice t))
(if (executable-find "rg")
    (setq magit-todos-scanner 'magit-todos--scan-with-rg))

;; magit-svn
(use-package! magit-svn
  :when (and (executable-find "svn")
             (executable-find "git-svn"))
  :after magit
  :config
  (add-hook! 'magit-mode-hook #'magit-svn-mode))

(use-package! blamer
  :defer 5
  :custom
  (blamer-idle-time 0.5)
  (blamer-min-offset 70)
  :config
  (custom-set-faces!
    `(blamer-face :foreground "#7a88cf" :background nil :italic t)))
