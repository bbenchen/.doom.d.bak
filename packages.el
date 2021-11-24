;; -*- no-byte-compile: t; -*-
;;; ~/.doom.d/packages.el

(unpin! (:ui doom modeline treemacs) (:checkers spell) (:term vterm) (:tools magit debugger lsp) (:lang java scala) (:email mu4e))

(if (featurep! :lang java)
    (package! lsp-java
      :recipe (:host github :repo "cxb811201/lsp-java")
      :pin "6d2b0a62d8999793dda31f6f75031abf0fd40fb3"))
(if (featurep! :email mu4e +org)
    (package! org-msg :pin "77f5911b7d390a069104db20be86293506ffbff2"))
(package! restclient :pin "94d2e8421fa14d0e3307d70e1d1e2db9d43b2f95")
