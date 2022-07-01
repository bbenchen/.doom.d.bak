;; -*- no-byte-compile: t; -*-
;;; ~/.doom.d/packages.el

(unpin! (:editor multiple-cursors) (:checkers spell) (:term vterm) (:email mu4e))

(if (featurep! :email mu4e +org)
    (package! org-msg :pin "60e22e446325a9b3387396459d98be7c1c52579d"))
