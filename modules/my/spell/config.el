;;; my/spell/config.el -*- lexical-binding: t; -*-

(after! ispell
  (setq ispell-dictionary "en_US")
  (setq ispell-alternate-dictionary (expand-file-name "english-words" doom-user-dir))

  (advice-add #'ispell-lookup-words :around #'doom-shut-up-a))

(when (modulep! :checkers spell)
  (after! nxml-mode
    (add-hook! 'nxml-mode-hook
      (defun disable-spell-for-xml()
        (if (modulep! :checkers spell +flyspell)
            (flyspell-mode -1)
          (spell-fu-mode -1))))))
