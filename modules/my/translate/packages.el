;; -*- no-byte-compile: t; -*-
;;; my/translate/packages.el

(package! youdao-dictionary :pin "8a4815a43565b9bfd257246e4895b8bfafb9d573")

(when (featurep! +childframe)
  (package! posframe :pin "ae8ac91744010c8975f07cf18282f58ce56605d0"))

(when (featurep! :completion company)
  (package! company-english-helper
    :recipe (:host github :repo "cxb811201/company-english-helper")
    :pin "242bd431f7f25a15f033b5e441ec90624acd59cc"))

(package! insert-translated-name
  :recipe (:host github :repo "manateelazycat/insert-translated-name")
  :pin "a11b8f565006ca99995021ba70084e386dc2f0f5")

(package! english-teacher
  :recipe (:host github :repo "loyalpartner/english-teacher.el")
  :pin "772c0f70211cc4199eafe6c165341b347462880a")
