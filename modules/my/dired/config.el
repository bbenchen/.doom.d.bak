;;; my/dired/config.el -*- lexical-binding: t; -*-

;; dired
(after! dired
  (setq dired-recursive-copies 'always
        dired-recursive-deletes 'always)
  (if (boundp 'dired-kill-when-opening-new-dired-buffer)
      (setq dired-kill-when-opening-new-dired-buffer t)))

(after! all-the-icons-dired
  ;; display icons with colors
  (setq all-the-icons-dired-monochrome nil))
