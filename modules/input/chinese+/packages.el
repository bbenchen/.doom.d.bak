;; -*- no-byte-compile: t; -*-
;;; input/chinese+/packages.el

(package! pyim)
(package! posframe)
(package! liberime
  :recipe (:host github
                 :repo "merrickluo/liberime"
                 :files ("liberime.el" "src" "CMakeLists.txt" "Makefile")))
