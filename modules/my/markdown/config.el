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
