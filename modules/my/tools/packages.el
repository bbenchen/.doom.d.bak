;; -*- no-byte-compile: t; -*-
;;; my/tools/packages.el

(package! exec-path-from-shell :pin "d14d6d2966efe5a1409f84a6b9d998268f74761d")
(package! command-log-mode :pin "af600e6b4129c8115f464af576505ea8e789db27")
(when IS-LINUX
  (package! eaf
    :recipe (:host github :repo "manateelazycat/emacs-application-framework" :files ("*"))
    :pin "8643126f7bfd151a73c9c4046cd24db31eac4339")
  (package! epc :pin "e1bfa5ca163273859336e3cc89b4b6460f7f8cda"))
