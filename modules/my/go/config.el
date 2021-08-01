;;; my/go/config.el -*- lexical-binding: t; -*-

;; go
(after! go-mode
  (when (executable-find "gopkgs")
    (defun go-packages-gopkgs ()
      "Return a list of all Go packages, using `gopkgs'."
      (if-let (project-root (doom-project-root))
          (sort (process-lines "gopkgs" "-workDir" project-root) #'string<)
        (sort (process-lines "gopkgs") #'string<)))
    (setq go-packages-function 'go-packages-gopkgs))

  (if (executable-find "gogetdoc")
      (setq godoc-at-point-function 'godoc-gogetdoc))

  (let ((command (or (executable-find "gofumports")
                     (executable-find "goimports"))))
    (if command
        (setq gofmt-command command)))

  ;; (add-hook 'before-save-hook #'gofmt-before-save)

  (if (featurep! :checkers syntax)
      (add-hook! 'go-mode-hook
        (setq-local flycheck-disabled-checkers '(go-gofmt
                                                 go-golint
                                                 go-vet
                                                 go-build
                                                 go-test
                                                 go-errcheck
                                                 go-unconvert
                                                 go-staticcheck))))

  (when (featurep! :tools lsp)
    (defadvice! godef-describe-a (_point)
      :override #'godef-describe
      (lsp-describe-thing-at-point)))

  (map! (:when (featurep! :tools lsp)
         (:map go-mode-map
          :localleader
          (:prefix ("r" . "reflect")
           :desc "rename" "r" #'lsp-rename)))))

(after! lsp-mode
  (lsp-register-custom-settings
   '(("gopls.completeUnimported" t t))))

;; (use-package! go-impl
;;   :defer t
;;   :init
;;   (map! :map go-mode-map
;;         :localleader
;;         (:prefix ("r" . "reflect")
;;          "I" #'go-impl))
;;   :config
;;   (setq go-impl-enter-function t))

(use-package! go-fill-struct
  :defer t
  :init
  (map! :map go-mode-map
        :localleader
        (:prefix ("r" . "reflect")
         "s" #'go-fill-struct)))
