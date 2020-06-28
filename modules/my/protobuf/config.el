;;; my/protobuf/config.el -*- lexical-binding: t; -*-

(use-package! protobuf-mode
  :init
  (add-hook! 'protobuf-mode-hook
    (display-line-numbers-mode t)))
