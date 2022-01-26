;; -*- no-byte-compile: t; -*-
;;; my/tools/packages.el

(if IS-MAC
    (package! exec-path-from-shell :pin "3a8d97c096c2c5714b667130fd8a80d5622ee067"))
(package! command-log-mode :pin "af600e6b4129c8115f464af576505ea8e789db27")

(if IS-LINUX
    (package! epc :pin "e1bfa5ca163273859336e3cc89b4b6460f7f8cda"))
