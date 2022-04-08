;; -*- no-byte-compile: t; -*-
;;; my/protobuf/packages.el

(package! protobuf-mode
  :recipe (:host github :repo "emacsmirror/protobuf-mode" :files ("*.el"))
  :pin "745044422c9062e5cffbfbba33c030c30f9c0694")
