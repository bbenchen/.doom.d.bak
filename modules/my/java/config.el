;;; my/java/config.el -*- lexical-binding: t; -*-

(after! exec-path-from-shell
  (exec-path-from-shell-copy-envs '("JAVA_HOME" "JAVA_OPTS")))

(after! lsp-java
  (setq lsp-java-jdt-download-url "http://mirrors.ustc.edu.cn/eclipse/jdtls/snapshots/jdt-language-server-latest.tar.gz"
        lsp-java-workspace-dir (concat doom-etc-dir "eclipse.jdt.ls/workspace/")
        lsp-java-workspace-cache-dir (concat lsp-java-workspace-dir ".cache/")
        lsp-jt-root (concat doom-etc-dir "eclipse.jdt.ls/server/java-test/server"))
  (let ((lombok-jar-path (expand-file-name "lombok.jar" doom-private-dir)))
    (setq lsp-java-vmargs (list "-Dfile.encoding=utf8"
                                "-noverify"
                                "-Xmx4G"
                                "-XX:+UseG1GC"
                                "-XX:+UseStringDeduplication"
                                (concat "-javaagent:" lombok-jar-path)
                                (concat "-Xbootclasspath/a:" lombok-jar-path))))
  (setq lsp-java-format-enabled nil
        lsp-java-format-comments-enabled nil
        lsp-java-format-on-type-enabled nil)
  ;; (setq lsp-java-format-settings-url (concat "file://" (expand-file-name "eclipse-java-google-style.xml" doom-private-dir)))
  ;; (setq lsp-java-format-settings-profile "GoogleStyle")
  (setq lsp-java-trace-server "messages")
  (setq lsp-java-maven-download-sources t)
  ;; Support java decompiler
  (setq lsp-java-content-provider-preferred "fernflower")
  (map! :map java-mode-map
        :localleader
        (:prefix ("r" . "reflect")
          :desc "organize-imports" "o" #'lsp-java-organize-imports
          :desc "rename" "n" #'lsp-rename
          (:prefix ("a" . "add")
            :desc "add-import" "i" #'lsp-java-add-import
            :desc "add-unimplemented-methods" "m" #'lsp-java-add-unimplemented-methods
            :desc "add-throws" "t" #'lsp-java-add-throws)
          (:prefix ("c" . "create/convert")
            :desc "create-parameter" "p" #'lsp-java-create-parameter
            :desc "create-field" "f" #'lsp-java-create-field
            :desc "conver-to-static-import" "i" #'lsp-java-convert-to-static-import)
          (:prefix ("e" . "extract")
            :desc "extract-to-constant" "c" #'lsp-java-extract-to-constant
            :desc "extract-to-local-variable" "l" #'lsp-java-extract-to-local-variable
            :desc "extract-method" "m" #'lsp-java-extract-method)
          (:prefix ("g" . "generate")
            :desc "generate-to-string" "t" #'lsp-java-generate-to-string
            :desc "generate-equals-and-hashcode" "e" #'lsp-java-generate-equals-and-hash-code
            :desc "generate-overrides" "o" #'lsp-java-generate-overrides
            :desc "generate-getters-and-setters" "g" #'lsp-java-generate-getters-and-setters))
        (:prefix ("c" . "create/compile")
          :desc "build-project" "c" #'lsp-java-build-project
          :desc "spring-initializr" "p" #'lsp-java-spring-initializr)
        (:prefix ("d" . "debug")
          :desc "debug-main" "j" #'dap-java-debug
          :desc "debug-test-method" "t" #'dap-java-debug-test-method
          :desc "debug-test-class" "c" #'dap-java-debug-test-class)
        (:prefix ("t" . "test")
          :desc "test-method" "t" #'dap-java-run-test-method
          :desc "test-class" "c" #'dap-java-run-test-class)))
