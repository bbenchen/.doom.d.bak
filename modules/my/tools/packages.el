;; -*- no-byte-compile: t; -*-
;;; my/tools/packages.el

(if IS-MAC
    (package! exec-path-from-shell :pin "dff9ce3577bf3f2938d9bde8ec8aa4fef3b061f3"))
(package! command-log-mode :pin "af600e6b4129c8115f464af576505ea8e789db27")

(if IS-LINUX
    (package! epc :pin "e1bfa5ca163273859336e3cc89b4b6460f7f8cda"))
