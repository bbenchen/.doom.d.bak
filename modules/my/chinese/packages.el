;; -*- no-byte-compile: t; -*-
;;; my/chinese/packages.el

(package! rime
  :recipe (:host github :repo "DogLooksGood/emacs-rime" :files ("Makefile" "lib.c" "rime.el")))
(when (featurep! +childframe)
  (package! posframe))
