;; -*- no-byte-compile: t; -*-
;;; my/chinese/packages.el

(package! rime :pin "c797c443886aca6083737a3644e45af51f5b6760")
(when (featurep! +childframe)
  (package! posframe :pin "e1552c82dffaadc5e7de09a44880a498197ffbee"))
