;;; my/scala/config.el -*- lexical-binding: t; -*-

(after! exec-path-from-shell
  (exec-path-from-shell-copy-envs '("JAVA_HOME" "JAVA_OPTS" "SBT_OPTS")))

;; projectile
(after! projectile
  (dolist (dir '(".bloop" ".metals"))
    (add-to-list 'projectile-globally-ignored-directories dir)))

;; scala
(after! scala-mode
  (map! :map scala-mode-map
        :localleader
        (:prefix ("b" . "sbt")
          "." #'sbt-hydra
          "b" #'sbt-command)))

;; sbt
(after! sbt-mode
  ;; sbt-supershell kills sbt-mode:  https://github.com/hvesalai/emacs-sbt-mode/issues/152
  (setq sbt:program-options '("-Dsbt.supershell=false")))

;; lsp-mode
(after! lsp-mode
  ;; metals
  (setq lsp-metals-sbt-script "sbt"
        lsp-metals-java-home (getenv "JAVA_HOME")))
