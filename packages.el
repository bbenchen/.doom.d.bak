;; -*- no-byte-compile: t; -*-
;;; ~/.doom.d/packages.el

(unpin! (:completion vertico) (:ui doom modeline treemacs) (:checkers spell) (:term vterm) (:tools magit debugger lsp) (:lang java scala) (:email mu4e))

(if (featurep! :email mu4e +org)
    (package! org-msg :pin "77f5911b7d390a069104db20be86293506ffbff2"))
(package! restclient :pin "9e2cfa86529133eba6c9ef53794be182f15e4c21")
