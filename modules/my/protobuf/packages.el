;; -*- no-byte-compile: t; -*-
;;; my/protobuf/packages.el

(package! protobuf-mode
  :recipe (:host github :repo "emacsmirror/protobuf-mode" :files ("*.el"))
  :pin "34d2bec69ddec511ec2dd4a8108fb920c27efe11")
