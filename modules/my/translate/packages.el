;; -*- no-byte-compile: t; -*-
;;; my/translate/packages.el

(package! youdao-dictionary :pin "8a4815a43565b9bfd257246e4895b8bfafb9d573")
(package! google-translate :pin "0f7f48a09bca064999ecea03102a7c96f52cbd1b")

(package! posframe :pin "c91d4d53fa479ceb604071008ce0a901770eff57")

(when (featurep! :completion company)
  (package! company-english-helper
    :recipe (:host github :repo "cxb811201/company-english-helper")
    :pin "5c8ead05988ab6e6351825af83a93dbf1cff0392"))

(package! insert-translated-name
  :recipe (:host github :repo "manateelazycat/insert-translated-name")
  :pin "ff2c2cfac801c155b72fafdb39414b9de30d1d41")
