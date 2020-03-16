;; -*- no-byte-compile: t; -*-
;;; my/translate/packages.el

(package! youdao-dictionary)

(when (featurep! +childframe)
  (package! posframe))

(when (featurep! :completion company)
  (package! company-english-helper :recipe (:host github :repo "cxb811201/company-english-helper")))

(package! insert-translated-name :recipe (:host github :repo "manateelazycat/insert-translated-name"))
