;;; my/dired/config.el -*- lexical-binding: t; -*-

;; dired
(after! dired
  (setq dired-recursive-copies 'always
        dired-recursive-deletes 'always)
  (if (boundp 'dired-kill-when-opening-new-dired-buffer)
      (setq dired-kill-when-opening-new-dired-buffer t)))

;; ranger
(after! ranger
  (setq ranger-excluded-extensions '("mkv" "iso" "mp4" "bin" "exe" "msi" "jar")))
