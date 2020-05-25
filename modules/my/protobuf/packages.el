;; -*- no-byte-compile: t; -*-
;;; my/protobuf/packages.el

(package! protobuf-mode
  :recipe (:host github :repo "emacsmirror/protobuf-mode" :files ("*.el"))
  :pin "94b7bd7e8b87ff100c603153d2f8d7a2a08ab50b")
