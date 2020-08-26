;;; my/spell/config.el -*- lexical-binding: t; -*-

(after! ispell
  (setq ispell-dictionary "en_US"))

(if (featurep! :checkers spell +flyspell)
  (setq flyspell-delayed-commands nil))
