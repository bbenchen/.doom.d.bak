;;; my/lsp/config.el -*- lexical-binding: t; -*-

;; lsp
(setq +lsp-company-backend 'company-capf)
(after! lsp-mode
  (setq lsp-enable-snippet nil
        lsp-enable-folding nil
        lsp-enable-links nil
        lsp-enable-symbol-highlighting nil
        lsp-file-watch-threshold 5000)

  ;; don't scan 3rd party javascript libraries
  (push "[/\\\\][^/\\\\]*\\.\\(json\\|html\\|jade\\)$" lsp-file-watch-ignored) ;; json

  ;; metals
  (setq lsp-metals-sbt-script "sbt"
        lsp-metals-java-home (getenv "JAVA_HOME"))
  ;; kotlin
  (setq lsp-kotlin-language-server-path (concat doom-etc-dir "kotlin/server/bin/kotlin-language-server")
        lsp-kotlin-debug-adapter-path (concat doom-etc-dir "kotlin/adapter/bin/kotlin-debug-adapter"))

  (when (or (featurep! :completion ivy)
            (featurep! :completion helm))

    (when (featurep! :completion ivy)
      (defalias '+lookup/workspace-symbol #'lsp-ivy-workspace-symbol)
      (defalias '+lookup/global-workspace-symbol #'lsp-ivy-global-workspace-symbol))

    (when (featurep! :completion helm)
      (defalias '+lookup/workspace-symbol #'helm-lsp-workspace-symbol)
      (defalias '+lookup/global-workspace-symbol #'helm-lsp-global-workspace-symbol))

    (map! :leader
          (:prefix-map ("g" . "lookup")
            "s" #'+lookup/workspace-symbol
            "S" #'+lookup/global-workspace-symbol))))

(after! lsp-ui
  ;; (if (featurep! :checkers syntax)
  ;;     (add-hook! 'lsp-ui-mode-hook
  ;;       (defun go-enable-golangci-lint ()
  ;;         (when (memq major-mode '(go-mode))
  ;;           (message "[go] Setting lsp-prefer-ymake :none to enable golangci-lint support.")
  ;;           (setq-local lsp-prefer-flymake :none)
  ;;           (setq-local flycheck-checker 'golangci-lint)))))

  (setq lsp-ui-doc-enable t
        lsp-ui-doc-max-width 150
        lsp-ui-doc-max-height 30
        lsp-ui-doc-use-webkit nil
        lsp-ui-doc-delay 0.2
        lsp-ui-doc-include-signature t
        lsp-ui-doc-position 'at-point
        lsp-ui-doc-border (face-foreground 'default)
        lsp-eldoc-enable-hover nil      ; Disable eldoc displays in minibuffer

        lsp-ui-sideline-enable t
        lsp-ui-sideline-show-hover nil
        lsp-ui-sideline-show-diagnostics nil
        lsp-ui-sideline-ignore-duplicate t

        lsp-ui-imenu-enable t
        lsp-ui-imenu-colors `(,(face-foreground 'font-lock-keyword-face)
                              ,(face-foreground 'font-lock-string-face)
                              ,(face-foreground 'font-lock-constant-face)
                              ,(face-foreground 'font-lock-variable-name-face)))

  ;; (add-to-list 'lsp-ui-doc-frame-parameters '(right-fringe . 8))

  ;; `C-g'to close doc
  (advice-add #'keyboard-quit :before #'lsp-ui-doc-hide)

  ;; Reset `lsp-ui-doc-background' after loading theme
  (add-hook! 'after-load-theme-hook
    (setq lsp-ui-doc-border (face-foreground 'default))
    (set-face-background 'lsp-ui-doc-background
                         (face-background 'tooltip))))

;; lsp-treemacs
(use-package! lsp-treemacs
  :when (featurep! :tools lsp)
  :config
  (lsp-metals-treeview-enable t)
  (setq lsp-metals-treeview-show-when-views-received nil))
