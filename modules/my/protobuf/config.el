;;; my/protobuf/config.el -*- lexical-binding: t; -*-

(use-package! protobuf-mode
  :init
  (add-hook! 'protobuf-mode-hook
    (defun setup-protobuf-imenu ()
      "Setup imenu regex for protocol buffers."
      (setq
       imenu-generic-expression
       '((nil "^[[:space:]]*\\(message\\|service\\|enum\\)[[:space:]]+\\([[:alnum:]]+\\)" 2)))))

  (add-hook! 'protobuf-mode-hook
    (display-line-numbers-mode t)))
