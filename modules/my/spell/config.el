;;; my/spell/config.el -*- lexical-binding: t; -*-

(after! ispell
  (setq ispell-dictionary "en_US"))

(when (featurep! :checkers spell)
  (after! nxml-mode
    (add-hook! 'nxml-mode-hook
      (defun disable-spell-for-xml()
        (if (featurep! :checkers spell +flyspell)
            (flyspell-mode -1)
          (spell-fu-mode -1))))))
