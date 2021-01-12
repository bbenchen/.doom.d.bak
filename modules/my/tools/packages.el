;; -*- no-byte-compile: t; -*-
;;; my/tools/packages.el

(package! exec-path-from-shell :pin "d14d6d2966efe5a1409f84a6b9d998268f74761d")
(package! command-log-mode :pin "af600e6b4129c8115f464af576505ea8e789db27")
(if IS-LINUX
    (package! eaf
      :recipe (:host github :repo "manateelazycat/emacs-application-framework" :files ("*"))
      :pin "f28acac25c283a1fdc737cb8565050091e9ae92d"))
