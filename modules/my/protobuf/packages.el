;; -*- no-byte-compile: t; -*-
;;; my/protobuf/packages.el

(package! protobuf-mode
  :recipe (:host github :repo "emacsmirror/protobuf-mode" :files ("*.el"))
  :pin "08557364b8187ac25b008782d8acab84a69d8881")
