;;; my/dired/config.el -*- lexical-binding: t; -*-

;; dired
(after! dired
  (setq dired-recursive-copies 'always
        dired-recursive-deletes 'always))

;; ranger
(after! ranger
  (setq ranger-excluded-extensions '("mkv" "iso" "mp4" "bin" "exe" "msi" "jar")))
