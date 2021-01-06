;; -*- no-byte-compile: t; -*-
;;; my/chinese/packages.el

(package! rime :pin "2bc3035c626d65d9e3d5b54814bc28f8db18ab3e")
(when (featurep! +childframe)
  (package! posframe :pin "ae8ac91744010c8975f07cf18282f58ce56605d0"))
