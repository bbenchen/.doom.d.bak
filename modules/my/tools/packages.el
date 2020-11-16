;; -*- no-byte-compile: t; -*-
;;; my/tools/packages.el

(package! exec-path-from-shell :pin "4ea306a76f0f8371053dd12d77a3b5b4438974d3")
(package! command-log-mode :pin "af600e6b4129c8115f464af576505ea8e789db27")
(if IS-LINUX
    (package! eaf
      :recipe (:host github :repo "manateelazycat/emacs-application-framework" :files ("*"))
      :pin "328bff2d550a7ca34d7ffb73bd4f0a0d3f51c174"))
