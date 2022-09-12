;; -*- no-byte-compile: t; -*-
;;; my/translate/packages.el

(package! google-translate :pin "f2b4534d4554c2103ed8084353c94c9cdc5cb24c")

(package! posframe :pin "0d23bc5f7cfac00277d83ae7ba52c48685bcbc68")

(when (modulep! :completion company)
  (package! company-english-helper
    :recipe (:host github :repo "cxb811201/company-english-helper")
    :pin "5c8ead05988ab6e6351825af83a93dbf1cff0392"))

(package! insert-translated-name
  :recipe (:host github :repo "manateelazycat/insert-translated-name")
  :pin "ff2c2cfac801c155b72fafdb39414b9de30d1d41")
