;; -*- no-byte-compile: t; -*-
;;; my/sql/packages.el

(package! sqlup-mode :pin "3f9df9c88d6a7f9b1ae907e401cad8d3d7d63bbf")
(package! sql-indent
  :recipe (:host github :repo "alex-hhh/emacs-sql-indent")
  :pin "7af0298513616ddc6acf54a2b77bf5d0123c0102")
(package! ob-sql-mode :pin "b31a016585324ad91f1742ff6205bcb76f3ece6e")
