;;; my/spell/config.el -*- lexical-binding: t; -*-

(after! ispell
  (setq ispell-dictionary "en_US")
  (setq ispell-alternate-dictionary (expand-file-name "english-words" doom-private-dir))

  (defadvice! +ispell-lookup-words-a (orig &rest args)
    :around #'ispell-lookup-words
    (shut-up (apply orig args))))

(when (featurep! :checkers spell)
  (after! nxml-mode
    (add-hook! 'nxml-mode-hook
      (defun disable-spell-for-xml()
        (if (featurep! :checkers spell +flyspell)
            (flyspell-mode -1)
          (spell-fu-mode -1))))))
