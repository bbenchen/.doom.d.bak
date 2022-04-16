;;; my/java/config.el -*- lexical-binding: t; -*-

(after! lsp-java
  (setq lsp-java-jdt-download-url "https://mirrors.tuna.tsinghua.edu.cn/eclipse/jdtls/snapshots/jdt-language-server-latest.tar.gz")
  (let ((lombok-jar-path (expand-file-name "lombok.jar" doom-private-dir)))
    (setq lsp-java-vmargs (list "-Dfile.encoding=utf8"
                                "-server"
                                "-noverify"
                                "-Xms6G"
                                "-Xmx6G"
                                "-Xmn2G"
                                "-Xss512K"
                                "-XX:MetaspaceSize=1536M"
                                "-XX:MaxMetaspaceSize=1536M"
                                "-XX:InitialCodeCacheSize=128M"
                                "-XX:ReservedCodeCacheSize=512M"
                                "-XX:+UseG1GC"
                                "-XX:+UseStringDeduplication"
                                "-XX:GCTimeRatio=19"
                                "-XX:AdaptiveSizePolicyWeight=90"
                                "-Dsun.zip.disableMemoryMapping=true"
                                (concat "-javaagent:" lombok-jar-path))))

  (setq lsp-java-configuration-runtimes (cond (IS-MAC '[(:name "JavaSE-11"
                                                         :path "/Library/Java/JavaVirtualMachines/temurin-11.jdk/Contents/Home"
                                                         :default t)
                                                        (:name "JavaSE-1.8"
                                                         :path "/Library/Java/JavaVirtualMachines/temurin-8.jdk/Contents/Home")])
                                              (IS-LINUX '[(:name "JavaSE-11"
                                                           :path "/usr/lib/jvm/java-11-openjdk"
                                                           :default t)
                                                          (:name "JavaSE-1.8"
                                                           :path "/usr/lib/jvm/java-8-openjdk")])
                                              (t nil)))

  (if-let ((java-home (getenv "JAVA_HOME")))
      (setq lsp-java-java-path (concat java-home "/bin/java")))

  (setq lsp-java-format-enabled nil
        lsp-java-format-on-type-enabled nil
        lsp-java-completion-max-results 200
        lsp-java-trace-server "messages"
        lsp-java-maven-download-sources t
        ;; Support java decompiler
        lsp-java-content-provider-preferred "fernflower")

  (if (and (featurep! :editor format)
           (featurep! +google-java-format))
      (progn
        (set-formatter! 'google-java-format
          '("google-java-format" "-" "-a" "-" "--skip-sorting-imports" "-" "--skip-javadoc-formatting")
          :modes 'java-mode)

        (setq-hook! 'java-mode-hook
          tab-width 4
          fill-column 120))
    (setq lsp-java-format-enabled t
          lsp-java-format-comments-enabled t)))
