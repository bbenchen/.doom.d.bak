;; -*- no-byte-compile: t; -*-
;;; my/tools/packages.el

(package! centered-cursor-mode :pin "4093821cc9759ca5a3c6e527d4cc915fc3a5ad74")

(if (not (boundp 'pixel-scroll-precision-mode))
    (package! good-scroll :pin "a7ffd5c0e5935cebd545a0570f64949077f71ee3"))
