;;; my/debugger/config.el -*- lexical-binding: t; -*-

;; dap-mode
(use-package! dap-mode
  :when (featurep! :tools lsp)
  :after lsp-mode
  :init
  (setq dap-breakpoints-file (concat doom-etc-dir "dap/breakpoints")
        dap-utils-extension-path (concat doom-etc-dir "dap/extension")
        dap-java-test-runner (concat doom-etc-dir "eclipse.jdt.ls/server/test-runner/junit-platform-console-standalone.jar"))
  :config
  (dap-mode 1)
  (dap-ui-mode 1)

  (dolist (module '(((:lang . java) lsp-java dap-java)
                    ((:lang . go) go-mode dap-go)))
    (when (doom-module-p (caar module) (cdar module) '+lsp)
      (with-eval-after-load (nth 1 module)
        (mapc #'require (cddr module)))))

  (when (featurep! :lang javascript +lsp)
    (with-eval-after-load 'js2-mode
      (require 'dap-node)
      (require 'dap-chrome)))

  (map! :map (go-mode-map js2-mode-map)
        :leader
        (:prefix ("d" . "debug")
          "." #'dap-hydra
          "'" #'dap-ui-repl
          "d" #'dap-debug
          "l" #'dap-debug-last
          "r" #'dap-debug-recent)))
