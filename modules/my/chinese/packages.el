;; -*- no-byte-compile: t; -*-
;;; my/chinese/packages.el

(package! rime :pin "daf956df30d4007f70a4495560d656e517ab69a9")
(when (featurep! +childframe)
  (package! posframe :pin "c4459028fbe6740315ff1ed6f37e8c4decd3d050"))
