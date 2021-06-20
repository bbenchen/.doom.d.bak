;;; my/java/config.el -*- lexical-binding: t; -*-

(after! lsp-java
  (setq lsp-java-jdt-download-url "https://mirrors.tuna.tsinghua.edu.cn/eclipse/jdtls/snapshots/jdt-language-server-latest.tar.gz")
  (let ((lombok-jar-path (expand-file-name "lombok.jar" doom-private-dir)))
    (setq lsp-java-vmargs (list "-Dfile.encoding=utf8"
                                "-server"
                                "-noverify"
                                "-Xms4G"
                                "-Xmx4G"
                                "-Xmn2G"
                                "-Xss512K"
                                "-XX:MetaspaceSize=256M"
                                "-XX:MaxMetaspaceSize=512M"
                                "-XX:ReservedCodeCacheSize=256M"
                                "-XX:+UseG1GC"
                                "-XX:+UseStringDeduplication"
                                (concat "-javaagent:" lombok-jar-path))))

  (setq lsp-java-configuration-runtimes (cond (IS-MAC '[(:name "JavaSE-11"
                                                         :path "/Library/Java/JavaVirtualMachines/openjdk-11.jdk/Contents/Home"
                                                         :default t)
                                                        (:name "JavaSE-1.8"
                                                         :path "/Library/Java/JavaVirtualMachines/openjdk-8.jdk/Contents/Home")])
                                              (IS-LINUX '[(:name "JavaSE-11"
                                                           :path "/usr/lib/jvm/java-11-openjdk"
                                                           :default t)
                                                          (:name "JavaSE-1.8"
                                                           :path "/usr/lib/jvm/java-8-openjdk")])
                                              (t nil)))

  (if-let ((java-home (getenv "JAVA_HOME")))
      (setq lsp-java-java-path (concat java-home "/bin/java")))

  (setq lsp-java-format-enabled t
        lsp-java-format-comments-enabled t
        lsp-java-format-on-type-enabled nil
        lsp-java-format-settings-url (concat "file://" (expand-file-name "eclipse-java-google-style.xml" doom-private-dir))
        lsp-java-format-settings-profile "GoogleStyle"
        lsp-java-trace-server "messages"
        lsp-java-maven-download-sources t
        ;; Support java decompiler
        lsp-java-content-provider-preferred "fernflower")

  (when (featurep! :tools debugger +lsp)
    (setq lsp-jt-root (concat lsp-java-server-install-dir "java-test/server/")
          dap-java-test-runner (concat lsp-java-server-install-dir "test-runner/junit-platform-console-standalone.jar"))))
