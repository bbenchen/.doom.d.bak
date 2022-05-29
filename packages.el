;; -*- no-byte-compile: t; -*-
;;; ~/.doom.d/packages.el

(unpin! (:completion vertico) (:ui doom modeline treemacs) (:editor multiple-cursors) (:checkers spell) (:term vterm) (:tools magit debugger lsp) (:lang java scala) (:email mu4e))

(if (featurep! :email mu4e +org)
    (package! org-msg :pin "60e22e446325a9b3387396459d98be7c1c52579d"))
(package! restclient :pin "9e2cfa86529133eba6c9ef53794be182f15e4c21")
