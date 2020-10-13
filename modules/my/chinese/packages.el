;; -*- no-byte-compile: t; -*-
;;; my/chinese/packages.el

(package! rime :pin "d2e2f65bea672273cbcbce4a9161264c383a41c2")
(when (featurep! +childframe)
  (package! posframe :pin "56f2c358000472eafef6015688dce2aab19349fbu"))
