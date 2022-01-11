;; -*- no-byte-compile: t; -*-
;;; my/sql/packages.el

(package! sqlup-mode :pin "3f9df9c88d6a7f9b1ae907e401cad8d3d7d63bbf")
(package! sql-indent
  :recipe (:host github :repo "alex-hhh/emacs-sql-indent")
  :pin "ca2fa754dc32810402765621105a5f392feeed21")
(package! ob-sql-mode :pin "b31a016585324ad91f1742ff6205bcb76f3ece6e")
