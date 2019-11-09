;; -*- no-byte-compile: t; -*-
;;; tools/youdao-dictionary/packages.el

(package! youdao-dictionary)
(when (featurep! +childframe)
  (package! posframe))
