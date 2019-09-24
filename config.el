;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

;; (setq warning-minimum-level :error)

;; 384mb
(setq doom-gc-cons-threshold 402653184)

(setq fill-column 120)

(setq user-full-name "Chen Xianbin")
(setq user-mail-address "517926804@qq.com")

;; (setq display-line-numbers-type 'visual)

;; theme
(setq doom-theme 'doom-one)

;; fonts
(when (and IS-LINUX (display-graphic-p))
  (setq doom-font (font-spec :family "Hack Nerd Font" :size 10))
  (setq doom-big-font (font-spec :family "Hack Nerd Font" :size 14))
  (+set-monospaced-font "Hack Nerd Font" "WenQuanYi ZenHei Mono" 10 12))
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

;; check-large-file
(add-hook 'find-file-hook '+check-large-file)

;; pyim
(after! pyim
  (setq pyim-dcache-directory (expand-file-name "pyim/" doom-cache-dir))
  (setq default-input-method "pyim")
  (if (and EMACS26+ (featurep 'posframe))
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
  (add-hook 'after-liberime-load-hook
            (lambda ()
              (liberime-select-schema "wubi_pinyin")))
  :config
  (setq liberime-user-data-dir (expand-file-name "rime" doom-private-dir))
  (liberime-load)
  (setq pyim-default-scheme 'rime))

;; multiple-cursors
(after! multiple-cursors-core
  (add-to-list 'mc/cmds-to-run-once 'counsel-M-x)
  (add-to-list 'mc/cmds-to-run-for-all 'hungry-delete-forward)
  (add-to-list 'mc/cmds-to-run-for-all 'hungry-delete-backward))

;; org
(after! org
  (setq org-directory "~/Documents/org"))

;; ranger
(after! ranger
  (setq ranger-excluded-extensions '("mkv" "iso" "mp4" "bin" "exe" "msi" "jar")))

;; magit
(after! magit
  (setq magit-revision-show-gravatars nil))

;; projectile
(after! projectile
  (setq projectile-project-search-path '("~"))
  (add-to-list 'projectile-globally-ignored-files "*.elc")
  (add-to-list 'projectile-globally-ignored-files "*.bak")
  (add-to-list 'projectile-globally-ignored-directories ".bloop")
  (add-to-list 'projectile-globally-ignored-directories ".metals"))

;; go
(after! go-mode
  (when (executable-find "gopkgs")
    (defun go-packages-gopkgs ()
      "Return a list of all Go packages, using `gopkgs'."
      (sort (process-lines "gopkgs") #'string<))
    (setq go-packages-function 'go-packages-gopkgs))

  (if (executable-find "gogetdoc")
      (setq godoc-at-point-function 'godoc-gogetdoc))

  (let ((command (or (executable-find "goimports")
                     (executable-find "gofumports"))))
    (if command
        (setq gofmt-command command)))

  (add-hook 'before-save-hook 'gofmt-before-save))

(use-package! go-rename
  :defer t
  :init
  (map! :map go-mode-map
        :localleader
        "rn" #'go-rename))

;; lsp
(after! lsp-mode
  (setq lsp-file-watch-threshold 1000)
  (setq lsp-metals-sbt-script "sbt"
        lsp-metals-java-home (getenv "JAVA_HOME")))

(after! lsp-java
  (setq lsp-java-jdt-download-url "http://mirrors.ustc.edu.cn/eclipse/jdtls/snapshots/jdt-language-server-latest.tar.gz")
  (setq lsp-java-workspace-dir (concat doom-etc-dir "eclipse.jdt.ls/workspace/"))
  (setq lombok-jar-path (expand-file-name "lombok.jar" doom-private-dir))
  (setq lsp-java-vmargs (list "-Dfile.encoding=utf8"
                              "-noverify"
                              "-Xmx4G"
                              "-XX:+UseG1GC"
                              "-XX:+UseStringDeduplication"
                              (concat "-javaagent:" lombok-jar-path)
                              (concat "-Xbootclasspath/a:" lombok-jar-path)
                              ))
  (setq lsp-java-format-settings-url (concat "file://" (expand-file-name "eclipse-java-google-style.xml" doom-private-dir)))
  (setq lsp-java-format-settings-profile "GoogleStyle")
  (setq lsp-java-trace-server "messages")
  (setq lsp-java-maven-download-sources t))

;; dap-mode
(after! dap-mode
  (setq dap-java-test-runner (concat
                              (concat doom-etc-dir "eclipse.jdt.ls/server/")
                              "test-runner/junit-platform-console-standalone.jar")))

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
    (setq exec-path-from-shell-variables '("TERM" "PATH" "MANPATH" "PYTHONPATH" "GO111MODULE" "GOPROXY" "GOBIN" "GOPATH" "JAVA_HOME" "JAVA_OPTS" "SBT_OPTS" "METALS_ENABLED" "NVM_DIR"))
    (exec-path-from-shell-initialize)))

;; hungry-delete
(use-package! hungry-delete
  :config
  (setq-default hungry-delete-chars-to-skip " \t\f\v")
  (global-hungry-delete-mode))
