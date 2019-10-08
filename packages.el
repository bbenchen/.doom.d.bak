;; -*- no-byte-compile: t; -*-
;;; ~/.doom.d/packages.el

(package! fcitx :disable t)
(package! pangu-spacing :disable t)
(package! tide :disable t)
(package! liberime-config
  :recipe (:host github
                 :repo "xhcoding/liberime"
                 :files ("liberime-config.el" "src" "CMakeLists.txt" "Makefile")))
(package! company-english-helper :recipe (:host github :repo "manateelazycat/company-english-helper"))
(package! insert-translated-name :recipe (:host github :repo "manateelazycat/insert-translated-name"))
(package! cal-china-x)
(package! exec-path-from-shell)
(package! hungry-delete)
(package! go-rename)
(package! go-impl)
(package! sqlup-mode)
(package! dap-mode)
