;; -*- no-byte-compile: t; -*-
;;; my/chinese/packages.el

(package! rime :pin "56f2c358000472eafef6015688dce2aab19349fb")
(when (featurep! +childframe)
  (package! posframe :pin "56f2c358000472eafef6015688dce2aab19349fbu"))
