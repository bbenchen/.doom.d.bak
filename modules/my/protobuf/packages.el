;; -*- no-byte-compile: t; -*-
;;; my/protobuf/packages.el

(package! protobuf-mode
  :recipe (:host github :repo "emacsmirror/protobuf-mode" :files ("*.el"))
  :pin "6aec2b16818093a65758d30d8d6106b48776000f")
