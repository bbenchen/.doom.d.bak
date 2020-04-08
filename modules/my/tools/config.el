;;; my/tools/config.el -*- lexical-binding: t; -*-

;; exec-path-from-shell
(use-package! exec-path-from-shell
  :init
  (when (or IS-LINUX IS-MAC)
    (setq exec-path-from-shell-check-startup-files nil)
    (setq exec-path-from-shell-arguments '("-l"))
    (setq exec-path-from-shell-variables '("TERM"
                                           "PATH"
                                           "MANPATH"
                                           "PYTHONPATH"
                                           "GO111MODULE"
                                           "GOPROXY"
                                           "GOBIN"
                                           "GOPATH"
                                           "JAVA_HOME"
                                           "JAVA_OPTS"
                                           "SBT_OPTS"
                                           "COURSIER_REPOSITORIES"
                                           "NVM_DIR"))
    (exec-path-from-shell-initialize)))
