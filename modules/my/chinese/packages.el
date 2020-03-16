;; -*- no-byte-compile: t; -*-
;;; my/chinese/packages.el

(package! pyim)
(package! liberime
  :recipe (:host github
                 :repo "merrickluo/liberime"
                 :files ("liberime.el" "src" "CMakeLists.txt" "Makefile")))
(when (featurep! +childframe)
  (package! posframe))
