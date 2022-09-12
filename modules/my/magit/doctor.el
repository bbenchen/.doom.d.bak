;;; my/magit/doctor.el -*- lexical-binding: t; -*-

(when (and (modulep! +svn)
           (or (not (executable-find "svn"))
               (not (executable-find "magit-svn"))))
  (warn! "Couldn't find svn or magit-svn."))
