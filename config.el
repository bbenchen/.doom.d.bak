;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

;; (setq warning-minimum-level :error)

(setq fill-column 120)

(setq user-full-name "Chen Xianbin")
(setq user-mail-address "517926804@qq.com")
(setq default-directory "~/")
(setq org-directory "~/Documents/org")
(setq display-line-numbers-type 'relative)

;; theme
(setq doom-theme 'doom-one)

;; fonts
(when (and IS-LINUX (display-graphic-p))
  (setq doom-font (font-spec :family "Hack Nerd Font" :size 10))
  (setq doom-big-font (font-spec :family "Hack Nerd Font" :size 14))
  (+set-monospaced-font "Hack Nerd Font" "Noto Sans Mono CJK SC" 10 12))
(when (and IS-MAC (display-graphic-p))
  (setq doom-font (font-spec :family "Hack Nerd Font" :size 12))
  (setq doom-big-font (font-spec :family "Hack Nerd Font" :size 16))
  (+set-monospaced-font "Hack Nerd Font" "Hiragino Sans GB" 12 14))

;; window
(if (display-graphic-p)
    (progn
      ;; 不显示边框
      (set-frame-parameter nil 'undecorated t)
      (add-to-list 'default-frame-alist '(undecorated . t))
      ;; 窗口最大化
      (toggle-frame-maximized)
      (add-to-list 'default-frame-alist '(fullscreen . maximized))))

;; frame
(add-hook 'after-make-frame-functions #'(lambda (frame)
                                          (when (not (display-graphic-p frame))
                                            (select-frame frame)
                                            (doom/reload-theme))))

;; modeline
(after! doom-modeline
  (setq doom-modeline-major-mode-icon t
        doom-modeline-persp-name t
        doom-modeline-persp-name-icon t))

;; workspaces
(setq +workspaces-on-switch-project-behavior t)

;; iedit
(setq iedit-toggle-key-default nil)

;; pyim
(after! pyim
  (setq pyim-dcache-directory (expand-file-name "pyim/" doom-cache-dir)
        pyim-dcache-backend 'pyim-dregcache)
  (setq default-input-method "pyim")
  (if (and (fboundp 'posframe-workable-p)
           (posframe-workable-p))
      (setq pyim-page-tooltip 'posframe)
    (setq pyim-page-tooltip 'popup))
  (setq pyim-page-length 9)
  (setq-default pyim-english-input-switch-functions
                '(pyim-probe-program-mode
                  pyim-probe-isearch-mode
                  ;; pyim-probe-auto-english
                  pyim-probe-org-structure-template)))

;; liberime
(use-package! liberime-config
  :defer 1
  :init
  (add-hook 'after-liberime-load-hook #'(lambda ()
                                          (liberime-select-schema "wubi86_jidian_pinyin")))
  (setq liberime-user-data-dir (expand-file-name "rime/" doom-private-dir))
  ;; Use has been compiled liberime.so library in macos
  (if IS-MAC
      (setq liberime--module-file (expand-file-name "liberime.so" doom-private-dir)))
  :config
  (setq pyim-default-scheme 'rime))

;; multiple-cursors
(after! multiple-cursors-core
  (add-to-list 'mc/cmds-to-run-once 'counsel-M-x)
  (add-to-list 'mc/cmds-to-run-for-all 'hungry-delete-forward)
  (add-to-list 'mc/cmds-to-run-for-all 'hungry-delete-backward))

;; plantuml
(setq plantuml-jar-path (concat doom-private-dir "plantuml.jar")
      org-plantuml-jar-path plantuml-jar-path)

;; ranger
(after! ranger
  (setq ranger-excluded-extensions '("mkv" "iso" "mp4" "bin" "exe" "msi" "jar")))

;; magit
(after! magit
  (setq magit-revision-show-gravatars nil))

;; projectile
(after! projectile
  (setq projectile-project-search-path '("~/")
        projectile-files-cache-expire 3600)
  (add-to-list 'projectile-globally-ignored-file-suffixes ".bak")
  (add-to-list 'projectile-globally-ignored-directories ".bloop")
  (add-to-list 'projectile-globally-ignored-directories ".metals")
  (add-to-list 'projectile-project-root-files-bottom-up ".projectile"))

;; company
(after! company
  (setq company-idle-delay 0.2))

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

  (add-hook 'before-save-hook #'gofmt-before-save)

  (if (featurep! :tools flycheck)
      (add-hook! 'go-mode-hook
        (setq-local flycheck-disabled-checkers '(go-gofmt
                                                 go-golint
                                                 go-vet
                                                 go-build
                                                 go-test
                                                 go-errcheck
                                                 go-unconvert
                                                 go-staticcheck))))

  (map! (:when (featurep! :lang go +lsp)
          (:map go-mode-map
            :localleader
            (:prefix ("r" . "reflect")
              :desc "rename" "r" #'lsp-rename)))))

;; (use-package! go-rename
;;   :defer t
;;   :init
;;   (map! :map go-mode-map
;;         :localleader
;;         (:prefix ("r" . "reflect")
;;           "r" #'go-rename)))

(use-package! go-impl
  :defer t
  :init
  (map! :map go-mode-map
        :localleader
        (:prefix ("r" . "reflect")
          "I" #'go-impl))
  :config
  (setq go-impl-enter-function t))

(use-package! go-fill-struct
  :defer t
  :init
  (map! :map go-mode-map
        :localleader
        (:prefix ("r" . "reflect")
          "s" #'go-fill-struct)))

;; scala
(after! sbt-mode
  ;; sbt-supershell kills sbt-mode:  https://github.com/hvesalai/emacs-sbt-mode/issues/152
  (setq sbt:program-options '("-Dsbt.supershell=false")))

;; lsp
(after! lsp-mode
  (setq lsp-file-watch-threshold 1000)
  ;; metals
  (setq lsp-metals-sbt-script "sbt"
        lsp-metals-java-home (getenv "JAVA_HOME"))
  ;; gopls
  (setq lsp-gopls-staticcheck t
        lsp-gopls-complete-unimported t)
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
  (if (featurep! :tools flycheck)
      (add-hook! 'lsp-ui-mode-hook
        (defun go-enable-golangci-lint ()
          (when (memq major-mode '(go-mode))
            (message "[go] Setting lsp-prefer-ymake :none to enable golangci-lint support.")
            (setq-local lsp-prefer-flymake :none)
            (setq-local flycheck-checker 'golangci-lint))))))

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

;; sql
(after! sql
  (setq sql-product 'mysql))

(use-package! sqlup-mode
  :defer t
  :init
  (add-hook! '(sql-mode-hook sql-interactive-mode-hook) :append #'sqlup-mode)
  :config
  (setq sqlup-blacklist (append sqlup-blacklist '("name" "user"))))

(after! flycheck
  (add-hook! 'sql-mode-hook
    (defun sql-disable-flycheck ()
      "Disable `flycheck' for the current buffer."
      (flycheck-mode -1))))

;; markdown
(after! markdown-mode
  (add-hook! 'markdown-mode-hook
    (defun flycheck-enable-markdownlint ()
      "Set the `mardkownlint' config file for the current buffer."
      (let* ((md-lint ".markdownlint.json")
             (md-file buffer-file-name)
             (md-lint-dir (and md-file
                               (locate-dominating-file md-file md-lint))))
        (setq-local flycheck-markdown-markdownlint-cli-config
                    (expand-file-name (concat md-lint-dir md-lint))))))
  )

;; company-english-helper
(use-package! company-english-helper)

;; insert-translated-name
(use-package! insert-translated-name)

;; cal-china-x
(use-package! cal-china-x
  :config
  (progn
    (setq mark-holidays-in-calendar t)
    (setq cal-china-x-important-holidays cal-china-x-chinese-holidays)
    (setq cal-china-x-general-holidays '((holiday-lunar 1 15 "元宵节")
                                         (holiday-lunar 7 7 "七夕节")
                                         (holiday-lunar 9 9 "重阳节")
                                         ))
    (setq calendar-holidays
          (append cal-china-x-important-holidays
                  cal-china-x-general-holidays))))

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
                                           "METALS_ENABLED"
                                           "NVM_DIR"
                                           "YOUDAO_APP_KEY"
                                           "YOUDAO_SECRET_KEY"))
    (exec-path-from-shell-initialize)))

;; hungry-delete
(use-package! hungry-delete
  :config
  (setq-default hungry-delete-chars-to-skip " \t\f\v")
  (global-hungry-delete-mode))

;; keybindings
(map! (:when IS-LINUX
        "s-w" #'+delete-window
        "s-W" #'delete-frame
        "s-n" #'+default/new-buffer
        "s-k" #'doom/kill-this-buffer-in-all-windows
        "s-s" #'save-buffer
        "s-a" #'mark-whole-buffer
        "s-f" #'swiper
        "s-u" #'revert-buffer
        "s-z" #'undo
        "s-/" (λ! (save-excursion (comment-line 1))))

      :leader
      (:prefix-map ("f" . "file")
        :desc "Find file in dotfiles" "t" #'find-in-dotfiles
        :desc "Browse dotfiles" "T" #'browse-dotfiles))
