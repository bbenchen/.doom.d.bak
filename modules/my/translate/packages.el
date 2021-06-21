;; -*- no-byte-compile: t; -*-
;;; my/translate/packages.el

(package! youdao-dictionary :pin "8a4815a43565b9bfd257246e4895b8bfafb9d573")
(package! google-translate :pin "0f7f48a09bca064999ecea03102a7c96f52cbd1b")

(package! posframe :pin "739d8fd1081bdd0d20dee9e437d64df58747b871")

(when (featurep! :completion company)
  (package! company-english-helper
    :recipe (:host github :repo "cxb811201/company-english-helper")
    :pin "242bd431f7f25a15f033b5e441ec90624acd59cc"))

(package! insert-translated-name
  :recipe (:host github :repo "manateelazycat/insert-translated-name")
  :pin "a11b8f565006ca99995021ba70084e386dc2f0f5")

