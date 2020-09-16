;; -*- no-byte-compile: t; -*-
;;; my/chinese/packages.el

(package! rime :pin "9d139b56b45e91b787031f5b86c3462287d6ef29")
(when (featurep! +childframe)
  (package! posframe :pin "5696463afe2b0bc7b9c2705663daf9afc7ef18ad"))
