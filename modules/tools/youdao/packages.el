;; -*- no-byte-compile: t; -*-
;;; tools/youdao-dictionary/packages.el

(package! youdao-dictionary)
(when (and EMACS26+ (featurep! +childframe))
  (package! posframe))
