;; -*- no-byte-compile: t; -*-
;;; ~/.doom.d/packages.el

(unpin! (:completion company ivy) (:ui doom) (:emacs ibuffer) (:checkers spell) (:term vterm) (:tools magit debugger lsp) (:lang java scala))

(package! restclient :pin "94d2e8421fa14d0e3307d70e1d1e2db9d43b2f95")
