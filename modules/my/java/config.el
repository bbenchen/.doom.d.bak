;;; my/java/config.el -*- lexical-binding: t; -*-

(after! exec-path-from-shell
  (exec-path-from-shell-copy-envs '("JAVA_HOME" "JAVA_OPTS")))

(after! lsp-java
  (setq lsp-java-jdt-download-url "https://mirrors.tuna.tsinghua.edu.cn/eclipse/jdtls/snapshots/jdt-language-server-latest.tar.gz")
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
        lsp-java-format-on-type-enabled nil
        lsp-java-format-settings-url (concat "file://" (expand-file-name "eclipse-java-google-style.xml" doom-private-dir))
        lsp-java-format-settings-profile "GoogleStyle"
        lsp-java-trace-server "messages"
        lsp-java-maven-download-sources t
        ;; Support java decompiler
        lsp-java-content-provider-preferred "fernflower"))

(when (and (featurep! :editor format)
           (featurep! +google-java-format))
  (set-formatter! 'google-java-format
    '("google-java-format" "-")
    :modes 'java-mode)

  ;; Enforce Google Java Style Guide.
  ;; See https://google.github.io/styleguide/javaguide.html
  (setq-hook! 'java-mode-hook
    tab-width 2
    fill-column 120))
