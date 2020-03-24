;;; my/protobuf/config.el -*- lexical-binding: t; -*-

(after! protobuf-mode
  (add-hook! 'protobuf-mode-hook
    (defun setup-protobuf-imenu ()
      "Setup imenu regex for protocol buffers."
      (setq
       imenu-generic-expression
       '((nil "^[[:space:]]*\\(message\\|service\\|enum\\)[[:space:]]+\\([[:alnum:]]+\\)" 2)))))

  (add-hook! 'protobuf-mode-hook
             (display-line-numbers-mode t)))
