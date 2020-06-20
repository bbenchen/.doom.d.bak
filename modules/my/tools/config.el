;;; my/tools/config.el -*- lexical-binding: t; -*-

;; exec-path-from-shell
(use-package! exec-path-from-shell
  :init
  (when (or IS-LINUX IS-MAC)
    (setq exec-path-from-shell-check-startup-files nil)
    (setq exec-path-from-shell-arguments '("-l"))
    (setq exec-path-from-shell-variables '("LANG" "TERM" "PATH" "MANPATH"))
    (exec-path-from-shell-initialize))
  :config
  (if IS-MAC
      (after! projectile
        (cond
         ;; If fd exists, use it for git and generic projects. fd is a rust program
         ;; that is significantly faster than git ls-files or find, and it respects
         ;; .gitignore. This is recommended in the projectile docs.
         ((executable-find doom-projectile-fd-binary)
          (setq projectile-generic-command
                ;; `projectile-generic-command' doesn't typically support a function.
                ;; My `doom--only-use-generic-command-a' advice allows this. I do it
                ;; this way so that future changes to
                ;; `projectile-globally-ignored-directories' are respected.
                (lambda (_)
                  (concat (format "%s . -0 -H -E .git --color=never --type file --type symlink --follow"
                                  doom-projectile-fd-binary)
                          (cl-loop for dir in projectile-globally-ignored-directories
                                   concat " -E "
                                   concat (shell-quote-argument dir))))
                projectile-git-submodule-command nil
                ;; ensure Windows users get fd's benefits
                projectile-indexing-method 'alien))

         ;; Otherwise, resort to ripgrep, which is also faster than find
         ((executable-find "rg")
          (setq projectile-generic-command
                (lambda (_)
                  (concat "rg -0 --files --follow --color=never --hidden"
                          (cl-loop for dir in projectile-globally-ignored-directories
                                   concat " --glob "
                                   concat (shell-quote-argument (concat "!" dir)))))
                projectile-git-submodule-command nil
                ;; ensure Windows users get rg's benefits
                projectile-indexing-method 'alien))))))
