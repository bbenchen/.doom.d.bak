;;; my/markdown/config.el -*- lexical-binding: t; -*-

(add-hook! 'markdown-mode-hook
    (defun flycheck-enable-markdownlint ()
      "Set the `mardkownlint' config file for the current buffer."
      (let* ((md-lint ".markdownlint.json")
             (md-file buffer-file-name)
             (md-lint-dir (and md-file
                               (locate-dominating-file md-file md-lint))))
        (setq-local flycheck-markdown-markdownlint-cli-config
                    (expand-file-name (concat md-lint-dir md-lint))))))

(use-package! grip-mode
  :defer t
  :commands (grip-mode)
  :init
  (map! (:map (markdown-mode-map org-mode-map)
          :localleader
          "v" #'grip-mode))
  :config
  (if (featurep 'xwidget-internal)
      ;; Use embedded webkit to previe
      (setq grip-preview-use-webkit t))
  ;; Setup xwidget window popup rule
  (set-popup-rule! "*xwidget" :side 'right :size .50 :select nil :quit t)
  ;; Setup github username and token for API auth
  (let ((credentials (auth-source-user-and-password "mygrip")))
    (setq grip-github-user (car credentials)
          grip-github-password (cadr credentials))))
