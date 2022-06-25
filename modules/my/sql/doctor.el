;;; my/sql/doctor.el -*- lexical-binding: t; -*-

(when (featurep! :checkers syntax)
  (unless (executable-find "sqlint")
    (warn! "Couldn't find sqlint. Syntax checking will not work")))
