;;; my/tools/config.el -*- lexical-binding: t; -*-

;; exec-path-from-shell
(use-package! exec-path-from-shell
  :init
  (when (or IS-LINUX IS-MAC)
    (setq exec-path-from-shell-warn-duration-millis 2000)
    (setq exec-path-from-shell-arguments '("-l"))
    (setq exec-path-from-shell-variables '("LANG"
                                           "LC_ALL"
                                           "TERM"
                                           "PATH"
                                           "MANPATH"
                                           "JAVA_HOME"
                                           "JAVA_OPTS"
                                           "SBT_OPTS"
                                           "GOPATH"
                                           "GOBIN"
                                           "GO111MODULE"
                                           "GOPROXY"))
    ;; (setq exec-path-from-shell-debug t)
    (exec-path-from-shell-initialize)))

(use-package! command-log-mode
  :commands global-command-log-mode
  :config
  (setq command-log-mode-auto-show t))
